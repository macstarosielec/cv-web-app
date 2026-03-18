import 'package:cv_content/presentation/projects/view/widgets/projects_column.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/widgets/accent_divider.dart';

class SingleColumnProjects extends StatelessWidget {
  const SingleColumnProjects({
    required this.commercial,
    required this.personal,
    required this.commercialKey,
    super.key,
  });

  final List<CommercialProject> commercial;
  final List<PersonalProject> personal;
  final Key commercialKey;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      children: [
        if (commercial.isNotEmpty)
          ProjectsColumn(
            key: commercialKey,
            title: l10n.commercialProjects,
            projects: commercial,
          ),
        if (commercial.isNotEmpty && personal.isNotEmpty) ...[
          const SizedBox(height: AppDimensions.spacingMedium),
          const AccentDivider(),
          const SizedBox(height: AppDimensions.spacingLarge),
        ],
        if (personal.isNotEmpty)
          ProjectsColumn(
            key: const ValueKey('personal_single'),
            title: l10n.personalProjects,
            projects: personal,
          ),
      ],
    );
  }
}
