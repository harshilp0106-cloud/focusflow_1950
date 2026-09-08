import 'dart:async';
import 'dart:math' as math;

import 'package:go_router/go_router.dart';

import '../../core/app_export.dart';

class LiveSessionTimerScreen extends StatefulWidget {
  final String sessionType;
  final int durationMinutes;

  const LiveSessionTimerScreen({
    super.key,
    required this.sessionType,
    required this.durationMinutes,
  });

  @override
  State<LiveSessionTimerScreen> createState() => _LiveSessionTimerScreenState();
  // TODO: Replace with [Riverpod/Bloc] for production timer state
}

class _LiveSessionTimerScreenState extends State<LiveSessionTimerScreen>
    with TickerProviderStateMixin {
  late int _remainingSeconds;
  late int _totalSeconds;
  Timer? _timer;
  bool _isPaused = false;
  late AnimationController _pulseController;
  late AnimationController _bgController;
  late Animation<double> _pulseAnimation;

  static const _quotes = [
    "Deep work is the superpower of the 21st century.",
    "Focus is the new IQ.",
    "Distraction is the enemy of deep work.",
    "One hour of focused work beats eight hours of distracted effort.",
    "Your attention is your most valuable asset.",
  ];

  static const _typeColors = {
    'Deep Work': Color(0xFFF97316),
    'Study': Color(0xFFA78BFA),
    'Coding': Color(0xFF0A84FF),
    'Writing': Color(0xFF34C759),
    'Research': Color(0xFFFF9F0A),
    'Reading': Color(0xFF64D2FF),
  };

  static const _typeIcons = {
    'Deep Work': 'bolt_rounded',
    'Study': 'menu_book_rounded',
    'Coding': 'code_rounded',
    'Writing': 'edit_rounded',
    'Research': 'search_rounded',
    'Reading': 'chrome_reader_mode_rounded',
  };

  String get _currentQuote {
    final idx = ((_totalSeconds - _remainingSeconds) ~/ 60) % _quotes.length;
    return _quotes[idx];
  }

  Color get _sessionColor =>
      _typeColors[widget.sessionType] ?? const Color(0xFFF97316);

  String get _sessionIcon => _typeIcons[widget.sessionType] ?? 'bolt_rounded';

  @override
  void initState() {
    super.initState();
    _totalSeconds = widget.durationMinutes * 60;
    _remainingSeconds = _totalSeconds;

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isPaused && _remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else if (_remainingSeconds == 0) {
        _timer?.cancel();
        _showCompletionDialog();
      }
    });
  }

  void _togglePause() {
    setState(() => _isPaused = !_isPaused);
  }

  void _endSession() {
    _timer?.cancel();
    context.pop();
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          'Session Complete! 🎉',
          style: TextStyle(
            color: Color(0xFFE8E8ED),
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'You completed a ${widget.durationMinutes}-minute ${widget.sessionType} session. Great focus!',
          style: const TextStyle(color: Color(0xFF8E8E93)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.pop();
            },
            child: const Text(
              'Done',
              style: TextStyle(color: Color(0xFFF97316)),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  double get _progress => 1.0 - (_remainingSeconds / _totalSeconds);

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0F),
      body: Stack(
        children: [
          // Animated background glow
          AnimatedBuilder(
            animation: _bgController,
            builder: (_, __) {
              return Positioned(
                top: -100,
                left: size.width * 0.1 * _bgController.value,
                child: Container(
                  width: size.width * 0.8,
                  height: size.width * 0.8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [_sessionColor.withAlpha(20), Colors.transparent],
                    ),
                  ),
                ),
              );
            },
          ),
          SafeArea(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _endSession,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1C1C1E),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFF3A3A3C)),
                          ),
                          child: Center(
                            child: CustomIconWidget(
                              iconName: 'close_rounded',
                              color: const Color(0xFF8E8E93),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _sessionColor.withAlpha(31),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: _sessionColor.withAlpha(77),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconWidget(
                              iconName: _sessionIcon,
                              color: _sessionColor,
                              size: 14,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.sessionType,
                              style: TextStyle(
                                fontSize: 13,
                                color: _sessionColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Timer circle
                ScaleTransition(
                  scale: _pulseAnimation,
                  child: SizedBox(
                    width: 260,
                    height: 260,
                    child: CustomPaint(
                      painter: _TimerRingPainter(
                        progress: _progress,
                        color: _sessionColor,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _formatTime(_remainingSeconds),
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFE8E8ED),
                                fontFeatures: [FontFeature.tabularFigures()],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${(_progress * 100).toInt()}% complete',
                              style: TextStyle(
                                fontSize: 13,
                                color: _sessionColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Quote
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      _currentQuote,
                      key: ValueKey(_currentQuote),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8E8E93),
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                // Controls
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: _endSession,
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1C1C1E),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF3A3A3C),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'End Session',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF8E8E93),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: _togglePause,
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  _sessionColor,
                                  _sessionColor.withAlpha(204),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: _sessionColor.withAlpha(77),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                _isPaused ? 'Resume' : 'Pause',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimerRingPainter extends CustomPainter {
  final double progress;
  final Color color;

  _TimerRingPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;

    // Track
    final trackPaint = Paint()
      ..color = const Color(0xFF2C2C2E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawCircle(center, radius, trackPaint);

    // Progress arc
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: -math.pi / 2 + 2 * math.pi,
        colors: [color.withAlpha(77), color],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_TimerRingPainter old) =>
      old.progress != progress || old.color != color;
}
