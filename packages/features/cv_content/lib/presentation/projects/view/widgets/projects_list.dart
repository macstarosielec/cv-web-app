import 'package:cv_content/presentation/projects/view/widgets/dual_column_projects.dart';
import 'package:cv_content/presentation/projects/view/widgets/single_column_projects.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

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

    return LayoutBuilder(
      builder: (context, constraints) {
        final useDualColumn =
            constraints.maxWidth >= _dualColumnBreakpoint &&
                commercial.isNotEmpty &&
                personal.isNotEmpty;

        if (useDualColumn) {
          return DualColumnProjects(
            commercial: commercial,
            personal: personal,
            commercialKey: _commercialKey,
          );
        }
        return SingleColumnProjects(
          commercial: commercial,
          personal: personal,
          commercialKey: _commercialKey,
        );
      },
    );
  }
}
