import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:torch_light/torch_light.dart';

class HeartRateService {
  CameraController? _cameraController;
  bool _isProcessing = false;
  final List<int> _brightnessValues = [];

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras.first, ResolutionPreset.low);
    await _cameraController!.initialize();
    await _cameraController!.startImageStream(_processImage);
  }

  CameraController? get controller => _cameraController;

  Future<void> _processImage(CameraImage image) async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      final bytes = image.planes[0].bytes;
      final avg = bytes.reduce((a, b) => a + b) ~/ bytes.length;

      if (avg > 30 && avg < 220) {
        _brightnessValues.add(avg);
        if (_brightnessValues.length > 100) {
          _brightnessValues.removeAt(0);
        }
      }
    } catch (_) {}

    _isProcessing = false;
  }

  bool get isFingerDetected {
    if (_brightnessValues.isEmpty) return false;
    final last = _brightnessValues.last;
    return last > 30 && last < 220;
  }

  Future<int> measureBPM() async {
    if (_brightnessValues.isEmpty) return 0;
    final peaks = _detectPeaks(_brightnessValues);
    const duration = 10;
    return ((peaks / duration) * 60).toInt();
  }

  int _detectPeaks(List<int> values) {
    int count = 0;
    for (int i = 1; i < values.length - 1; i++) {
      if (values[i] > values[i - 1] && values[i] > values[i + 1]) {
        count++;
      }
    }
    return count;
  }

  Future<void> saveToFirebase(int bpm) async {
    final doc = FirebaseFirestore.instance.collection('heart_rates').doc();
    await doc.set({'timestamp': Timestamp.now(), 'bpm': bpm});
  }

  Future<void> turnTorchOn() async {
    try {
      await TorchLight.enableTorch();
    } catch (_) {}
  }

  Future<void> turnTorchOff() async {
    try {
      await TorchLight.disableTorch();
    } catch (_) {}
  }

  Future<void> stop() async {
    await _cameraController?.stopImageStream();
    await _cameraController?.dispose();
    _cameraController = null;
  }
}
