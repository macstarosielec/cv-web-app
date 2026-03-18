import 'dart:async';

import 'package:admin_content/presentation/widgets/confirm_delete_dialog.dart';
import 'package:admin_content/presentation/work_experience/cubit/admin_work_experience_cubit.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';

class AdminExperienceCard extends StatelessWidget {
  const AdminExperienceCard({
    required this.workExperience,
    required this.onEdit,
    super.key,
  });

  final WorkExperience workExperience;
  final ValueChanged<WorkExperience> onEdit;

  String _formatDate(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}';

  String _dateRange(AppLocalizations l10n) {
    final start = _formatDate(workExperience.startDate);
    final end = workExperience.endDate != null
        ? _formatDate(workExperience.endDate!)
        : l10n.present;
    return '$start – $end';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<AdminWorkExperienceCubit>();
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
                  workExperience.title,
                  style: const TextStyle(
                    color: ColorName.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${workExperience.company} · ${_dateRange(l10n)}',
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
            onPressed: () => onEdit(workExperience),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: ColorName.textMuted),
            tooltip: l10n.delete,
            onPressed: () async {
              final confirmed = await ConfirmDeleteDialog.show(
                context,
                title: l10n.deleteExperience,
                content: l10n.confirmDeleteItem(workExperience.title),
              );
              if (confirmed) {
                unawaited(cubit.deleteWorkExperience(workExperience.id));
              }
            },
          ),
        ],
      ),
    );
  }
}
