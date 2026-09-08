import 'package:flutter/material.dart';
import '../../../core/app_export.dart';

class DurationPickerWidget extends StatelessWidget {
  final int minutes;
  final ValueChanged<int> onChanged;

  const DurationPickerWidget({
    super.key,
    required this.minutes,
    required this.onChanged,
  });

  static const _presets = [15, 25, 45, 60, 90, 120];

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
                'Duration',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFE8E8ED),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF97316).withAlpha(31),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '$minutes min',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFFF97316),
                    fontWeight: FontWeight.w700,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Custom slider
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFFF97316),
              inactiveTrackColor: const Color(0xFF2C2C2E),
              thumbColor: const Color(0xFFF97316),
              overlayColor: const Color(0xFFF97316).withAlpha(31),
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            ),
            child: Slider(
              value: minutes.toDouble(),
              min: 5,
              max: 120,
              divisions: 23,
              onChanged: (v) => onChanged(v.round()),
            ),
          ),
          const SizedBox(height: 12),
          // Presets
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _presets.map((p) {
              final isActive = minutes == p;
              return GestureDetector(
                onTap: () => onChanged(p),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 44,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFFF97316).withAlpha(38)
                        : const Color(0xFF2C2C2E),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isActive
                          ? const Color(0xFFF97316).withAlpha(102)
                          : const Color(0xFF3A3A3C),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      p >= 60 ? '${p ~/ 60}h' : '${p}m',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isActive
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: isActive
                            ? const Color(0xFFF97316)
                            : const Color(0xFF8E8E93),
                      ),
                    ),
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
