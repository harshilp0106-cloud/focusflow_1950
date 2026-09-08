import 'dart:math' as math;
import 'package:flutter/material.dart';

// Anatomy locked: label + huge score + condition state + delta + wave chart + bottom stats row
// Matches extracted WellnessCard anatomy

class FocusScoreCardWidget extends StatefulWidget {
  final int score;
  final String condition;
  final String delta;
  final String sleepAvg;
  final String recovery;

  const FocusScoreCardWidget({
    super.key,
    required this.score,
    required this.condition,
    required this.delta,
    required this.sleepAvg,
    required this.recovery,
  });

  @override
  State<FocusScoreCardWidget> createState() => _FocusScoreCardWidgetState();
}

class _FocusScoreCardWidgetState extends State<FocusScoreCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF2C2C2E), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Wellness Score',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF8E8E93),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${widget.score}',
            style: const TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.w800,
              color: Color(0xFFF97316),
              height: 1.0,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.condition,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFFE8E8ED),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(
                Icons.arrow_upward_rounded,
                size: 12,
                color: Color(0xFF34C759),
              ),
              const SizedBox(width: 4),
              Text(
                widget.delta,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF34C759),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Sine wave chart
          SizedBox(
            height: 60,
            child: AnimatedBuilder(
              animation: _waveController,
              builder: (_, __) {
                return CustomPaint(
                  painter: _SineWavePainter(
                    phase: _waveController.value * 2 * math.pi,
                  ),
                  size: const Size(double.infinity, 60),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Bottom stats row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sleep Avg',
                      style: TextStyle(fontSize: 11, color: Color(0xFF8E8E93)),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.sleepAvg,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE8E8ED),
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 32, color: const Color(0xFF3A3A3C)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recovery',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.recovery,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFE8E8ED),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SineWavePainter extends CustomPainter {
  final double phase;

  _SineWavePainter({required this.phase});

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = const Color(0xFFF97316).withAlpha(179)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final paint2 = Paint()
      ..color = const Color(0xFFA78BFA).withAlpha(128)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    _drawWave(canvas, size, paint1, phase, 0.35, 1.0);
    _drawWave(canvas, size, paint2, phase + math.pi * 0.7, 0.25, 1.5);
  }

  void _drawWave(
    Canvas canvas,
    Size size,
    Paint paint,
    double phase,
    double amplitude,
    double frequency,
  ) {
    final path = Path();
    final centerY = size.height / 2;
    final amp = size.height * amplitude;

    for (double x = 0; x <= size.width; x += 2) {
      final y =
          centerY +
          amp * math.sin((x / size.width) * 2 * math.pi * frequency + phase);
      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_SineWavePainter old) => old.phase != phase;
}
