import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: ColorName.textPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
      );
}
