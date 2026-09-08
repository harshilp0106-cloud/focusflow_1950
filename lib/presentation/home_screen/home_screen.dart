import 'package:flutter/material.dart';

import '../../widgets/app_bar_widget.dart';
import './widgets/focus_gauge_card_widget.dart';
import './widgets/stat_card_widget.dart';
import './widgets/time_filter_widget.dart';
import './widgets/todays_mission_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  // TODO: Replace with [Riverpod/Bloc] for production state management
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedFilter = 'Today';

  final List<String> _filters = [
    'Today',
    'This Week',
    'This Month',
    'All Time',
  ];

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0F),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: _HomeAppBar(),
      ),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 80 + MediaQuery.of(context).padding.top),
            ),
            SliverToBoxAdapter(
              child: TimeFilterWidget(
                filters: _filters,
                selected: _selectedFilter,
                onSelected: (f) => setState(() => _selectedFilter = f),
              ),
            ),
            SliverToBoxAdapter(
              child: isTablet ? _buildTabletLayout() : _buildPhoneLayout(),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          const FocusGaugeCardWidget(
            score: 74,
            state: 'Balanced Focus State',
            subtitle: 'Daily Focus Stability Index',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: StatCardWidget(
                  iconName: 'local_fire_department_rounded',
                  iconColor: const Color(0xFFF97316),
                  label: 'Current Streak',
                  value: '12',
                  unit: 'Days',
                  unitColor: const Color(0xFFF97316),
                  subLabel: '↑ 3 from last week',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCardWidget(
                  iconName: 'block_rounded',
                  iconColor: const Color(0xFFA78BFA),
                  label: 'Blocks Today',
                  value: '47',
                  unit: 'Apps',
                  unitColor: const Color(0xFFA78BFA),
                  subLabel: 'Distraction-free',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: StatCardWidget(
                  iconName: 'hourglass_top_rounded',
                  iconColor: const Color(0xFF34C759),
                  label: 'Reclaimed',
                  value: '3.2',
                  unit: 'Hours',
                  unitColor: const Color(0xFF34C759),
                  subLabel: 'vs 2.1h yesterday',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCardWidget(
                  iconName: 'check_circle_rounded',
                  iconColor: const Color(0xFF0A84FF),
                  label: 'Sessions',
                  value: '4',
                  unit: 'Done',
                  unitColor: const Color(0xFF0A84FF),
                  subLabel: '2 remaining today',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const TodaysMissionWidget(),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            flex: 6,
            child: Column(
              children: [
                SizedBox(height: 16),
                FocusGaugeCardWidget(
                  score: 74,
                  state: 'Balanced Focus State',
                  subtitle: 'Daily Focus Stability Index',
                ),
                SizedBox(height: 16),
                TodaysMissionWidget(),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                const SizedBox(height: 16),
                StatCardWidget(
                  iconName: 'local_fire_department_rounded',
                  iconColor: const Color(0xFFF97316),
                  label: 'Current Streak',
                  value: '12',
                  unit: 'Days',
                  unitColor: const Color(0xFFF97316),
                  subLabel: '↑ 3 from last week',
                ),
                const SizedBox(height: 12),
                StatCardWidget(
                  iconName: 'block_rounded',
                  iconColor: const Color(0xFFA78BFA),
                  label: 'Blocks Today',
                  value: '47',
                  unit: 'Apps',
                  unitColor: const Color(0xFFA78BFA),
                  subLabel: 'Distraction-free',
                ),
                const SizedBox(height: 12),
                StatCardWidget(
                  iconName: 'hourglass_top_rounded',
                  iconColor: const Color(0xFF34C759),
                  label: 'Reclaimed',
                  value: '3.2',
                  unit: 'Hours',
                  unitColor: const Color(0xFF34C759),
                  subLabel: 'vs 2.1h yesterday',
                ),
                const SizedBox(height: 12),
                StatCardWidget(
                  iconName: 'check_circle_rounded',
                  iconColor: const Color(0xFF0A84FF),
                  label: 'Sessions',
                  value: '4',
                  unit: 'Done',
                  unitColor: const Color(0xFF0A84FF),
                  subLabel: '2 remaining today',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      title: 'Good Morning',
      subtitle: 'Hello Zayan 👋  •  Friday, Aug 29',
      isItalic: true,
    );
  }
}
