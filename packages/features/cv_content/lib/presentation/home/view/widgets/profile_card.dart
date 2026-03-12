import 'package:cv_content/presentation/home/view/home_view.dart';
import 'package:cv_content/presentation/home/view/widgets/gradient_card.dart';
import 'package:cv_content/presentation/home/view/widgets/navigation_chip.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    required this.profile,
    required this.selectedPanel,
    required this.onChipSelected,
    super.key,
  });

  final Profile profile;
  final DetailPanelType? selectedPanel;
  final ValueChanged<DetailPanelType> onChipSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GradientCard(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              profile.fullName,
              style: textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: ColorName.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              profile.title,
              style: textTheme.titleLarge?.copyWith(
                color: ColorName.accent,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              profile.about,
              style: textTheme.bodyLarge?.copyWith(
                color: ColorName.textSecondary,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                NavigationChip(
                  label: 'Projects',
                  icon: Icons.code_rounded,
                  isSelected:
                      selectedPanel == DetailPanelType.projects,
                  onTap: () =>
                      onChipSelected(DetailPanelType.projects),
                ),
                NavigationChip(
                  label: 'Experience',
                  icon: Icons.work_outline_rounded,
                  isSelected:
                      selectedPanel == DetailPanelType.experience,
                  onTap: () =>
                      onChipSelected(DetailPanelType.experience),
                ),
                NavigationChip(
                  label: 'Contact',
                  icon: Icons.mail_outline_rounded,
                  isSelected:
                      selectedPanel == DetailPanelType.contact,
                  onTap: () =>
                      onChipSelected(DetailPanelType.contact),
                ),
              ],
            ),
            const SizedBox(height: 32),
            if (profile.skills.isNotEmpty) ...[
              Text(
                'Skills',
                style: textTheme.titleMedium?.copyWith(
                  color: ColorName.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: profile.skills
                    .map(
                      (skill) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: ColorName.surfaceLight,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: ColorName.surfaceBorder,
                          ),
                        ),
                        child: Text(
                          skill.name,
                          style: textTheme.bodySmall?.copyWith(
                            color: ColorName.textSecondary,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
            if (profile.languages.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(
                'Languages',
                style: textTheme.titleMedium?.copyWith(
                  color: ColorName.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: profile.languages
                    .map(
                      (lang) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: ColorName.surfaceLight,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: ColorName.surfaceBorder,
                          ),
                        ),
                        child: Text(
                          '${lang.name} (${lang.proficiency.label})',
                          style: textTheme.bodySmall?.copyWith(
                            color: ColorName.textSecondary,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
