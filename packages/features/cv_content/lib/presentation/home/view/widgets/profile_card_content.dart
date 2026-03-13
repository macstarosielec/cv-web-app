import 'dart:async';

import 'package:cv_content/presentation/home/view/widgets/section_title.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/theme/theme.dart';

class ProfileCardContent extends StatefulWidget {
  const ProfileCardContent({
    required this.profile,
    this.animate = false,
    super.key,
  });

  final Profile profile;
  final bool animate;

  @override
  State<ProfileCardContent> createState() => _ProfileCardContentState();
}

class _ProfileCardContentState extends State<ProfileCardContent>
    with TickerProviderStateMixin {
  static const _itemCount = 5;
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _StaggerItem(
          animation: _animations[0],
          child: Text(
            profile.fullName,
            style: textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: ColorName.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        _StaggerItem(
          animation: _animations[1],
          child: Text(
            profile.title,
            style: AppTheme.accentStyle(fontSize: 24).copyWith(
              color: ColorName.accent,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 24),
        _StaggerItem(
          animation: _animations[2],
          child: Text(
            profile.about,
            style: textTheme.bodyLarge?.copyWith(
              color: ColorName.textSecondary,
              height: 1.6,
            ),
          ),
        ),
        if (profile.skills.isNotEmpty) ...[
          const SizedBox(height: 32),
          _StaggerItem(
            animation: _animations[3],
            child: Column(
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
          _StaggerItem(
            animation: _animations[4],
            child: Column(
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
    );
  }
}

class _StaggerItem extends StatelessWidget {
  const _StaggerItem({
    required this.animation,
    required this.child,
  });

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: animation,
        builder: (context, c) => Transform.translate(
          offset: Offset(0, 16 * (1 - animation.value)),
          child: Opacity(
            opacity: animation.value,
            child: c,
          ),
        ),
        child: child,
      );
}
