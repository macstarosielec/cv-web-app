import 'package:cv_content/presentation/projects/view/widgets/projects_column.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/l10n/l10n.dart';

class ProjectsList extends StatefulWidget {
  const ProjectsList({required this.projects, super.key});

  final List<Project> projects;

  @override
  State<ProjectsList> createState() => _ProjectsListState();
}

class _ProjectsListState extends State<ProjectsList> {
  final GlobalKey _commercialKey = GlobalKey();

  static const _dualColumnBreakpoint = 600.0;

  @override
  Widget build(BuildContext context) {
    final commercial =
        widget.projects.whereType<CommercialProject>().toList();
    final personal =
        widget.projects.whereType<PersonalProject>().toList();
    final l10n = AppLocalizations.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final useDualColumn =
            constraints.maxWidth >= _dualColumnBreakpoint &&
                commercial.isNotEmpty &&
                personal.isNotEmpty;

        if (useDualColumn) {
          return _buildDualColumn(l10n, commercial, personal);
        }
        return _buildSingleColumn(l10n, commercial, personal);
      },
    );
  }

  Widget _buildSingleColumn(
    AppLocalizations l10n,
    List<CommercialProject> commercial,
    List<PersonalProject> personal,
  ) =>
      ListView(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        children: [
          if (commercial.isNotEmpty)
            ProjectsColumn(
              key: _commercialKey,
              title: l10n.commercialProjects,
              projects: commercial,
            ),
          if (personal.isNotEmpty)
            Padding(
              padding:
                  EdgeInsets.only(top: commercial.isNotEmpty ? 32 : 0),
              child: ProjectsColumn(
                key: const ValueKey('personal_single'),
                title: l10n.personalProjects,
                projects: personal,
              ),
            ),
        ],
      );

  Widget _buildDualColumn(
    AppLocalizations l10n,
    List<CommercialProject> commercial,
    List<PersonalProject> personal,
  ) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              children: [
                ProjectsColumn(
                  key: _commercialKey,
                  title: l10n.commercialProjects,
                  projects: commercial,
                ),
              ],
            ),
          ),
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
