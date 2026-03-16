import 'dart:async';

import 'package:cv_content/presentation/experience/view/widgets/experience_tile.dart';
import 'package:cv_content/presentation/widgets/section_title.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';

class ExperienceList extends StatefulWidget {
  const ExperienceList({
    required this.experiences,
    required this.skills,
    super.key,
  });

  final List<WorkExperience> experiences;
  final List<Skill> skills;

  @override
  State<ExperienceList> createState() => _ExperienceListState();
}

class _ExperienceListState extends State<ExperienceList>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  int get _itemCount =>
      (widget.skills.isNotEmpty ? 1 : 0) + widget.experiences.length;

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

  Widget _animatedItem(int index, Widget child) => AnimatedBuilder(
        animation: _animations[index],
        builder: (context, child) => Transform.translate(
          offset: Offset(0, 20 * (1 - _animations[index].value)),
          child: Opacity(
            opacity: _animations[index].value,
            child: child,
          ),
        ),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final hasSkills = widget.skills.isNotEmpty;
    var animIndex = 0;

    return ListView(
      padding: const EdgeInsets.all(32),
      children: [
        if (hasSkills) ...[
          _animatedItem(
            animIndex++,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(l10n.skills),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.skills
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
          const SizedBox(height: 32),
        ],
        SectionTitle(l10n.experience),
        const SizedBox(height: 24),
        ...List.generate(widget.experiences.length, (index) {
          return _animatedItem(
            animIndex + index,
            ExperienceTile(
              experience: widget.experiences[index],
            ),
          );
        }),
      ],
    );
  }
}
