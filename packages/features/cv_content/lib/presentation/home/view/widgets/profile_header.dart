import 'package:cv_content/presentation/home/view/widgets/contact_chip.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.profile, super.key});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          profile.fullName,
          style: textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          profile.title,
          style: textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(profile.about, style: textTheme.bodyLarge),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            ContactChip(
              icon: Icons.email_outlined,
              label: profile.email,
            ),
            if (profile.phoneNumber != null)
              ContactChip(
                icon: Icons.phone_outlined,
                label: profile.phoneNumber!,
              ),
            if (profile.linkedInUrl != null)
              const ContactChip(
                icon: Icons.link,
                label: 'LinkedIn',
              ),
            if (profile.githubUrl != null)
              const ContactChip(
                icon: Icons.code,
                label: 'GitHub',
              ),
          ],
        ),
      ],
    );
  }
}
