import 'package:cv_content/presentation/widgets/project_card.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({required this.projects, super.key});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Projects',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...projects.map(
          (project) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ProjectCard(project: project),
          ),
        ),
      ],
    );
  }
}
