import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class ContactRow extends StatelessWidget {
  const ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  final Widget icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorName.surfaceLight,
              border: Border.all(color: ColorName.surfaceBorder),
            ),
            child: icon,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.bodySmall?.copyWith(
                  color: ColorName.textMuted,
                ),
              ),
              Text(
                value,
                style: textTheme.bodyMedium?.copyWith(
                  color: ColorName.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
