import '../../../core/app_export.dart';

class TodaysMissionWidget extends StatelessWidget {
  const TodaysMissionWidget({super.key});

  static final List<Map<String, dynamic>> _missions = [
    {
      'title': 'Deep Work Sprint',
      'duration': '90 min',
      'type': 'Deep Work',
      'color': Color(0xFFF97316),
      'iconName': 'bolt_rounded',
      'completed': true,
      'time': '09:00 AM',
    },
    {
      'title': 'Code Review Block',
      'duration': '60 min',
      'type': 'Coding',
      'color': Color(0xFF0A84FF),
      'iconName': 'code_rounded',
      'completed': true,
      'time': '11:00 AM',
    },
    {
      'title': 'Research & Reading',
      'duration': '45 min',
      'type': 'Study',
      'color': Color(0xFFA78BFA),
      'iconName': 'menu_book_rounded',
      'completed': false,
      'time': '02:00 PM',
    },
    {
      'title': 'Writing Session',
      'duration': '60 min',
      'type': 'Writing',
      'color': Color(0xFF34C759),
      'iconName': 'edit_rounded',
      'completed': false,
      'time': '04:30 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF2C2C2E), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today's Mission",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFE8E8ED),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF34C759).withAlpha(31),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  '2/4 Done',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF34C759),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(_missions.length, (i) {
            final m = _missions[i];
            final color = m['color'] as Color;
            final completed = m['completed'] as bool;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  // Timeline connector
                  Column(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: completed
                              ? color.withAlpha(38)
                              : const Color(0xFF2C2C2E),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: completed
                                ? color.withAlpha(102)
                                : const Color(0xFF3A3A3C),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: CustomIconWidget(
                            iconName: completed
                                ? 'check_rounded'
                                : m['iconName'] as String,
                            color: completed ? color : const Color(0xFF8E8E93),
                            size: 16,
                          ),
                        ),
                      ),
                      if (i < _missions.length - 1)
                        Container(
                          width: 1,
                          height: 12,
                          color: const Color(0xFF3A3A3C),
                          margin: const EdgeInsets.symmetric(vertical: 0),
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Opacity(
                      opacity: completed ? 0.5 : 1.0,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  m['title'] as String,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFE8E8ED),
                                    decoration: completed
                                        ? TextDecoration.lineThrough
                                        : null,
                                    decorationColor: const Color(0xFF8E8E93),
                                  ),
                                ),
                                Text(
                                  '${m['time']} · ${m['duration']}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF8E8E93),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: color.withAlpha(26),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              m['type'] as String,
                              style: TextStyle(
                                fontSize: 10,
                                color: color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
