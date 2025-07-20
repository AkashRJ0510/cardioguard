import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import '../../services/heart_rate_service.dart';

class HeartRateScreen extends StatefulWidget {
  const HeartRateScreen({super.key});

  @override
  State<HeartRateScreen> createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
  final HeartRateService _service = HeartRateService();
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _measuring = false;
  bool _waitingForFinger = false;
  double _progress = 0;
  int? _bpm;
  Timer? _progressTimer;
  Timer? _fingerTimeoutTimer;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _service.initCamera();
    setState(() {});
  }

  Future<void> _startMeasurement() async {
    setState(() {
      _measuring = true;
      _bpm = null;
      _progress = 0;
      _waitingForFinger = true;
    });

    await _service.turnTorchOn();

    _fingerTimeoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_service.isFingerDetected) {
        timer.cancel();
        _waitingForFinger = false;
        await _startActualMeasurement();
      } else {
        debugPrint("Waiting for finger...");
      }

      if (timer.tick > 15) {
        timer.cancel();
        _cancelMeasurement("Finger not detected. Try again.");
      }
    });
  }

  Future<void> _startActualMeasurement() async {
    debugPrint("Finger detected — starting measurement.");

    await _audioPlayer.setSource(AssetSource('audio/beep.mp3'));
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.resume();

    _progressTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (_service.isFingerDetected) {
        setState(() {
          _progress += 0.02;
        });
      } else {
        debugPrint("Finger lost — pausing progress");
        return; // pause if finger lost
      }

      if (_progress >= 1.0) {
        timer.cancel();
        _finalizeMeasurement();
      }
    });
  }

  Future<void> _finalizeMeasurement() async {
    await _audioPlayer.stop();
    await _service.turnTorchOff();

    final bpm = await _service.measureBPM();
    await _service.saveToFirebase(bpm);

    setState(() {
      _measuring = false;
      _bpm = bpm;
      _progress = 0;
    });
  }

  void _cancelMeasurement(String msg) {
    _audioPlayer.stop();
    _service.turnTorchOff();
    _progressTimer?.cancel();
    _fingerTimeoutTimer?.cancel();
    setState(() {
      _measuring = false;
      _progress = 0;
      _bpm = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _progressTimer?.cancel();
    _fingerTimeoutTimer?.cancel();
    _service.turnTorchOff();
    _service.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preview = _service.controller?.value.isInitialized == true
        ? AspectRatio(
            aspectRatio: _service.controller!.value.aspectRatio,
            child: CameraPreview(_service.controller!),
          )
        : const SizedBox(height: 180, child: Center(child: CircularProgressIndicator()));

    return Scaffold(
      appBar: AppBar(title: const Text('Heart Rate Measurement')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            preview,
            const SizedBox(height: 16),
            if (_measuring)
              Column(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: _progress,
                      strokeWidth: 8,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(_waitingForFinger
                      ? 'Place your finger on the camera...'
                      : (_progress < 1.0
                          ? 'Measuring... Keep still'
                          : 'Finalizing...')),
                ],
              )
            else if (_bpm != null)
              Column(
                children: [
                  const Icon(Icons.favorite, color: Colors.red, size: 50),
                  const SizedBox(height: 8),
                  const Text("Your Heart Rate:", style: TextStyle(fontSize: 20)),
                  Text("$_bpm BPM",
                      style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                ],
              )
            else
              Column(
                children: const [
                  Icon(Icons.fingerprint, size: 100, color: Colors.grey),
                  Text("Place your finger firmly on the camera to begin."),
                ],
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _measuring ? null : _startMeasurement,
              child: Text(_measuring ? 'Measuring...' : 'Start Measurement'),
            ),
          ],
        ),
      ),
    );
  }
}
