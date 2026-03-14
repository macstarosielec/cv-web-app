import 'dart:async';

import 'package:admin_content/presentation/projects/cubit/admin_projects_cubit.dart';
import 'package:admin_content/presentation/widgets/confirm_delete_dialog.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';

class AdminProjectCard extends StatelessWidget {
  const AdminProjectCard({
    required this.project,
    required this.onEdit,
    super.key,
  });

  final Project project;
  final ValueChanged<Project> onEdit;

  String _subtitle(AppLocalizations l10n) => project.when(
        commercial: (id, name, company, role, description, techStack,
                responsibilities, sortOrder) =>
            '$company · $role',
        personal: (id, name, description, techStack, githubUrl, sortOrder) =>
            l10n.personalProject,
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
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<AdminProjectsCubit>();
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ColorName.surfaceLight,
        border: Border.all(color: ColorName.surfaceBorder),
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
                  _subtitle(l10n),
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
            tooltip: l10n.edit,
            onPressed: () => onEdit(project),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: ColorName.textMuted),
            tooltip: l10n.delete,
            onPressed: () async {
              final confirmed = await ConfirmDeleteDialog.show(
                context,
                title: l10n.deleteProject,
                content: l10n.confirmDeleteItem(_name),
              );
              if (confirmed) unawaited(cubit.deleteProject(_id));
            },
          ),
        ],
      ),
    );
  }
}
