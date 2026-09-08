import '../../../core/app_export.dart';

class SessionTypeSelectorWidget extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const SessionTypeSelectorWidget({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  static const _types = [
    ('Deep Work', 'bolt_rounded', Color(0xFFF97316)),
    ('Study', 'menu_book_rounded', Color(0xFFA78BFA)),
    ('Coding', 'code_rounded', Color(0xFF0A84FF)),
    ('Writing', 'edit_rounded', Color(0xFF34C759)),
    ('Research', 'search_rounded', Color(0xFFFF9F0A)),
    ('Reading', 'chrome_reader_mode_rounded', Color(0xFF64D2FF)),
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
          const Text(
            'Session Type',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFFE8E8ED),
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _types.map((t) {
              final (name, icon, color) = t;
              final isActive = selected == name;
              return GestureDetector(
                onTap: () => onSelected(name),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? color.withAlpha(38)
                        : const Color(0xFF2C2C2E),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isActive
                          ? color.withAlpha(128)
                          : const Color(0xFF3A3A3C),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: icon,
                        color: isActive ? color : const Color(0xFF8E8E93),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isActive ? color : const Color(0xFFAEAEB2),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
