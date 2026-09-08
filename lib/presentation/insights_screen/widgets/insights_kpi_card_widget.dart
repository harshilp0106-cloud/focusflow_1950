import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Anatomy locked: label top + large colored number + unit + delta line
// Optional: mini bar chart OR mini gauge

class InsightsKpiCardWidget extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final String delta;
  final bool deltaPositive;
  final bool showMiniChart;
  final bool showGauge;

  const InsightsKpiCardWidget({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.delta,
    required this.deltaPositive,
    this.showMiniChart = false,
    this.showGauge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2C2C2E), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF8E8E93),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFF97316),
                  height: 1.0,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  unit,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFFF97316),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (showMiniChart) _buildMiniBarChart(),
          if (showGauge) _buildMiniGauge(),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                deltaPositive
                    ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded,
                size: 12,
                color: deltaPositive
                    ? const Color(0xFF34C759)
                    : const Color(0xFFFF3B30),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  delta,
                  style: TextStyle(
                    fontSize: 11,
                    color: deltaPositive
                        ? const Color(0xFF34C759)
                        : const Color(0xFFFF3B30),
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniBarChart() {
    final data = [0.4, 0.7, 0.5, 0.9, 0.6, 0.8, 0.75];
    return SizedBox(
      height: 40,
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(enabled: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
          barGroups: List.generate(data.length, (i) {
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: data[i],
                  color: const Color(0xFFF97316),
                  width: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildMiniGauge() {
    final score = double.tryParse(value) ?? 58;
    final progress = (score / 100).clamp(0.0, 1.0);
    return SizedBox(
      height: 48,
      child: CustomPaint(painter: _MiniGaugePainter(progress: progress)),
    );
  }
}

class _MiniGaugePainter extends CustomPainter {
  final double progress;

  _MiniGaugePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width * 0.45;

    final trackPaint = Paint()
      ..color = const Color(0xFF2C2C2E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      trackPaint,
    );

    final progressPaint = Paint()
      ..color = const Color(0xFFF97316)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_MiniGaugePainter old) => old.progress != progress;
}
