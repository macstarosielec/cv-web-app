import 'dart:async';

import 'package:cv_content/presentation/home/view/widgets/experience_tile.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:cv_content/presentation/home/view/widgets/section_title.dart';
import 'package:shared/gen/colors.gen.dart';

class ExperienceList extends StatefulWidget {
  const ExperienceList({required this.experiences, super.key});

  final List<WorkExperience> experiences;

  @override
  State<ExperienceList> createState() => _ExperienceListState();
}

class _ExperienceListState extends State<ExperienceList>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.experiences.length,
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
    return ListView(
      padding: const EdgeInsets.all(32),
      children: [
        const SectionTitle('Experience'),
        const SizedBox(height: 24),
        ...List.generate(widget.experiences.length, (index) {
          return AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) => Transform.translate(
              offset: Offset(0, 20 * (1 - _animations[index].value)),
              child: Opacity(
                opacity: _animations[index].value,
                child: child,
              ),
            ),
            child: ExperienceTile(
              experience: widget.experiences[index],
            ),
          );
        }),
      ],
    );
  }
}
