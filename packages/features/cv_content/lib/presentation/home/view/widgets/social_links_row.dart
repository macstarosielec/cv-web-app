import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/utils/social_link_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinksRow extends StatelessWidget {
  const SocialLinksRow({required this.socialLinks, super.key});

  final List<SocialLink> socialLinks;

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.primary;

    return Wrap(
      spacing: 12,
      runSpacing: AppDimensions.tagSpacing,
      children: socialLinks
          .map(
            (link) => Tooltip(
              message: link.name,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => unawaited(launchUrl(Uri.parse(link.url))),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ColorName.surfaceLight,
                      border: Border.all(color: ColorName.surfaceBorder),
                    ),
                    child: FaIcon(
                      socialLinkIcon(link.name),
                      size: AppDimensions.iconSizeDefault,
                      color: accentColor,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
