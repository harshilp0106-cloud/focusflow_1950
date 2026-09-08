import 'package:fl_chart/fl_chart.dart';

import '../../../core/app_export.dart';

// Anatomy locked: icon circle + section label + "Last N days" tag + large metric value + chart + axis labels

enum InsightChartType { bar, line }

class InsightMetricCardWidget extends StatelessWidget {
  final String iconName;
  final Color iconColor;
  final String sectionLabel;
  final String periodLabel;
  final String metricValue;
  final String metricUnit;
  final String subLabel;
  final InsightChartType chartType;

  const InsightMetricCardWidget({
    super.key,
    required this.iconName,
    required this.iconColor,
    required this.sectionLabel,
    required this.periodLabel,
    required this.metricValue,
    required this.metricUnit,
    required this.subLabel,
    required this.chartType,
  });

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
          // Icon + label row + period tag
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withAlpha(31),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: iconName,
                    color: iconColor,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  sectionLabel,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFE8E8ED),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  periodLabel,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF8E8E93),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Large metric value
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                metricValue,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: iconColor,
                  height: 1.0,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  metricUnit,
                  style: TextStyle(
                    fontSize: 14,
                    color: iconColor.withAlpha(179),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Text(
            subLabel,
            style: const TextStyle(fontSize: 11, color: Color(0xFF8E8E93)),
          ),
          const SizedBox(height: 16),
          // Chart
          SizedBox(
            height: 80,
            child: chartType == InsightChartType.bar
                ? _buildBarChart()
                : _buildLineChart(),
          ),
          const SizedBox(height: 8),
          // Axis labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '08',
                style: TextStyle(fontSize: 10, color: Color(0xFF8E8E93)),
              ),
              Text(
                '12',
                style: TextStyle(fontSize: 10, color: Color(0xFF8E8E93)),
              ),
              Text(
                '18',
                style: TextStyle(fontSize: 10, color: Color(0xFF8E8E93)),
              ),
              Text(
                '22',
                style: TextStyle(fontSize: 10, color: Color(0xFF8E8E93)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    final data = [0.5, 0.8, 0.6, 1.0, 0.7, 0.55, 0.9];
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(enabled: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) => FlLine(
            color: const Color(0xFF2C2C2E),
            strokeWidth: 1,
            dashArray: [4, 4],
          ),
        ),
        barGroups: List.generate(data.length, (i) {
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: data[i],
                color: iconColor,
                width: 10,
                borderRadius: BorderRadius.circular(4),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: 1.0,
                  color: iconColor.withAlpha(20),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildLineChart() {
    final spots = [
      const FlSpot(0, 2.8),
      const FlSpot(1, 3.1),
      const FlSpot(2, 2.5),
      const FlSpot(3, 3.4),
      const FlSpot(4, 3.2),
      const FlSpot(5, 3.8),
      const FlSpot(6, 3.5),
    ];
    return LineChart(
      LineChartData(
        lineTouchData: const LineTouchData(enabled: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) => FlLine(
            color: const Color(0xFF2C2C2E),
            strokeWidth: 1,
            dashArray: [4, 4],
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            color: iconColor,
            barWidth: 2.5,
            isCurved: true,
            curveSmoothness: 0.35,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [iconColor.withAlpha(51), iconColor.withAlpha(0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
