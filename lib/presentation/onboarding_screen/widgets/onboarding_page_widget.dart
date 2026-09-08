import '../../../core/app_export.dart';

class OnboardingPageWidget extends StatefulWidget {
  final int pageIndex;

  const OnboardingPageWidget({super.key, required this.pageIndex});

  @override
  State<OnboardingPageWidget> createState() => _OnboardingPageWidgetState();
}

class _OnboardingPageWidgetState extends State<OnboardingPageWidget>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  static const _page0Icons = [
    ('bolt_rounded', Color(0xFFF97316)),
    ('menu_book_rounded', Color(0xFFA78BFA)),
    ('code_rounded', Color(0xFF34C759)),
    ('edit_rounded', Color(0xFF0A84FF)),
    ('self_improvement_rounded', Color(0xFFFF9F0A)),
    ('fitness_center_rounded', Color(0xFFFF3B30)),
    ('bedtime_rounded', Color(0xFF5E5CE6)),
    ('water_drop_rounded', Color(0xFF64D2FF)),
    ('psychology_rounded', Color(0xFFFF6B9D)),
    ('schedule_rounded', Color(0xFF34C759)),
  ];

  static const _page0Positions = [
    Offset(0.45, 0.08),
    Offset(0.15, 0.15),
    Offset(0.70, 0.18),
    Offset(0.30, 0.28),
    Offset(0.62, 0.32),
    Offset(0.10, 0.38),
    Offset(0.48, 0.42),
    Offset(0.78, 0.44),
    Offset(0.22, 0.52),
    Offset(0.60, 0.56),
  ];

  static const _page1Tasks = [
    ('Finish Q1 Report', 'Deep Work', Color(0xFFF97316)),
    ('Review Analytics', 'Focus', Color(0xFFA78BFA)),
    ('Team Meeting Prep', 'Planning', Color(0xFF34C759)),
    ('Book Dentist Appt', 'Personal', Color(0xFF0A84FF)),
    ('Update Project Doc', 'Work', Color(0xFFFF9F0A)),
    ('Call Mom', 'Personal', Color(0xFFFF6B9D)),
  ];

  static const _page1Positions = [
    Offset(0.05, 0.04),
    Offset(0.35, 0.08),
    Offset(0.15, 0.22),
    Offset(0.40, 0.28),
    Offset(0.08, 0.40),
    Offset(0.30, 0.46),
  ];

  static const _page1Rotations = [-0.15, 0.10, -0.08, 0.12, -0.10, 0.07];

  @override
  void initState() {
    super.initState();
    final count = widget.pageIndex == 0
        ? _page0Icons.length
        : _page1Tasks.length;
    _controllers = List.generate(
      count,
      (i) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600 + i * 60),
      ),
    );
    _animations = _controllers
        .map((c) => CurvedAnimation(parent: c, curve: Curves.easeOutBack))
        .toList();

    Future.delayed(const Duration(milliseconds: 100), () {
      for (int i = 0; i < _controllers.length; i++) {
        Future.delayed(Duration(milliseconds: i * 80), () {
          if (mounted) _controllers[i].forward();
        });
      }
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final clusterHeight = size.height * 0.52;

    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 48,
        bottom: 180,
      ),
      child: Column(
        children: [
          // Floating cluster
          SizedBox(
            height: clusterHeight,
            width: double.infinity,
            child: widget.pageIndex == 0
                ? _buildIconCluster(clusterHeight, size.width)
                : _buildTaskCluster(clusterHeight, size.width),
          ),
          const SizedBox(height: 32),
          // Headline
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Text(
                  widget.pageIndex == 0
                      ? 'Build Better Focus.\nSmall actions. Real progress.'
                      : 'Organize focus by energy,\ntime, and priority.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFE8E8ED),
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.pageIndex == 0
                      ? 'Small steps every day. Big results over time.'
                      : 'Break big goals into focused deep work sessions.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8E8E93),
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconCluster(double height, double width) {
    return Stack(
      children: List.generate(_page0Icons.length, (i) {
        final (iconName, color) = _page0Icons[i];
        final pos = _page0Positions[i];
        final size = 52.0 + (i % 3) * 8.0;
        return Positioned(
          left: pos.dx * width - size / 2,
          top: pos.dy * height,
          child: ScaleTransition(
            scale: _animations[i],
            child: _GlassBubble(iconName: iconName, color: color, size: size),
          ),
        );
      }),
    );
  }

  Widget _buildTaskCluster(double height, double width) {
    return Stack(
      children: List.generate(_page1Tasks.length, (i) {
        final (title, tag, color) = _page1Tasks[i];
        final pos = _page1Positions[i];
        final rot = _page1Rotations[i];
        return Positioned(
          left: pos.dx * width,
          top: pos.dy * height,
          child: ScaleTransition(
            scale: _animations[i],
            child: Transform.rotate(
              angle: rot,
              child: _GlassTaskCard(title: title, tag: tag, color: color),
            ),
          ),
        );
      }),
    );
  }
}

class _GlassBubble extends StatelessWidget {
  final String iconName;
  final Color color;
  final double size;

  const _GlassBubble({
    required this.iconName,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withAlpha(38),
        border: Border.all(color: color.withAlpha(77), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(51),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: CustomIconWidget(
          iconName: iconName,
          color: Colors.white,
          size: size * 0.45,
        ),
      ),
    );
  }
}

class _GlassTaskCard extends StatelessWidget {
  final String title;
  final String tag;
  final Color color;

  const _GlassTaskCard({
    required this.title,
    required this.tag,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E).withAlpha(217),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3A3A3C), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(77),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 1.5),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'check_rounded',
                color: color,
                size: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFE8E8ED),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: color.withAlpha(38),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 9,
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      '120m • High energy',
                      style: TextStyle(fontSize: 9, color: Color(0xFF8E8E93)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}