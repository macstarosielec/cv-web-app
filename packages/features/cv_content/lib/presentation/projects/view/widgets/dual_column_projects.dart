import 'package:cv_content/presentation/projects/view/widgets/projects_column.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/widgets/accent_divider.dart';

class DualColumnProjects extends StatelessWidget {
  const DualColumnProjects({
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            children: [
              ProjectsColumn(
                key: commercialKey,
                title: l10n.commercialProjects,
                projects: commercial,
              ),
            ],
          ),
        ),
        const AccentDivider(vertical: true),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            children: [
              ProjectsColumn(
                key: const ValueKey('personal_dual'),
                title: l10n.personalProjects,
                projects: personal,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
