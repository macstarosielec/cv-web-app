import 'dart:async';

import 'package:admin_content/presentation/projects/cubit/admin_projects_cubit.dart';
import 'package:admin_content/presentation/projects/view/widgets/project_editor_dialog.dart';
import 'package:admin_content/presentation/widgets/confirm_delete_dialog.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/gen/colors.gen.dart';

class AdminProjectCard extends StatelessWidget {
  const AdminProjectCard({required this.project, super.key});

  final Project project;

  String get _subtitle => project.when(
        commercial: (id, name, company, role, description, techStack,
                responsibilities, sortOrder) =>
            '$company · $role',
        personal: (id, name, description, techStack, githubUrl, sortOrder) =>
            'Personal project',
      );

  String get _id => project.when(
        commercial: (id, name, company, role, description, techStack,
                responsibilities, sortOrder) =>
            id,
        personal: (id, name, description, techStack, githubUrl, sortOrder) =>
            id,
      );

  String get _name => project.when(
        commercial: (id, name, company, role, description, techStack,
                responsibilities, sortOrder) =>
            name,
        personal: (id, name, description, techStack, githubUrl, sortOrder) =>
            name,
      );

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdminProjectsCubit>();
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ColorName.surfaceLight,
        border: Border.all(color: ColorName.surfaceBorder),
        borderRadius: BorderRadius.zero,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _name,
                  style: const TextStyle(
                    color: ColorName.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _subtitle,
                  style: const TextStyle(
                    color: ColorName.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: ColorName.textMuted),
            tooltip: 'Edit',
            onPressed: () => unawaited(
              ProjectEditorDialog.show(
                context,
                cubit: cubit,
                project: project,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: ColorName.textMuted),
            tooltip: 'Delete',
            onPressed: () async {
              final confirmed = await ConfirmDeleteDialog.show(
                context,
                title: 'Delete Project',
                content: 'Are you sure you want to delete "$_name"?',
              );
              if (confirmed) unawaited(cubit.deleteProject(_id));
            },
          ),
        ],
      ),
    );
  }
}
