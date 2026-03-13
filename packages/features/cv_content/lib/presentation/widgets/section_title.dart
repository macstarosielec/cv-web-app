import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/theme/theme.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {this.fontSize = 13, super.key});

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: AppTheme.accentStyle(fontSize: fontSize).copyWith(
        color: ColorName.textPrimary,
        letterSpacing: 2,
      ),
    );
  }
}
