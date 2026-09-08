import 'dart:ui';

import 'package:go_router/go_router.dart';

import '../core/app_export.dart';

// V3 — Liquid Glass bottom navigation
// BackdropFilter blur + frosted surface + animated active indicator — LOCKED

class _TabSpec {
  final String label;
  final String iconName;
  final String selectedIconName;
  final int? branchIndex;

  const _TabSpec({
    required this.label,
    required this.iconName,
    required this.selectedIconName,
    this.branchIndex,
  });
}

class AppNavigation extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const AppNavigation({required this.navigationShell, super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _selectedVisualIndex = 0;

  static const List<_TabSpec> _tabs = [
    _TabSpec(
      label: 'Home',
      iconName: 'home_outlined',
      selectedIconName: 'home_rounded',
      branchIndex: 0,
    ),
    _TabSpec(
      label: 'Focus',
      iconName: 'timer_outlined',
      selectedIconName: 'timer_rounded',
      branchIndex: 1,
    ),
    _TabSpec(
      label: 'Insights',
      iconName: 'bar_chart_outlined',
      selectedIconName: 'bar_chart_rounded',
      branchIndex: 2,
    ),
    _TabSpec(
      label: 'Rules',
      iconName: 'rule_outlined',
      selectedIconName: 'rule_rounded',
      branchIndex: 3,
    ),
    _TabSpec(
      label: 'Settings',
      iconName: 'settings_outlined',
      selectedIconName: 'settings_rounded',
      branchIndex: 4,
    ),
  ];

  void _onTabTap(int visualIndex) {
    final tab = _tabs[visualIndex];
    if (tab.branchIndex == null) return;

    setState(() => _selectedVisualIndex = visualIndex);
    widget.navigationShell.goBranch(
      tab.branchIndex!,
      initialLocation: tab.branchIndex == widget.navigationShell.currentIndex,
    );
  }

  @override
  void didUpdateWidget(AppNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync visual index with shell branch
    final currentBranch = widget.navigationShell.currentIndex;
    for (int i = 0; i < _tabs.length; i++) {
      if (_tabs[i].branchIndex == currentBranch) {
        if (_selectedVisualIndex != i) {
          setState(() => _selectedVisualIndex = i);
        }
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E).withAlpha(191),
              border: const Border(
                top: BorderSide(color: Color(0xFF3A3A3C), width: 0.5),
              ),
            ),
            child: Row(
              children: List.generate(_tabs.length, (i) {
                final tab = _tabs[i];
                final isActive = i == _selectedVisualIndex;
                final isStub = tab.branchIndex == null;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _onTabTap(i),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFFF97316).withAlpha(46)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: CustomIconWidget(
                              iconName: isActive
                                  ? tab.selectedIconName
                                  : tab.iconName,
                              color: isActive
                                  ? const Color(0xFFF97316)
                                  : const Color(0xFF8E8E93),
                              size: 22,
                            ),
                          ),
                          const SizedBox(height: 2),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isActive
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: isActive
                                  ? const Color(0xFFF97316)
                                  : const Color(0xFF8E8E93),
                            ),
                            child: Text(tab.label),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
