import 'package:flutter/material.dart';

class StatusBadgeWidget extends StatelessWidget {
  final String label;
  final Color color;
  final Color? textColor;

  const StatusBadgeWidget({
    super.key,
    required this.label,
    required this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(38),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withAlpha(77), width: 0.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor ?? color,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
