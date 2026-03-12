import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class LanguagesSection extends StatelessWidget {
  const LanguagesSection({required this.languages, super.key});

  final List<Language> languages;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Languages',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: languages
              .map(
                (lang) => Chip(
                  label: Text(
                    '${lang.name} (${lang.proficiency.label})',
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
