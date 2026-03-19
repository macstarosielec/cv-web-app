import 'dart:async';

import 'package:cv_content/presentation/contact/view/widgets/contact_row.dart';
import 'package:cv_content/presentation/contact/view/widgets/decode_email_reveal.dart';
import 'package:cv_content/presentation/contact/view/widgets/europe_map.dart';
import 'package:cv_content/presentation/contact/view/widgets/location_country_code.dart';
import 'package:cv_content/presentation/contact/view/widgets/location_info_row.dart';
import 'package:cv_content/presentation/widgets/section_title.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/utils/social_link_icons.dart';
import 'package:shared/widgets/accent_divider.dart';
import 'package:shared/widgets/stagger_item.dart';

class ContactPanelContent extends StatefulWidget {
  const ContactPanelContent({required this.profile, super.key});

  final Profile profile;

  @override
  State<ContactPanelContent> createState() => _ContactPanelContentState();
}

class _ContactPanelContentState extends State<ContactPanelContent>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  int get _itemCount =>
      (widget.profile.location != null ? 1 : 0) +
      (widget.profile.location != null || widget.profile.timezone != null
          ? 1
          : 0) +
      (widget.profile.phoneNumber != null ? 1 : 0) +
      widget.profile.socialLinks.length;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _itemCount,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );
    _animations = _controllers
        .map(
          (c) => CurvedAnimation(
            parent: c,
            curve: Curves.easeOutCubic,
          ),
        )
        .toList();
    unawaited(_staggerAnimations());
  }

  Future<void> _staggerAnimations() async {
    for (final controller in _controllers) {
      await Future<void>.delayed(const Duration(milliseconds: 80));
      if (mounted) unawaited(controller.forward());
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final accentColor = Theme.of(context).colorScheme.primary;
    final profile = widget.profile;

    final allItems = <Widget>[];
    var index = 0;

    // Map
    if (profile.location != null) {
      allItems.add(
        StaggerItem(
          animation: _animations[index++],
          child: Center(
            child: SizedBox(
              height: 180,
              child: EuropeMap(
                countryCode: locationToCountryCode(profile.location!),
              ),
            ),
          ),
        ),
      );
    }

    // Location & timezone
    if (profile.location != null || profile.timezone != null) {
      allItems.add(
        StaggerItem(
          animation: _animations[index++],
          child: LocationInfoRow(
            location: profile.location,
            timezone: profile.timezone,
          ),
        ),
      );
    }

    final items = <Widget>[];

    // Phone
    if (profile.phoneNumber != null) {
      items.add(
        StaggerItem(
          animation: _animations[index++],
          child: ContactRow(
            icon: Icon(
              Icons.phone_outlined,
              size: AppDimensions.iconSizeMedium,
              color: accentColor,
            ),
            label: l10n.phone,
            value: profile.phoneNumber!,
            url: 'tel:${profile.phoneNumber}',
          ),
        ),
      );
    }

    // Social links
    for (final link in profile.socialLinks) {
      items.add(
        StaggerItem(
          animation: _animations[index++],
          child: ContactRow(
            icon: FaIcon(
              socialLinkIcon(link.name),
              size: AppDimensions.iconSizeMedium,
              color: accentColor,
            ),
            label: link.name,
            value: _shortenUrl(link.url),
            url: link.url,
          ),
        ),
      );
    }

    // Build two-column grid from items
    final rows = <Widget>[];
    for (var i = 0; i < items.length; i += 2) {
      final hasSecond = i + 1 < items.length;
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: items[i]),
            if (hasSecond) ...[
              const SizedBox(width: AppDimensions.spacingMedium),
              Expanded(child: items[i + 1]),
            ] else
              const Expanded(child: SizedBox.shrink()),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...allItems,
          if (allItems.isNotEmpty)
            const SizedBox(height: AppDimensions.spacingLarge),
          SectionTitle(l10n.contact),
          const SizedBox(height: AppDimensions.spacingLarge),
          Center(child: DecodeEmailReveal(email: profile.email)),
          const SizedBox(height: AppDimensions.spacingXLarge),
          const AccentDivider(),
          const SizedBox(height: AppDimensions.spacingLarge),
          ...rows,
        ],
      ),
    );
  }

  String _shortenUrl(String url) {
    var short = url
        .replaceFirst(RegExp('https?://'), '')
        .replaceFirst('www.', '');
    if (short.endsWith('/')) short = short.substring(0, short.length - 1);
    return short;
  }
}
