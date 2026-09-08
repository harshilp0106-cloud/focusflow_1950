import '../../core/app_export.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Session preferences
  int _defaultDuration = 25;
  String _defaultSessionType = 'Deep Work';
  bool _autoStartBreaks = true;
  bool _strictMode = false;

  // Notification toggles
  bool _sessionReminders = true;
  bool _streakAlerts = true;
  bool _weeklyReport = false;
  bool _breakReminders = true;
  bool _goalAchievements = true;

  // App block list
  final List<Map<String, dynamic>> _blockedApps = [
    {
      'name': 'Instagram',
      'icon': 'photo_camera_rounded',
      'color': 0xFFE1306C,
      'blocked': true,
    },
    {
      'name': 'Twitter / X',
      'icon': 'tag_rounded',
      'color': 0xFF1DA1F2,
      'blocked': true,
    },
    {
      'name': 'YouTube',
      'icon': 'play_circle_rounded',
      'color': 0xFFFF0000,
      'blocked': true,
    },
    {
      'name': 'TikTok',
      'icon': 'music_note_rounded',
      'color': 0xFF69C9D0,
      'blocked': false,
    },
    {
      'name': 'Reddit',
      'icon': 'forum_rounded',
      'color': 0xFFFF4500,
      'blocked': true,
    },
    {
      'name': 'LinkedIn',
      'icon': 'work_rounded',
      'color': 0xFF0077B5,
      'blocked': false,
    },
    {
      'name': 'Slack',
      'icon': 'chat_bubble_rounded',
      'color': 0xFF4A154B,
      'blocked': false,
    },
    {
      'name': 'Discord',
      'icon': 'headset_mic_rounded',
      'color': 0xFF5865F2,
      'blocked': false,
    },
  ];

  static const List<String> _sessionTypes = [
    'Deep Work',
    'Flow State',
    'Study',
    'Writing',
    'Coding',
    'Creative',
  ];

  static const List<int> _durations = [15, 20, 25, 30, 45, 60, 90];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0F),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildAccountCard(),
                const SizedBox(height: 20),
                _buildSectionHeader('Session Preferences', 'tune_rounded'),
                const SizedBox(height: 10),
                _buildSessionPrefsCard(),
                const SizedBox(height: 20),
                _buildSectionHeader('App Block List', 'block_rounded'),
                const SizedBox(height: 10),
                _buildAppBlockCard(),
                const SizedBox(height: 20),
                _buildSectionHeader('Notifications', 'notifications_rounded'),
                const SizedBox(height: 10),
                _buildNotificationsCard(),
                const SizedBox(height: 20),
                _buildDangerZoneCard(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: const Color(0xFF0D0D0F),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: const Color(0xFFE8E8ED),
            fontStyle: FontStyle.italic,
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1A1A2E), Color(0xFF0D0D0F)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String iconName) {
    return Row(
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: const Color(0xFFF97316),
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(0xFF8E8E93),
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildAccountCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF3A3A3C), width: 0.5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF97316), Color(0xFFA78BFA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Z',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Zayan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE8E8ED),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'zayan@focusflow.app',
                      style: TextStyle(fontSize: 13, color: Color(0xFF8E8E93)),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF97316).withAlpha(30),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFF97316).withAlpha(80),
                        ),
                      ),
                      child: const Text(
                        'Pro Plan',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF97316),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C2E),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const CustomIconWidget(
                    iconName: 'edit_rounded',
                    color: Color(0xFF8E8E93),
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFF2C2C2E), height: 1),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatPill('🔥', '14', 'Day Streak'),
              const SizedBox(width: 10),
              _buildStatPill('⚡', '87', 'Focus Score'),
              const SizedBox(width: 10),
              _buildStatPill('⏱', '142h', 'Total Focus'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatPill(String emoji, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFFE8E8ED),
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Color(0xFF8E8E93)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionPrefsCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF3A3A3C), width: 0.5),
      ),
      child: Column(
        children: [
          // Default session type
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Default Session Type',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFAEAEB2),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _sessionTypes.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final isSelected =
                          _sessionTypes[i] == _defaultSessionType;
                      return GestureDetector(
                        onTap: () => setState(
                          () => _defaultSessionType = _sessionTypes[i],
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFF97316).withAlpha(40)
                                : const Color(0xFF2C2C2E),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFF97316)
                                  : Colors.transparent,
                            ),
                          ),
                          child: Text(
                            _sessionTypes[i],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? const Color(0xFFF97316)
                                  : const Color(0xFF8E8E93),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xFF2C2C2E),
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
          // Default duration
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Default Duration',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFAEAEB2),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _durations.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) {
                      final isSelected = _durations[i] == _defaultDuration;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _defaultDuration = _durations[i]),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFA78BFA).withAlpha(40)
                                : const Color(0xFF2C2C2E),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFA78BFA)
                                  : Colors.transparent,
                            ),
                          ),
                          child: Text(
                            '${_durations[i]}m',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? const Color(0xFFA78BFA)
                                  : const Color(0xFF8E8E93),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xFF2C2C2E),
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
          _buildToggleRow(
            'Auto-start Breaks',
            'Automatically begin break timer after session',
            'self_improvement_rounded',
            const Color(0xFF34C759),
            _autoStartBreaks,
            (v) => setState(() => _autoStartBreaks = v),
          ),
          const Divider(
            color: Color(0xFF2C2C2E),
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
          _buildToggleRow(
            'Strict Mode',
            'Block all distractions — no overrides allowed',
            'lock_rounded',
            const Color(0xFFFF3B30),
            _strictMode,
            (v) => setState(() => _strictMode = v),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBlockCard() {
    final blockedCount = _blockedApps.where((a) => a['blocked'] == true).length;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF3A3A3C), width: 0.5),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Blocked During Sessions',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFE8E8ED),
                        ),
                      ),
                      Text(
                        '$blockedCount of ${_blockedApps.length} apps blocked',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF97316).withAlpha(30),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFF97316).withAlpha(80),
                      ),
                    ),
                    child: const Text(
                      '+ Add App',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFF97316),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFF2C2C2E), height: 1),
          ...List.generate(_blockedApps.length, (i) {
            final app = _blockedApps[i];
            final isLast = i == _blockedApps.length - 1;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Color(app['color'] as int).withAlpha(30),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: CustomIconWidget(
                            iconName: app['icon'] as String,
                            color: Color(app['color'] as int),
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
                      Switch(
                        value: app['blocked'] as bool,
                        onChanged: (v) =>
                            setState(() => _blockedApps[i]['blocked'] = v),
                        activeColor: const Color(0xFFF97316),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  const Divider(
                    color: Color(0xFF2C2C2E),
                    height: 1,
                    indent: 66,
                    endIndent: 16,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildNotificationsCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF3A3A3C), width: 0.5),
      ),
      child: Column(
        children: [
          _buildToggleRow(
            'Session Reminders',
            'Remind me when a scheduled session starts',
            'alarm_rounded',
            const Color(0xFFF97316),
            _sessionReminders,
            (v) => setState(() => _sessionReminders = v),
          ),
          const Divider(
            color: Color(0xFF2C2C2E),
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
          _buildToggleRow(
            'Streak Alerts',
            'Alert when streak is at risk of breaking',
            'local_fire_department_rounded',
            const Color(0xFFFF9F0A),
            _streakAlerts,
            (v) => setState(() => _streakAlerts = v),
          ),
          const Divider(
            color: Color(0xFF2C2C2E),
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
          _buildToggleRow(
            'Break Reminders',
            'Nudge to take breaks between sessions',
            'self_improvement_rounded',
            const Color(0xFF34C759),
            _breakReminders,
            (v) => setState(() => _breakReminders = v),
          ),
          const Divider(
            color: Color(0xFF2C2C2E),
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
          _buildToggleRow(
            'Goal Achievements',
            'Celebrate when you hit focus milestones',
            'emoji_events_rounded',
            const Color(0xFFA78BFA),
            _goalAchievements,
            (v) => setState(() => _goalAchievements = v),
          ),
          const Divider(
            color: Color(0xFF2C2C2E),
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
          _buildToggleRow(
            'Weekly Report',
            'Summary of your focus performance each week',
            'bar_chart_rounded',
            const Color(0xFF0A84FF),
            _weeklyReport,
            (v) => setState(() => _weeklyReport = v),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow(
    String title,
    String subtitle,
    String iconName,
    Color iconColor,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withAlpha(30),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: iconName,
                color: iconColor,
                size: 18,
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
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF8E8E93),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFF97316),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  Widget _buildDangerZoneCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF3A3A3C), width: 0.5),
      ),
      child: Column(
        children: [
          _buildActionRow(
            'Export Focus Data',
            'Download your session history as CSV',
            'download_rounded',
            const Color(0xFF0A84FF),
            () {},
          ),
          const Divider(
            color: Color(0xFF2C2C2E),
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
          _buildActionRow(
            'Reset All Stats',
            'Clear all focus data and start fresh',
            'restart_alt_rounded',
            const Color(0xFFFF9F0A),
            () => _showResetDialog(),
          ),
          const Divider(
            color: Color(0xFF2C2C2E),
            height: 1,
            indent: 16,
            endIndent: 16,
          ),
          _buildActionRow(
            'Sign Out',
            'Log out of your FocusFlow account',
            'logout_rounded',
            const Color(0xFFFF3B30),
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow(
    String title,
    String subtitle,
    String iconName,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor.withAlpha(30),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: iconName,
                  color: iconColor,
                  size: 18,
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
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: iconColor == const Color(0xFFFF3B30)
                          ? const Color(0xFFFF3B30)
                          : const Color(0xFFE8E8ED),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF8E8E93),
                    ),
                  ),
                ],
              ),
            ),
            CustomIconWidget(
              iconName: 'chevron_right_rounded',
              color: const Color(0xFF48484A),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Reset All Stats?',
          style: TextStyle(
            color: Color(0xFFE8E8ED),
            fontWeight: FontWeight.w700,
          ),
        ),
        content: const Text(
          'This will permanently delete all your focus sessions, streaks, and insights. This action cannot be undone.',
          style: TextStyle(color: Color(0xFF8E8E93), fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF8E8E93)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Reset',
              style: TextStyle(
                color: Color(0xFFFF3B30),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
