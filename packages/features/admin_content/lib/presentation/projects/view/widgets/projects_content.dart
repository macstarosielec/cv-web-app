import 'dart:async';

import 'package:admin_content/presentation/projects/cubit/admin_projects_cubit.dart';
import 'package:admin_content/presentation/projects/view/widgets/project_form.dart';
import 'package:admin_content/presentation/projects/view/widgets/reorderable_project_list.dart';
import 'package:admin_content/presentation/widgets/section_header.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/l10n/l10n.dart';

class ProjectsContent extends StatelessWidget {
  const ProjectsContent({
    required this.projects,
    required this.editingProject,
    required this.onReorder,
    required this.onEdit,
    required this.onSave,
    required this.onDiscard,
    super.key,
  });

  final List<Project> projects;
  final Project? editingProject;
  final void Function({
    required List<Project> sectionProjects,
    required List<Project> allProjects,
    required int oldIndex,
    required int newIndex,
  }) onReorder;
  final ValueChanged<Project> onEdit;
  final ValueChanged<Project> onSave;
  final VoidCallback onDiscard;

  @override
  Widget build(BuildContext context) {
    final commercial =
        projects.whereType<CommercialProject>().toList();
    final personal =
        projects.whereType<PersonalProject>().toList();
    final l10n = AppLocalizations.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ProjectForm(
            project: editingProject,
            onSave: onSave,
            onDiscard: onDiscard,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            children: [
              if (commercial.isNotEmpty) ...[
                SectionHeader(title: l10n.commercialProjects),
                ReorderableProjectList(
                  projects: commercial,
                  allProjects: projects,
                  onReorder: onReorder,
                  onEdit: onEdit,
                  onDelete: (id) => unawaited(
                    context
                        .read<AdminProjectsCubit>()
                        .deleteProject(id),
                  ),
                ),
              ],
              if (commercial.isNotEmpty && personal.isNotEmpty)
                const SizedBox(height: 24),
              if (personal.isNotEmpty) ...[
                SectionHeader(title: l10n.personalProjects),
                ReorderableProjectList(
                  projects: personal,
                  allProjects: projects,
                  onReorder: onReorder,
                  onEdit: onEdit,
                  onDelete: (id) => unawaited(
                    context
                        .read<AdminProjectsCubit>()
                        .deleteProject(id),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
