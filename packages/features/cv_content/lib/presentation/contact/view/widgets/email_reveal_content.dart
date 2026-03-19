import 'dart:async';

import 'package:cv_content/presentation/contact/view/widgets/email_row.dart';
import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class CharState {
  CharState({required this.char, required this.opacity});

  final String char;
  final double opacity;
}

class EmailRevealContent extends StatelessWidget {
  const EmailRevealContent({
    required this.email,
    required this.revealed,
    required this.revealing,
    required this.revealedCount,
    required this.chars,
    required this.accentColor,
    required this.textTheme,
    required this.baseStyle,
    required this.onReveal,
    super.key,
  });

  final String email;
  final bool revealed;
  final bool revealing;
  final int revealedCount;
  final List<CharState> chars;
  final Color accentColor;
  final TextTheme textTheme;
  final TextStyle? baseStyle;
  final VoidCallback onReveal;

  static const _charWidth = 10.0;
  static const _charHeight = 24.0;

  @override
  Widget build(BuildContext context) {
    if (revealed) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () =>
              unawaited(launchUrl(Uri.parse('mailto:$email'))),
          child: EmailRow(
            accentColor: accentColor,
            cells: _buildCharCells(
              email,
              List.filled(
                email.length,
                baseStyle?.copyWith(color: ColorName.textPrimary),
              ),
            ),
          ),
        ),
      );
    }

    if (revealing) {
      final styles = <TextStyle?>[
        for (var i = 0; i < chars.length; i++)
          if (i < revealedCount)
            baseStyle?.copyWith(color: ColorName.textPrimary)
          else
            baseStyle?.copyWith(
              color: accentColor.withValues(alpha: chars[i].opacity),
            ),
      ];

      final text = StringBuffer();
      for (var i = 0; i < chars.length; i++) {
        text.write(i < revealedCount ? email[i] : chars[i].char);
      }

      return EmailRow(
        accentColor: accentColor,
        cells: _buildCharCells(text.toString(), styles),
      );
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onReveal,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: accentColor.withValues(alpha: 0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lock_outline,
                size: AppDimensions.iconSizeDefault,
                color: accentColor,
              ),
              const SizedBox(width: AppDimensions.spacingSmall),
              Text(
                'Reveal Email',
                style: textTheme.bodyMedium?.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCharCells(String text, List<TextStyle?> styles) => [
        for (var i = 0; i < text.length; i++)
          SizedBox(
            width: _charWidth,
            height: _charHeight,
            child: Center(
              child: Text(
                text[i],
                style: styles[i],
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ];
}
