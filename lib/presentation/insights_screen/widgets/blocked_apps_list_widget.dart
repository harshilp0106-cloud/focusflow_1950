import '../../../core/app_export.dart';

class BlockedAppsListWidget extends StatelessWidget {
  const BlockedAppsListWidget({super.key});

  static final List<Map<String, dynamic>> _blockedApps = [
    {
      'name': 'Instagram',
      'iconName': 'photo_camera_rounded',
      'color': Color(0xFFE1306C),
      'blocks': 23,
      'timeSaved': '1h 12m',
    },
    {
      'name': 'YouTube',
      'iconName': 'play_circle_rounded',
      'color': Color(0xFFFF0000),
      'blocks': 18,
      'timeSaved': '54m',
    },
    {
      'name': 'TikTok',
      'iconName': 'music_video_rounded',
      'color': Color(0xFF69C9D0),
      'blocks': 31,
      'timeSaved': '2h 05m',
    },
    {
      'name': 'Reddit',
      'iconName': 'forum_rounded',
      'color': Color(0xFFFF4500),
      'blocks': 14,
      'timeSaved': '38m',
    },
    {
      'name': 'Twitter / X',
      'iconName': 'tag_rounded',
      'color': Color(0xFF1DA1F2),
      'blocks': 9,
      'timeSaved': '22m',
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
                'Blocked Apps',
                style: TextStyle(
                  fontSize: 15,
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
                  color: const Color(0xFFF97316).withAlpha(31),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${_blockedApps.fold(0, (s, a) => s + (a['blocks'] as int))} total blocks',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFFF97316),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._blockedApps.asMap().entries.map((entry) {
            final i = entry.key;
            final app = entry.value;
            final color = app['color'] as Color;
            final blocks = app['blocks'] as int;
            final maxBlocks = _blockedApps
                .map((a) => a['blocks'] as int)
                .reduce((a, b) => a > b ? a : b);

            return Padding(
              padding: EdgeInsets.only(
                bottom: i < _blockedApps.length - 1 ? 14 : 0,
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color.withAlpha(31),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: color.withAlpha(64),
                        width: 0.5,
                      ),
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: app['iconName'] as String,
                        color: color,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              app['name'] as String,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFE8E8ED),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '$blocks blocks',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF8E8E93),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF34C759,
                                    ).withAlpha(31),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    app['timeSaved'] as String,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF34C759),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: blocks / maxBlocks,
                            backgroundColor: const Color(0xFF2C2C2E),
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                            minHeight: 4,
                          ),
                        ),
                      ],
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
