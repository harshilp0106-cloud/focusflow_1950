import '../../../core/app_export.dart';

// Anatomy locked: 7-col row, day label + date + avatar row, active = highlighted pill

class WeekCalendarWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDaySelected;

  const WeekCalendarWidget({
    super.key,
    required this.selectedIndex,
    required this.onDaySelected,
  });

  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const _dates = [5, 6, 7, 8, 9, 10, 11];

  static final _avatarUrls = [
    'https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg',
    'https://images.pixabay.com/photo/2016/11/21/12/42/beard-1845166_640.jpg',
    'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg',
    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg',
    'https://images.pixabay.com/photo/2017/08/01/08/29/people-2563491_640.jpg',
    null,
    null,
  ];

  static const _avatarSemantics = [
    'Woman with long brown hair smiling',
    'Man with beard in casual wear',
    'Woman with curly hair looking left',
    'Young man professional headshot',
    'Person in outdoor setting',
    null,
    null,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2C2C2E), width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(7, (i) {
          final isSelected = i == selectedIndex;
          return GestureDetector(
            onTap: () => onDaySelected(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              width: 40,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFF97316).withAlpha(38)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFF97316).withAlpha(102)
                      : Colors.transparent,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _days[i],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color: isSelected
                          ? const Color(0xFFF97316)
                          : const Color(0xFF8E8E93),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${_dates[i]}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected
                          ? const Color(0xFFF97316)
                          : const Color(0xFFE8E8ED),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Avatar row
                  if (_avatarUrls[i] != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: CustomImageWidget(
                        imageUrl: _avatarUrls[i]!,
                        width: 20,
                        height: 20,
                        fit: BoxFit.cover,
                        semanticLabel: _avatarSemantics[i] ?? '',
                      ),
                    )
                  else
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2E),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
