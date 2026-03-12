import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.name,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${project.company} \u2022 ${project.role}',
              style: textTheme.titleSmall,
            ),
            if (project.description != null) ...[
              const SizedBox(height: 8),
              Text(project.description!, style: textTheme.bodyMedium),
            ],
            if (project.techStack.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: project.techStack
                    .map(
                      (tech) => Chip(
                        label: Text(tech),
                        visualDensity: VisualDensity.compact,
                      ),
                    )
                    .toList(),
              ),
            ],
            if (project.responsibilities.isNotEmpty) ...[
              const SizedBox(height: 8),
              ...project.responsibilities.map(
                (r) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('  \u2022  '),
                      Expanded(
                        child: Text(r, style: textTheme.bodyMedium),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
