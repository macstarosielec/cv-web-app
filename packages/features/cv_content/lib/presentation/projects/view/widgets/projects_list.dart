import 'dart:async';

import 'package:cv_content/presentation/projects/view/widgets/project_tile.dart';
import 'package:cv_content/presentation/widgets/section_title.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/l10n/l10n.dart';

class ProjectsList extends StatefulWidget {
  const ProjectsList({required this.projects, super.key});

  final List<Project> projects;

  @override
  State<ProjectsList> createState() => _ProjectsListState();
}

class _ProjectsListState extends State<ProjectsList>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _totalItemCount,
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

  int get _totalItemCount {
    final commercial =
        widget.projects.whereType<CommercialProject>().toList();
    final personal =
        widget.projects.whereType<PersonalProject>().toList();
    var count = 0;
    if (commercial.isNotEmpty) count += 1 + commercial.length;
    if (personal.isNotEmpty) count += 1 + personal.length;
    return count;
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
    final commercial =
        widget.projects.whereType<CommercialProject>().toList();
    final personal =
        widget.projects.whereType<PersonalProject>().toList();

    final items = <Widget>[];
    var animIndex = 0;

    if (commercial.isNotEmpty) {
      items.add(
        _animatedItem(
          animIndex++,
          SectionTitle(AppLocalizations.of(context).commercialProjects),
        ),
      );
      for (final project in commercial) {
        items.add(
          _animatedItem(animIndex++, ProjectTile(project: project)),
        );
      }
    }

    if (personal.isNotEmpty) {
      items.add(
        _animatedItem(
          animIndex++,
          Padding(
            padding: EdgeInsets.only(top: commercial.isNotEmpty ? 32 : 0),
            child: SectionTitle(
              AppLocalizations.of(context).personalProjects,
            ),
          ),
        ),
      );
      for (final project in personal) {
        items.add(
          _animatedItem(animIndex++, ProjectTile(project: project)),
        );
      }
    }

    return ListView(
      padding: const EdgeInsets.all(32),
      children: items,
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
