import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class WorkExperienceCard extends StatelessWidget {
  const WorkExperienceCard({required this.experience, super.key});

  final WorkExperience experience;

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String _formatDate(DateTime date) =>
      '${_months[date.month - 1]} ${date.year}';

  String get _dateRange {
    final start = _formatDate(experience.startDate);
    final end = experience.isCurrent
        ? 'Present'
        : _formatDate(experience.endDate!);
    return '$start - $end';
  }

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
              experience.title,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(experience.company, style: textTheme.titleSmall),
            const SizedBox(height: 2),
            Text(
              _dateRange,
              style: textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            if (experience.responsibilities.isNotEmpty) ...[
              const SizedBox(height: 8),
              ...experience.responsibilities.map(
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
