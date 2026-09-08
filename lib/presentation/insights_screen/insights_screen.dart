import 'package:flutter/material.dart';

import '../../widgets/app_bar_widget.dart';
import './widgets/blocked_apps_list_widget.dart';
import './widgets/focus_score_card_widget.dart';
import './widgets/insight_metric_card_widget.dart';
import './widgets/insights_kpi_card_widget.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
  // TODO: Replace with [Riverpod/Bloc] for production insights state
}

class _InsightsScreenState extends State<InsightsScreen> {
  String _selectedPeriod = 'This Week';

  static const _periods = ['Today', 'This Week', 'This Month', 'All Time'];

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0F),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBarWidget(
          title: 'Insights',
          subtitle: 'Personalized performance analysis',
          isItalic: true,
        ),
      ),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 80 + MediaQuery.of(context).padding.top),
            ),
            // Period filter chips
            SliverToBoxAdapter(
              child: SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _periods.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    final isActive = _periods[i] == _selectedPeriod;
                    return GestureDetector(
                      onTap: () =>
                          setState(() => _selectedPeriod = _periods[i]),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFFF97316).withAlpha(38)
                              : const Color(0xFF1C1C1E),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: isActive
                                ? const Color(0xFFF97316).withAlpha(102)
                                : const Color(0xFF3A3A3C),
                          ),
                        ),
                        child: Text(
                          _periods[i],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: isActive
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isActive
                                ? const Color(0xFFF97316)
                                : const Color(0xFF8E8E93),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, isTablet ? 16 : 12),
                child: isTablet
                    ? Row(
                        children: [
                          Expanded(
                            child: InsightsKpiCardWidget(
                              label: 'Active Energy',
                              value: '93',
                              unit: 'Kcal',
                              delta: '+12% vs yesterday',
                              deltaPositive: true,
                              showMiniChart: true,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: InsightsKpiCardWidget(
                              label: 'Daily Performance',
                              value: '58',
                              unit: 'Score',
                              delta: '+5 vs weekly average',
                              deltaPositive: true,
                              showGauge: true,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: InsightsKpiCardWidget(
                              label: 'Active Energy',
                              value: '93',
                              unit: 'Kcal',
                              delta: '+12% vs yesterday',
                              deltaPositive: true,
                              showMiniChart: true,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: InsightsKpiCardWidget(
                              label: 'Daily Performance',
                              value: '58',
                              unit: 'Score',
                              delta: '+5 vs weekly average',
                              deltaPositive: true,
                              showGauge: true,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: FocusScoreCardWidget(
                  score: 87,
                  condition: 'Good Condition',
                  delta: '+5 vs weekly average',
                  sleepAvg: '7.2h',
                  recovery: '82%',
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: InsightMetricCardWidget(
                  iconName: 'directions_run_rounded',
                  iconColor: const Color(0xFFF97316),
                  sectionLabel: 'Activity',
                  periodLabel: 'Last 7 days',
                  metricValue: '19,840',
                  metricUnit: 'Steps',
                  subLabel: 'Avg daily steps',
                  chartType: InsightChartType.bar,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: InsightMetricCardWidget(
                  iconName: 'bedtime_rounded',
                  iconColor: const Color(0xFFA78BFA),
                  sectionLabel: 'Focus Hours',
                  periodLabel: 'Last 7 days',
                  metricValue: '3.2',
                  metricUnit: 'Hours/day',
                  subLabel: 'Avg reclaimed time',
                  chartType: InsightChartType.line,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: BlockedAppsListWidget(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}
