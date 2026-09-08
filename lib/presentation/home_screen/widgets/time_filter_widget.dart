import 'package:flutter/material.dart';

class TimeFilterWidget extends StatelessWidget {
  final List<String> filters;
  final String selected;
  final ValueChanged<String> onSelected;

  const TimeFilterWidget({
    super.key,
    required this.filters,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final isActive = filters[i] == selected;
          return GestureDetector(
            onTap: () => onSelected(filters[i]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFFF97316).withAlpha(38)
                    : const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: isActive
                      ? const Color(0xFFF97316).withAlpha(102)
                      : const Color(0xFF3A3A3C),
                  width: 1,
                ),
              ),
              child: Text(
                filters[i],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: isActive
                      ? const Color(0xFFF97316)
                      : const Color(0xFF8E8E93),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
