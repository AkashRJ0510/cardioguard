import 'package:flutter/material.dart';

class HeartRateVisualizer extends StatelessWidget {
  final List<int> data;

  const HeartRateVisualizer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 200),
      painter: _VisualizerPainter(data),
    );
  }
}

class _VisualizerPainter extends CustomPainter {
  final List<int> data;

  _VisualizerPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

    final maxVal = data.isEmpty ? 1 : data.reduce((a, b) => a > b ? a : b);
    final points = <Offset>[];

    for (int i = 0; i < data.length; i++) {
      double x = (i / data.length) * size.width;
      double y = size.height - (data[i] / maxVal) * size.height;
      points.add(Offset(x, y));
    }

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
