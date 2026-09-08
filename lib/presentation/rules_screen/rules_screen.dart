import '../../core/app_export.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/ai_recommend_card_widget.dart';
import './widgets/timeline_task_item_widget.dart';
import './widgets/week_calendar_widget.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({super.key});

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  int _selectedDayIndex = 3;

  final List<Map<String, dynamic>> _rulesMaps = [
    {
      'id': 'rule_001',
      'timeRange': '08:00 - 10:00',
      'title': 'Morning Deep Work Block',
      'type': 'Deep Work',
      'iconName': 'bolt_rounded',
      'color': 0xFFF97316,
      'completed': true,
      'appsBlocked': 5,
      'enabled': true,
    },
    {
      'id': 'rule_002',
      'timeRange': '10:30 - 11:00',
      'title': 'Email & Slack Window',
      'type': 'Communication',
      'iconName': 'mark_email_read_rounded',
      'color': 0xFF34C759,
      'completed': true,
      'appsBlocked': 0,
      'enabled': true,
    },
    {
      'id': 'rule_003',
      'timeRange': '11:00 - 12:30',
      'title': 'Coding Session',
      'type': 'Coding',
      'iconName': 'code_rounded',
      'color': 0xFF0A84FF,
      'completed': false,
      'appsBlocked': 8,
      'enabled': true,
    },
    {
      'id': 'rule_004',
      'timeRange': '13:00 - 14:00',
      'title': 'Lunch Break (No Blocks)',
      'type': 'Break',
      'iconName': 'restaurant_rounded',
      'color': 0xFFFF9F0A,
      'completed': false,
      'appsBlocked': 0,
      'enabled': false,
    },
    {
      'id': 'rule_005',
      'timeRange': '14:00 - 16:00',
      'title': 'Research & Writing',
      'type': 'Writing',
      'iconName': 'edit_rounded',
      'color': 0xFFA78BFA,
      'completed': false,
      'appsBlocked': 6,
      'enabled': true,
    },
    {
      'id': 'rule_006',
      'timeRange': '16:30 - 17:30',
      'title': 'Study Session',
      'type': 'Study',
      'iconName': 'menu_book_rounded',
      'color': 0xFF64D2FF,
      'completed': false,
      'appsBlocked': 4,
      'enabled': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0F),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBarWidget(
          title: 'Your Upcoming Task',
          subtitle: 'Data-driven recommendations for you',
          isItalic: true,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton.extended(
          onPressed: _showCreateRuleSheet,
          backgroundColor: const Color(0xFFF97316),
          elevation: 8,
          icon: const CustomIconWidget(
            iconName: 'add_rounded',
            color: Colors.white,
            size: 24,
          ),
          label: const Text(
            'Add Rule',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 80 + MediaQuery.of(context).padding.top),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: WeekCalendarWidget(
                  selectedIndex: _selectedDayIndex,
                  onDaySelected: (i) => setState(() => _selectedDayIndex = i),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: AiRecommendCardWidget(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Protection Rules',
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
                        color: const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '${_rulesMaps.where((r) => r['enabled'] as bool).length} active',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF8E8E93),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, i) {
                final rule = _rulesMaps[i];
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 0,
                  ),
                  child: TimelineTaskItemWidget(
                    timeRange: rule['timeRange'] as String,
                    title: rule['title'] as String,
                    type: rule['type'] as String,
                    iconName: rule['iconName'] as String,
                    color: Color(rule['color'] as int),
                    completed: rule['completed'] as bool,
                    appsBlocked: rule['appsBlocked'] as int,
                    enabled: rule['enabled'] as bool,
                    isLast: i == _rulesMaps.length - 1,
                    onToggle: (v) {
                      setState(() {
                        _rulesMaps[i]['enabled'] = v;
                      });
                    },
                    onTap: () => _showEditRuleSheet(i),
                  ),
                );
              }, childCount: _rulesMaps.length),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  void _showCreateRuleSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1C1C1E),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _CreateRuleSheet(
        onRuleCreated: (newRule) {
          setState(() {
            _rulesMaps.add(newRule);
          });
        },
      ),
    );
  }

  void _showEditRuleSheet(int index) {
    final rule = _rulesMaps[index];
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1C1C1E),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _EditRuleSheet(
        rule: rule,
        onRuleUpdated: (updatedRule) {
          setState(() {
            _rulesMaps[index] = updatedRule;
          });
        },
        onRuleDeleted: () {
          setState(() {
            _rulesMaps.removeAt(index);
          });
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Create Rule Bottom Sheet — fully functional
// ─────────────────────────────────────────────────────────────────────────────

class _CreateRuleSheet extends StatefulWidget {
  final void Function(Map<String, dynamic> rule) onRuleCreated;

  const _CreateRuleSheet({required this.onRuleCreated});

  @override
  State<_CreateRuleSheet> createState() => _CreateRuleSheetState();
}

class _CreateRuleSheetState extends State<_CreateRuleSheet> {
  final _nameController = TextEditingController();
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 11, minute: 0);
  String _selectedType = 'Deep Work';
  final Set<String> _selectedApps = {};
  bool _enabled = true;

  static const List<Map<String, dynamic>> _sessionTypes = [
    {'label': 'Deep Work', 'icon': 'bolt_rounded', 'color': 0xFFF97316},
    {'label': 'Study', 'icon': 'menu_book_rounded', 'color': 0xFF64D2FF},
    {'label': 'Coding', 'icon': 'code_rounded', 'color': 0xFF0A84FF},
    {'label': 'Writing', 'icon': 'edit_rounded', 'color': 0xFFA78BFA},
    {
      'label': 'Communication',
      'icon': 'mark_email_read_rounded',
      'color': 0xFF34C759,
    },
    {'label': 'Break', 'icon': 'restaurant_rounded', 'color': 0xFFFF9F0A},
  ];

  static const List<Map<String, String>> _availableApps = [
    {'name': 'Instagram', 'icon': 'photo_camera_rounded'},
    {'name': 'Twitter', 'icon': 'tag_rounded'},
    {'name': 'YouTube', 'icon': 'play_circle_rounded'},
    {'name': 'TikTok', 'icon': 'music_note_rounded'},
    {'name': 'Reddit', 'icon': 'forum_rounded'},
    {'name': 'Netflix', 'icon': 'live_tv_rounded'},
    {'name': 'WhatsApp', 'icon': 'chat_bubble_rounded'},
    {'name': 'Slack', 'icon': 'workspaces_rounded'},
    {'name': 'Discord', 'icon': 'headset_mic_rounded'},
    {'name': 'Games', 'icon': 'sports_esports_rounded'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String _formatTime(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  Future<void> _pickTime({required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFF97316),
            onPrimary: Colors.white,
            surface: Color(0xFF2C2C2E),
            onSurface: Color(0xFFE8E8ED),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  Map<String, dynamic>? _selectedTypeData() {
    return _sessionTypes.firstWhere(
      (t) => t['label'] == _selectedType,
      orElse: () => _sessionTypes.first,
    );
  }

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a rule name'),
          backgroundColor: Color(0xFF2C2C2E),
        ),
      );
      return;
    }

    final typeData = _selectedTypeData()!;
    final timeRange = '${_formatTime(_startTime)} - ${_formatTime(_endTime)}';

    final newRule = {
      'id': 'rule_${DateTime.now().millisecondsSinceEpoch}',
      'timeRange': timeRange,
      'title': name,
      'type': _selectedType,
      'iconName': typeData['icon'] as String,
      'color': typeData['color'] as int,
      'completed': false,
      'appsBlocked': _selectedApps.length,
      'enabled': _enabled,
    };

    widget.onRuleCreated(newRule);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final typeData = _selectedTypeData()!;
    final accentColor = Color(typeData['color'] as int);

    return Padding(
      padding: EdgeInsets.only(
        top: 0,
        left: 0,
        right: 0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A3A3C),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Header
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: accentColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: typeData['icon'] as String,
                        color: accentColor,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Protection Rule',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFE8E8ED),
                        ),
                      ),
                      Text(
                        'Block distractions on a schedule',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8E8E93),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Rule Name
              _SectionLabel(label: 'Rule Name'),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                style: const TextStyle(
                  color: Color(0xFFE8E8ED),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'e.g. Morning Deep Work',
                  hintStyle: const TextStyle(
                    color: Color(0xFF8E8E93),
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF2C2C2E),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFF3A3A3C)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFF3A3A3C)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFF97316),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Time Range
              _SectionLabel(label: 'Time Range'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _TimePickerButton(
                      label: 'Start',
                      time: _startTime,
                      onTap: () => _pickTime(isStart: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const CustomIconWidget(
                      iconName: 'arrow_forward_rounded',
                      color: Color(0xFF8E8E93),
                      size: 18,
                    ),
                  ),
                  Expanded(
                    child: _TimePickerButton(
                      label: 'End',
                      time: _endTime,
                      onTap: () => _pickTime(isStart: false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Session Type
              _SectionLabel(label: 'Session Type'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _sessionTypes.map((t) {
                  final isSelected = _selectedType == t['label'];
                  final tColor = Color(t['color'] as int);
                  return GestureDetector(
                    onTap: () =>
                        setState(() => _selectedType = t['label'] as String),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? tColor.withAlpha(40)
                            : const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isSelected
                              ? tColor.withAlpha(150)
                              : const Color(0xFF3A3A3C),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(
                            iconName: t['icon'] as String,
                            color: isSelected
                                ? tColor
                                : const Color(0xFF8E8E93),
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            t['label'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? tColor
                                  : const Color(0xFF8E8E93),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Apps to Block
              _SectionLabel(label: 'Apps to Block'),
              const SizedBox(height: 4),
              Text(
                '${_selectedApps.length} selected',
                style: const TextStyle(fontSize: 11, color: Color(0xFF8E8E93)),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableApps.map((app) {
                  final isSelected = _selectedApps.contains(app['name']);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedApps.remove(app['name']);
                        } else {
                          _selectedApps.add(app['name']!);
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFF97316).withAlpha(30)
                            : const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFF97316).withAlpha(150)
                              : const Color(0xFF3A3A3C),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isSelected) ...[
                            const CustomIconWidget(
                              iconName: 'check_circle_rounded',
                              color: Color(0xFFF97316),
                              size: 12,
                            ),
                            const SizedBox(width: 5),
                          ],
                          CustomIconWidget(
                            iconName: app['icon']!,
                            color: isSelected
                                ? const Color(0xFFF97316)
                                : const Color(0xFF8E8E93),
                            size: 13,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            app['name']!,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? const Color(0xFFF97316)
                                  : const Color(0xFFAEAEB2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Enable toggle
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF3A3A3C)),
                ),
                child: Row(
                  children: [
                    const CustomIconWidget(
                      iconName: 'power_settings_new_rounded',
                      color: Color(0xFF8E8E93),
                      size: 18,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enable Rule',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFE8E8ED),
                            ),
                          ),
                          Text(
                            'Rule will be active immediately',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF8E8E93),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _enabled,
                      onChanged: (v) => setState(() => _enabled = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Save button
              GestureDetector(
                onTap: _save,
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFF97316), Color(0xFFEA580C)],
                    ),
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF97316).withAlpha(60),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Create Rule',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Edit Rule Bottom Sheet
// ─────────────────────────────────────────────────────────────────────────────

class _EditRuleSheet extends StatefulWidget {
  final Map<String, dynamic> rule;
  final void Function(Map<String, dynamic> rule) onRuleUpdated;
  final VoidCallback onRuleDeleted;

  const _EditRuleSheet({
    required this.rule,
    required this.onRuleUpdated,
    required this.onRuleDeleted,
  });

  @override
  State<_EditRuleSheet> createState() => _EditRuleSheetState();
}

class _EditRuleSheetState extends State<_EditRuleSheet> {
  late final TextEditingController _nameController;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late String _selectedType;
  late Set<String> _selectedApps;
  late bool _enabled;

  static const List<Map<String, dynamic>> _sessionTypes = [
    {'label': 'Deep Work', 'icon': 'bolt_rounded', 'color': 0xFFF97316},
    {'label': 'Study', 'icon': 'menu_book_rounded', 'color': 0xFF64D2FF},
    {'label': 'Coding', 'icon': 'code_rounded', 'color': 0xFF0A84FF},
    {'label': 'Writing', 'icon': 'edit_rounded', 'color': 0xFFA78BFA},
    {
      'label': 'Communication',
      'icon': 'mark_email_read_rounded',
      'color': 0xFF34C759,
    },
    {'label': 'Break', 'icon': 'restaurant_rounded', 'color': 0xFFFF9F0A},
  ];

  static const List<Map<String, String>> _availableApps = [
    {'name': 'Instagram', 'icon': 'photo_camera_rounded'},
    {'name': 'Twitter', 'icon': 'tag_rounded'},
    {'name': 'YouTube', 'icon': 'play_circle_rounded'},
    {'name': 'TikTok', 'icon': 'music_note_rounded'},
    {'name': 'Reddit', 'icon': 'forum_rounded'},
    {'name': 'Netflix', 'icon': 'live_tv_rounded'},
    {'name': 'WhatsApp', 'icon': 'chat_bubble_rounded'},
    {'name': 'Slack', 'icon': 'workspaces_rounded'},
    {'name': 'Discord', 'icon': 'headset_mic_rounded'},
    {'name': 'Games', 'icon': 'sports_esports_rounded'},
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.rule['title'] as String,
    );
    _selectedType = widget.rule['type'] as String;
    _enabled = widget.rule['enabled'] as bool;

    // Parse time range "HH:MM - HH:MM"
    final parts = (widget.rule['timeRange'] as String).split(' - ');
    _startTime = _parseTime(parts[0]);
    _endTime = _parseTime(parts.length > 1 ? parts[1] : parts[0]);

    // Pre-select apps based on appsBlocked count (best effort)
    _selectedApps = {};
  }

  TimeOfDay _parseTime(String s) {
    final parts = s.trim().split(':');
    if (parts.length == 2) {
      return TimeOfDay(
        hour: int.tryParse(parts[0]) ?? 9,
        minute: int.tryParse(parts[1]) ?? 0,
      );
    }
    return const TimeOfDay(hour: 9, minute: 0);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String _formatTime(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  Future<void> _pickTime({required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFF97316),
            onPrimary: Colors.white,
            surface: Color(0xFF2C2C2E),
            onSurface: Color(0xFFE8E8ED),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  Map<String, dynamic> _selectedTypeData() {
    return _sessionTypes.firstWhere(
      (t) => t['label'] == _selectedType,
      orElse: () => _sessionTypes.first,
    );
  }

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a rule name'),
          backgroundColor: Color(0xFF2C2C2E),
        ),
      );
      return;
    }

    final typeData = _selectedTypeData();
    final timeRange = '${_formatTime(_startTime)} - ${_formatTime(_endTime)}';

    final updatedRule = {
      'id': widget.rule['id'],
      'timeRange': timeRange,
      'title': name,
      'type': _selectedType,
      'iconName': typeData['icon'] as String,
      'color': typeData['color'] as int,
      'completed': widget.rule['completed'],
      'appsBlocked': _selectedApps.length,
      'enabled': _enabled,
    };

    widget.onRuleUpdated(updatedRule);
    Navigator.of(context).pop();
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text(
          'Delete Rule',
          style: TextStyle(
            color: Color(0xFFE8E8ED),
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        content: const Text(
          'Are you sure you want to delete this rule? This action cannot be undone.',
          style: TextStyle(color: Color(0xFF8E8E93), fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF8E8E93)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
              widget.onRuleDeleted();
            },
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Color(0xFFFF453A),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final typeData = _selectedTypeData();
    final accentColor = Color(typeData['color'] as int);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A3A3C),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Header
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: accentColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: typeData['icon'] as String,
                        color: accentColor,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Edit Rule',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFE8E8ED),
                          ),
                        ),
                        Text(
                          'Update your protection rule',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8E8E93),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Delete button
                  GestureDetector(
                    onTap: _confirmDelete,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF453A).withAlpha(20),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFFF453A).withAlpha(60),
                        ),
                      ),
                      child: const CustomIconWidget(
                        iconName: 'delete_outline_rounded',
                        color: Color(0xFFFF453A),
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Rule Name
              _SectionLabel(label: 'Rule Name'),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                style: const TextStyle(
                  color: Color(0xFFE8E8ED),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'e.g. Morning Deep Work',
                  hintStyle: const TextStyle(
                    color: Color(0xFF8E8E93),
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF2C2C2E),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFF3A3A3C)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFF3A3A3C)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFF97316),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Time Range
              _SectionLabel(label: 'Time Range'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _TimePickerButton(
                      label: 'Start',
                      time: _startTime,
                      onTap: () => _pickTime(isStart: true),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CustomIconWidget(
                      iconName: 'arrow_forward_rounded',
                      color: Color(0xFF8E8E93),
                      size: 18,
                    ),
                  ),
                  Expanded(
                    child: _TimePickerButton(
                      label: 'End',
                      time: _endTime,
                      onTap: () => _pickTime(isStart: false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Session Type
              _SectionLabel(label: 'Session Type'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _sessionTypes.map((t) {
                  final isSelected = _selectedType == t['label'];
                  final tColor = Color(t['color'] as int);
                  return GestureDetector(
                    onTap: () =>
                        setState(() => _selectedType = t['label'] as String),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? tColor.withAlpha(40)
                            : const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isSelected
                              ? tColor.withAlpha(150)
                              : const Color(0xFF3A3A3C),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIconWidget(
                            iconName: t['icon'] as String,
                            color: isSelected
                                ? tColor
                                : const Color(0xFF8E8E93),
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            t['label'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? tColor
                                  : const Color(0xFF8E8E93),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Apps to Block
              _SectionLabel(label: 'Apps to Block'),
              const SizedBox(height: 4),
              Text(
                '${_selectedApps.length} selected',
                style: const TextStyle(fontSize: 11, color: Color(0xFF8E8E93)),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableApps.map((app) {
                  final isSelected = _selectedApps.contains(app['name']);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedApps.remove(app['name']);
                        } else {
                          _selectedApps.add(app['name']!);
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFF97316).withAlpha(30)
                            : const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFF97316).withAlpha(150)
                              : const Color(0xFF3A3A3C),
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isSelected) ...[
                            const CustomIconWidget(
                              iconName: 'check_circle_rounded',
                              color: Color(0xFFF97316),
                              size: 12,
                            ),
                            const SizedBox(width: 5),
                          ],
                          CustomIconWidget(
                            iconName: app['icon']!,
                            color: isSelected
                                ? const Color(0xFFF97316)
                                : const Color(0xFF8E8E93),
                            size: 13,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            app['name']!,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? const Color(0xFFF97316)
                                  : const Color(0xFFAEAEB2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Enable toggle
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF3A3A3C)),
                ),
                child: Row(
                  children: [
                    const CustomIconWidget(
                      iconName: 'power_settings_new_rounded',
                      color: Color(0xFF8E8E93),
                      size: 18,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enable Rule',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFE8E8ED),
                            ),
                          ),
                          Text(
                            'Rule will be active immediately',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF8E8E93),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _enabled,
                      onChanged: (v) => setState(() => _enabled = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Save button
              GestureDetector(
                onTap: _save,
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFF97316), Color(0xFFEA580C)],
                    ),
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF97316).withAlpha(60),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helper widgets
// ─────────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 12,
        color: Color(0xFF8E8E93),
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    );
  }
}

class _TimePickerButton extends StatelessWidget {
  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;

  const _TimePickerButton({
    required this.label,
    required this.time,
    required this.onTap,
  });

  String _format(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFF3A3A3C)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF8E8E93),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const CustomIconWidget(
                  iconName: 'schedule_rounded',
                  color: Color(0xFFF97316),
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  _format(time),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFE8E8ED),
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
