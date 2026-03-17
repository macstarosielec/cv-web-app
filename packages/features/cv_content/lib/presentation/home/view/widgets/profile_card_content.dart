import 'dart:async';

import 'package:cv_content/presentation/home/view/widgets/social_links_row.dart';
import 'package:cv_content/presentation/models/detail_panel_type.dart';
import 'package:cv_content/presentation/widgets/navigation_chips_row.dart';
import 'package:cv_content/presentation/widgets/section_title.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/theme/theme.dart';
import 'package:shared/widgets/stagger_item.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileCardContent extends StatefulWidget {
  const ProfileCardContent({
    required this.profile,
    required this.selectedPanels,
    required this.onChipSelected,
    this.animate = false,
    this.showNavigationChips = true,
    super.key,
  });

  final Profile profile;
  final Set<DetailPanelType> selectedPanels;
  final ValueChanged<DetailPanelType> onChipSelected;
  final bool animate;
  final bool showNavigationChips;

  @override
  State<ProfileCardContent> createState() => _ProfileCardContentState();
}

class _ProfileCardContentState extends State<ProfileCardContent>
    with TickerProviderStateMixin {
  static const _itemCount = 6;
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _itemCount,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        value: widget.animate ? 0 : 1,
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

    if (widget.animate) {
      unawaited(_staggerAnimations());
    }
  }

  Future<void> _staggerAnimations() async {
    for (final controller in _controllers) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
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
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);
    final profile = widget.profile;

    final hasBottomRow = profile.location != null ||
        profile.timezone != null ||
        profile.cvUrl != null ||
        profile.socialLinks.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StaggerItem(
          animation: _animations[0],
          child: Text(
            profile.fullName,
            style: textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: ColorName.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 4),
        StaggerItem(
          animation: _animations[1],
          child: Text(
            profile.title,
            style: AppTheme.accentStyle(fontSize: 18).copyWith(
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spacingLarge),
        StaggerItem(
          animation: _animations[2],
          child: Text(
            profile.about,
            style: textTheme.bodyLarge?.copyWith(
              color: ColorName.textSecondary,
              height: 1.6,
            ),
          ),
        ),
        if (widget.showNavigationChips) ...[
          const SizedBox(height: 32),
          StaggerItem(
            animation: _animations[3],
            child: NavigationChipsRow(
              selectedPanels: widget.selectedPanels,
              onChipSelected: widget.onChipSelected,
            ),
          ),
        ],
        if (profile.languages.isNotEmpty ||
            profile.interests.isNotEmpty) ...[
          const SizedBox(height: AppDimensions.spacingLarge),
          StaggerItem(
            animation: _animations[4],
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (profile.languages.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(l10n.languages),
                        const SizedBox(height: AppDimensions.spacingSmall),
                        Wrap(
                          spacing: AppDimensions.tagSpacing,
                          runSpacing: AppDimensions.tagSpacing,
                          children: profile.languages
                              .map(
                                (lang) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: ColorName.surfaceLight,
                                  ),
                                  child: Text(
                                    '${lang.name} (${lang.proficiency.label})',
                                    style: textTheme.bodySmall?.copyWith(
                                      color: ColorName.textSecondary,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                if (profile.languages.isNotEmpty &&
                    profile.interests.isNotEmpty)
                  const SizedBox(width: 24),
                if (profile.interests.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(l10n.interests),
                        const SizedBox(height: AppDimensions.spacingSmall),
                        Wrap(
                          spacing: AppDimensions.tagSpacing,
                          runSpacing: AppDimensions.tagSpacing,
                          children: profile.interests
                              .map(
                                (interest) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: ColorName.surfaceLight,
                                  ),
                                  child: Text(
                                    interest,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: ColorName.textSecondary,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
        if (hasBottomRow) ...[
          const Spacer(),
          const SizedBox(height: 32),
          StaggerItem(
            animation: _animations[5],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (profile.location != null) ...[
                      const Icon(
                        Icons.location_on_outlined,
                        size: AppDimensions.iconSizeDefault,
                        color: ColorName.textMuted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        profile.location!,
                        style: textTheme.bodySmall?.copyWith(
                          color: ColorName.textSecondary,
                        ),
                      ),
                    ],
                    if (profile.location != null && profile.timezone != null)
                      const SizedBox(width: 16),
                    if (profile.timezone != null) ...[
                      const Icon(
                        Icons.schedule,
                        size: AppDimensions.iconSizeDefault,
                        color: ColorName.textMuted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        profile.timezone!,
                        style: textTheme.bodySmall?.copyWith(
                          color: ColorName.textSecondary,
                        ),
                      ),
                    ],
                    const Spacer(),
                    if (profile.cvUrl != null)
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => unawaited(
                            launchUrl(Uri.parse(profile.cvUrl!)),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.download,
                                  size: AppDimensions.iconSizeDefault,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: AppDimensions.spacingExtraSmall),
                                Text(
                                  l10n.downloadCv,
                                  style: textTheme.bodySmall?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                if (profile.socialLinks.isNotEmpty) ...[
                  const SizedBox(height: AppDimensions.spacingMedium),
                  SocialLinksRow(socialLinks: profile.socialLinks),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}
