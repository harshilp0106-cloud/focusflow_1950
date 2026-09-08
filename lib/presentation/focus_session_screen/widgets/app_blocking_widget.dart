import '../../../core/app_export.dart';

class AppBlockingWidget extends StatelessWidget {
  final bool blockingEnabled;
  final bool strictModeEnabled;
  final ValueChanged<bool> onBlockingToggle;
  final ValueChanged<bool> onStrictToggle;

  const AppBlockingWidget({
    super.key,
    required this.blockingEnabled,
    required this.strictModeEnabled,
    required this.onBlockingToggle,
    required this.onStrictToggle,
  });

  static final List<Map<String, dynamic>> _appsToBlock = [
    {
      'name': 'Instagram',
      'iconName': 'photo_camera_rounded',
      'color': Color(0xFFE1306C),
      'blocked': true,
    },
    {
      'name': 'TikTok',
      'iconName': 'music_video_rounded',
      'color': Color(0xFF010101),
      'blocked': true,
    },
    {
      'name': 'YouTube',
      'iconName': 'play_circle_rounded',
      'color': Color(0xFFFF0000),
      'blocked': true,
    },
    {
      'name': 'Twitter / X',
      'iconName': 'tag_rounded',
      'color': Color(0xFF1DA1F2),
      'blocked': false,
    },
    {
      'name': 'Reddit',
      'iconName': 'forum_rounded',
      'color': Color(0xFFFF4500),
      'blocked': true,
    },
    {
      'name': 'Discord',
      'iconName': 'headset_mic_rounded',
      'color': Color(0xFF5865F2),
      'blocked': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Shield toggle card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFF2C2C2E), width: 0.5),
          ),
          child: Column(
            children: [
              _ToggleRow(
                iconName: 'shield_rounded',
                iconColor: const Color(0xFF34C759),
                title: 'App Blocking Shield',
                subtitle: 'Block distracting apps during session',
                value: blockingEnabled,
                onChanged: onBlockingToggle,
              ),
              const SizedBox(height: 16),
              Container(height: 0.5, color: const Color(0xFF2C2C2E)),
              const SizedBox(height: 16),
              _ToggleRow(
                iconName: 'lock_rounded',
                iconColor: const Color(0xFFFF9F0A),
                title: 'Strict Mode',
                subtitle: 'Cannot end session early once started',
                value: strictModeEnabled,
                onChanged: onStrictToggle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Apps list
        Container(
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
                    'Apps to Block',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFE8E8ED),
                    ),
                  ),
                  Text(
                    '${_appsToBlock.where((a) => a['blocked'] as bool).length} selected',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8E8E93),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ..._appsToBlock.map((app) {
                final color = app['color'] as Color;
                final blocked = app['blocked'] as bool;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
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
                        child: Text(
                          app['name'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFE8E8ED),
                          ),
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: blocked
                              ? const Color(0xFFF97316).withAlpha(38)
                              : const Color(0xFF2C2C2E),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: blocked
                                ? const Color(0xFFF97316).withAlpha(102)
                                : const Color(0xFF3A3A3C),
                          ),
                        ),
                        child: blocked
                            ? Center(
                                child: CustomIconWidget(
                                  iconName: 'check_rounded',
                                  color: const Color(0xFFF97316),
                                  size: 14,
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String iconName;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.iconName,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFE8E8ED),
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 11, color: Color(0xFF8E8E93)),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: const Color(0xFFF97316),
        ),
      ],
    );
  }
}
