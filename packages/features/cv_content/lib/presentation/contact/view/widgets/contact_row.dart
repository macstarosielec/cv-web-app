import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactRow extends StatelessWidget {
  const ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    this.url,
    super.key,
  });

  final Widget icon;
  final String label;
  final String value;
  final String? url;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final content = Row(
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
        Expanded(
          child: Column(
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
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );

    if (url != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => unawaited(launchUrl(Uri.parse(url!))),
            child: content,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: content,
    );
  }
}
