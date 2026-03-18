import 'dart:async';

import 'package:admin_content/presentation/projects/cubit/admin_projects_cubit.dart';
import 'package:admin_content/presentation/projects/cubit/admin_projects_state.dart';
import 'package:admin_content/presentation/projects/view/widgets/projects_content.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/widgets/dot_loader.dart';
import 'package:shared/widgets/section_error.dart';

class ProjectsListView extends StatefulWidget {
  const ProjectsListView({super.key});

  @override
  State<ProjectsListView> createState() => _ProjectsListViewState();
}

class _ProjectsListViewState extends State<ProjectsListView> {
  Project? _editingProject;

  void _onEdit(Project project) {
    setState(() => _editingProject = project);
  }

  void _onDiscard() {
    setState(() => _editingProject = null);
  }

  void _onSave(Project project) {
    final cubit = context.read<AdminProjectsCubit>();
    if (_editingProject != null) {
      unawaited(cubit.updateProject(project));
    } else {
      unawaited(cubit.addProject(project));
    }
    setState(() => _editingProject = null);
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AdminProjectsCubit, AdminProjectsState>(
        builder: (context, state) => state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: DotLoader()),
          loaded: _buildContent,
          saving: _buildContent,
          error: (exception) => SectionError(
            exception: exception,
            onRetry: () =>
                context.read<AdminProjectsCubit>().loadProjects(),
          ),
        ),
      );

  void _onReorder({
    required List<Project> sectionProjects,
    required List<Project> allProjects,
    required int oldIndex,
    required int newIndex,
  }) {
    final adjustedNewIndex =
        newIndex > oldIndex ? newIndex - 1 : newIndex;
    final reordered = List<Project>.from(sectionProjects)
      ..removeAt(oldIndex)
      ..insert(adjustedNewIndex, sectionProjects[oldIndex]);
    final updated = reordered
        .asMap()
        .entries
        .map(
          (e) => e.value.map(
            commercial: (p) => p.copyWith(sortOrder: e.key),
            personal: (p) => p.copyWith(sortOrder: e.key),
          ),
        )
        .toList();
    final otherProjects = allProjects
        .where((p) => !sectionProjects.contains(p))
        .toList();
    unawaited(
      context
          .read<AdminProjectsCubit>()
          .reorderProjects([...updated, ...otherProjects]),
    );
  }

  Widget _buildContent(List<Project> projects) => ProjectsContent(
        projects: projects,
        editingProject: _editingProject,
        onReorder: _onReorder,
        onEdit: _onEdit,
        onSave: _onSave,
        onDiscard: _onDiscard,
      );
}
