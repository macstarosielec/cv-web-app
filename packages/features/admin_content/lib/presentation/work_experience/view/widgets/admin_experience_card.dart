import 'dart:async';

import 'package:admin_content/presentation/widgets/confirm_delete_dialog.dart';
import 'package:admin_content/presentation/work_experience/cubit/admin_work_experience_cubit.dart';
import 'package:admin_content/presentation/work_experience/view/widgets/experience_editor_dialog.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/gen/colors.gen.dart';

class AdminExperienceCard extends StatelessWidget {
  const AdminExperienceCard({required this.workExperience, super.key});

  final WorkExperience workExperience;

  String _formatDate(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}';

  String get _dateRange {
    final start = _formatDate(workExperience.startDate);
    final end = workExperience.endDate != null
        ? _formatDate(workExperience.endDate!)
        : 'Present';
    return '$start – $end';
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdminWorkExperienceCubit>();
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
                  workExperience.title,
                  style: const TextStyle(
                    color: ColorName.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${workExperience.company} · $_dateRange',
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
              ExperienceEditorDialog.show(
                context,
                cubit: cubit,
                workExperience: workExperience,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: ColorName.textMuted),
            tooltip: 'Delete',
            onPressed: () async {
              final confirmed = await ConfirmDeleteDialog.show(
                context,
                title: 'Delete Experience',
                content:
                    'Are you sure you want to delete '
                    '"${workExperience.title}"?',
              );
              if (confirmed) unawaited(cubit.deleteWorkExperience(workExperience.id));
            },
          ),
        ],
      ),
    );
  }
}
