import 'package:flutter/material.dart';

class InterestsSection extends StatelessWidget {
  const InterestsSection({required this.interests, super.key});

  final List<String> interests;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interests',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: interests
              .map((interest) => Chip(label: Text(interest)))
              .toList(),
        ),
      ],
    );
  }
}
