import 'package:admin_content/presentation/projects/view/widgets/admin_project_card.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class ReorderableProjectList extends StatelessWidget {
  const ReorderableProjectList({
    required this.projects,
    required this.allProjects,
    required this.onReorder,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final List<Project> projects;
  final List<Project> allProjects;
  final void Function({
    required List<Project> sectionProjects,
    required List<Project> allProjects,
    required int oldIndex,
    required int newIndex,
  }) onReorder;
  final ValueChanged<Project> onEdit;
  final ValueChanged<String> onDelete;

  @override
  Widget build(BuildContext context) => ReorderableListView.builder(
        shrinkWrap: true,
        buildDefaultDragHandles: false,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: projects.length,
        onReorder: (oldIndex, newIndex) => onReorder(
          sectionProjects: projects,
          allProjects: allProjects,
          oldIndex: oldIndex,
          newIndex: newIndex,
        ),
        itemBuilder: (context, index) => AdminProjectCard(
          key: ValueKey(projects[index].id),
          project: projects[index],
          index: index,
          onEdit: onEdit,
          onDelete: onDelete,
        ),
      );
}
