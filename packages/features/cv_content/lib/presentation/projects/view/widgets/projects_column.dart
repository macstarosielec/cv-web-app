import 'dart:async';

import 'package:cv_content/presentation/projects/view/widgets/project_tile.dart';
import 'package:cv_content/presentation/widgets/section_title.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class ProjectsColumn extends StatefulWidget {
  const ProjectsColumn({
    required this.title,
    required this.projects,
    super.key,
  });

  final String title;
  final List<Project> projects;

  @override
  State<ProjectsColumn> createState() => _ProjectsColumnState();
}

class _ProjectsColumnState extends State<ProjectsColumn>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  int get _itemCount => 1 + widget.projects.length;

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
    var animIndex = 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _animatedItem(animIndex++, SectionTitle(widget.title)),
        ...widget.projects.map(
          (project) =>
              _animatedItem(animIndex++, ProjectTile(project: project)),
        ),
      ],
    );
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
}
