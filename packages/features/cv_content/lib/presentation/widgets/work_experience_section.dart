import 'package:cv_content/presentation/widgets/work_experience_card.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class WorkExperienceSection extends StatelessWidget {
  const WorkExperienceSection({required this.experiences, super.key});

  final List<WorkExperience> experiences;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Work Experience',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...experiences.map(
          (exp) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: WorkExperienceCard(experience: exp),
          ),
        ),
      ],
    );
  }
}
