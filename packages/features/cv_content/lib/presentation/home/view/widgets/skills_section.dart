import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({required this.skills, super.key});

  final List<Skill> skills;

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<Skill>>{};
    for (final skill in skills) {
      final category = skill.category ?? 'Other';
      grouped.putIfAbsent(category, () => []).add(skill);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        ...grouped.entries.map(
          (entry) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: entry.value
                      .map(
                        (skill) => Chip(label: Text(skill.name)),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
