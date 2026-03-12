import 'dart:async';

import 'package:cv_content/presentation/home/view/home_view.dart';
import 'package:cv_content/presentation/home/view/widgets/gradient_card.dart';
import 'package:cv_content/presentation/home/view/widgets/navigation_chip.dart';
import 'package:cv_content/presentation/home/view/widgets/section_title.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/theme/theme.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    required this.profile,
    required this.selectedPanel,
    required this.onChipSelected,
    this.animate = false,
    super.key,
  });

  final Profile profile;
  final DetailPanelType? selectedPanel;
  final ValueChanged<DetailPanelType> onChipSelected;
  final bool animate;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard>
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

  Widget _staggerItem(int index, Widget child) {
    return AnimatedBuilder(
      animation: _animations[index],
      builder: (context, c) => Transform.translate(
        offset: Offset(0, 16 * (1 - _animations[index].value)),
        child: Opacity(
          opacity: _animations[index].value,
          child: c,
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);
    final profile = widget.profile;

    return GradientCard(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _staggerItem(
              0,
              Text(
                profile.fullName,
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: ColorName.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            _staggerItem(
              1,
              Text(
                profile.title,
                style: AppTheme.accentStyle(fontSize: 24).copyWith(
                  color: ColorName.accent,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _staggerItem(
              2,
              Text(
                profile.about,
                style: textTheme.bodyLarge?.copyWith(
                  color: ColorName.textSecondary,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 32),
            _staggerItem(
              3,
              Row(
                children: [
                  Expanded(
                    child: NavigationChip(
                      label: l10n.projects,
                      icon: Icons.code_rounded,
                      isSelected:
                          widget.selectedPanel == DetailPanelType.projects,
                      onTap: () =>
                          widget.onChipSelected(DetailPanelType.projects),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: NavigationChip(
                      label: l10n.experience,
                      icon: Icons.work_outline_rounded,
                      isSelected:
                          widget.selectedPanel ==
                              DetailPanelType.experience,
                      onTap: () => widget.onChipSelected(
                        DetailPanelType.experience,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: NavigationChip(
                      label: l10n.contact,
                      icon: Icons.mail_outline_rounded,
                      isSelected:
                          widget.selectedPanel == DetailPanelType.contact,
                      onTap: () =>
                          widget.onChipSelected(DetailPanelType.contact),
                    ),
                  ),
                ],
              ),
            ),
            if (profile.skills.isNotEmpty) ...[
              const SizedBox(height: 32),
              _staggerItem(
                4,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(l10n.skills),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: profile.skills
                          .map(
                            (skill) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: const BoxDecoration(
                                color: ColorName.surfaceLight,
                              ),
                              child: Text(
                                skill.name,
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
            if (profile.languages.isNotEmpty) ...[
              const SizedBox(height: 24),
              _staggerItem(
                5,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(l10n.languages),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
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
            ],
          ],
        ),
      ),
    );
  }
}
