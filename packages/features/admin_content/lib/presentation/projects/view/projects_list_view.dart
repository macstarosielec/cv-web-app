import 'dart:async';

import 'package:admin_content/presentation/projects/cubit/admin_projects_cubit.dart';
import 'package:admin_content/presentation/projects/cubit/admin_projects_state.dart';
import 'package:admin_content/presentation/projects/view/widgets/admin_project_card.dart';
import 'package:admin_content/presentation/projects/view/widgets/project_form.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/widgets/dot_loader.dart';

class ProjectsListView extends StatefulWidget {
  const ProjectsListView({super.key});

  @override
  State<ProjectsListView> createState() => _ProjectsListViewState();
}

class _ProjectsListViewState extends State<ProjectsListView>
    with SingleTickerProviderStateMixin {
  Project? _editingProject;
  int _formKey = 0;
  late final AnimationController _listStagger;

  @override
  void initState() {
    super.initState();
    _listStagger = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _listStagger.dispose();
    super.dispose();
  }

  void _onEdit(Project project) {
    setState(() {
      _editingProject = project;
      _formKey++;
    });
  }

  void _onDiscard() {
    setState(() {
      _editingProject = null;
      _formKey++;
    });
  }

  void _onSave(Project project) {
    final cubit = context.read<AdminProjectsCubit>();
    if (_editingProject != null) {
      unawaited(cubit.updateProject(project));
    } else {
      unawaited(cubit.addProject(project));
    }
    setState(() {
      _editingProject = null;
      _formKey++;
    });
  }

  Animation<double> _listItemAnimation(int index, int total) {
    if (total == 0) return const AlwaysStoppedAnimation(1);
    final start = (index / (total + 1)).clamp(0.0, 1.0);
    final end = ((index + 2) / (total + 1)).clamp(0.0, 1.0);
    return CurvedAnimation(
      parent: _listStagger,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AdminProjectsCubit, AdminProjectsState>(
        builder: (context, state) => state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: DotLoader()),
          loaded: _buildContent,
          saving: _buildContent,
          error: (message) => Center(
            child: Text(
              message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      );

  Widget _buildContent(List<Project> projects) {
    if (!_listStagger.isCompleted && !_listStagger.isAnimating) {
      unawaited(_listStagger.forward());
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ProjectForm(
            key: ValueKey('form_$_formKey'),
            project: _editingProject,
            onSave: _onSave,
            onDiscard: _onDiscard,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final animation =
                  _listItemAnimation(index, projects.length);
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: animation.drive(
                    Tween(
                      begin: const Offset(0, 0.1),
                      end: Offset.zero,
                    ),
                  ),
                  child: AdminProjectCard(
                    project: projects[index],
                    onEdit: _onEdit,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
