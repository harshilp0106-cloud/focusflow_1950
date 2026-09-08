import 'dart:math' as math;

import '../../../core/app_export.dart';

// Anatomy locked: icon strip row at top + arc gauge center + large % + state label

class FocusGaugeCardWidget extends StatefulWidget {
  final int score;
  final String state;
  final String subtitle;

  const FocusGaugeCardWidget({
    super.key,
    required this.score,
    required this.state,
    required this.subtitle,
  });

  @override
  State<FocusGaugeCardWidget> createState() => _FocusGaugeCardWidgetState();
}

class _FocusGaugeCardWidgetState extends State<FocusGaugeCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  static const _sessionTypes = [
    ('bolt_rounded', Color(0xFFF97316)),
    ('menu_book_rounded', Color(0xFFA78BFA)),
    ('directions_run_rounded', Color(0xFF34C759)),
    ('code_rounded', Color(0xFF0A84FF)),
    ('edit_rounded', Color(0xFFFF9F0A)),
    ('self_improvement_rounded', Color(0xFF64D2FF)),
    ('favorite_rounded', Color(0xFFFF6B9D)),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.score / 100.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF2C2C2E), width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(77),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon strip
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _sessionTypes.map((t) {
                final (name, color) = t;
                return Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: color.withAlpha(31),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: color.withAlpha(64), width: 0.5),
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: name,
                      color: color,
                      size: 18,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Gauge
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                return SizedBox(
                  height: 180,
                  child: CustomPaint(
                    painter: _GaugePainter(
                      progress: _animation.value,
                      score: widget.score,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${widget.score}%',
                            style: const TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFE8E8ED),
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.state,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFFAEAEB2),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            widget.subtitle,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF8E8E93),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;
  final int score;

  _GaugePainter({required this.progress, required this.score});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 24);
    final radius = size.width * 0.38;

    // Track
    final trackPaint = Paint()
      ..color = const Color(0xFF2C2C2E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      trackPaint,
    );

    // Progress
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: [Color(0xFFF97316), Color(0xFFEA580C)],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi * progress,
      false,
      progressPaint,
    );

    // Dot at tip
    final angle = math.pi + math.pi * progress;
    final dotX = center.dx + radius * math.cos(angle);
    final dotY = center.dy + radius * math.sin(angle);
    final dotPaint = Paint()..color = const Color(0xFFF97316);
    canvas.drawCircle(Offset(dotX, dotY), 6, dotPaint);
  }

  @override
  bool shouldRepaint(_GaugePainter old) => old.progress != progress;
}
