import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

// Anatomy locked: time label LEFT + vertical connector line + icon circle + task card RIGHT
// Matches extracted TimelineItem anatomy from image

class TimelineTaskItemWidget extends StatelessWidget {
  final String timeRange;
  final String title;
  final String type;
  final String iconName;
  final Color color;
  final bool completed;
  final int appsBlocked;
  final bool enabled;
  final bool isLast;
  final ValueChanged<bool> onToggle;
  final VoidCallback? onTap;

  const TimelineTaskItemWidget({
    super.key,
    required this.timeRange,
    required this.title,
    required this.type,
    required this.iconName,
    required this.color,
    required this.completed,
    required this.appsBlocked,
    required this.enabled,
    required this.isLast,
    required this.onToggle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Time label — left column
          SizedBox(
            width: 72,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                timeRange.split(' - ').first,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8E8E93),
                  fontWeight: FontWeight.w500,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Vertical connector column
          Column(
            children: [
              // Icon circle
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: completed
                      ? color.withAlpha(38)
                      : enabled
                      ? color.withAlpha(26)
                      : const Color(0xFF2C2C2E),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: completed
                        ? color.withAlpha(128)
                        : enabled
                        ? color.withAlpha(77)
                        : const Color(0xFF3A3A3C),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: completed ? 'check_rounded' : iconName,
                    color: completed
                        ? color
                        : enabled
                        ? color
                        : const Color(0xFF8E8E93),
                    size: 16,
                  ),
                ),
              ),
              // Connector line
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5,
                    color: const Color(0xFF2C2C2E),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          // Task card — right column
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: completed
                        ? const Color(0xFF1A1A1C)
                        : const Color(0xFF1C1C1E),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: completed
                          ? const Color(0xFF2C2C2E)
                          : enabled
                          ? color.withAlpha(51)
                          : const Color(0xFF2C2C2E),
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              timeRange,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF8E8E93),
                                fontFeatures: [FontFeature.tabularFigures()],
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: completed
                                    ? const Color(0xFF8E8E93)
                                    : const Color(0xFFE8E8ED),
                                decoration: completed
                                    ? TextDecoration.lineThrough
                                    : null,
                                decorationColor: const Color(0xFF8E8E93),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: color.withAlpha(26),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    type,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (appsBlocked > 0) ...[
                                  const SizedBox(width: 6),
                                  CustomIconWidget(
                                    iconName: 'shield_rounded',
                                    color: const Color(0xFF8E8E93),
                                    size: 10,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    '$appsBlocked apps',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF8E8E93),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: enabled,
                        onChanged: completed ? null : onToggle,
                        activeThumbColor: color,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
