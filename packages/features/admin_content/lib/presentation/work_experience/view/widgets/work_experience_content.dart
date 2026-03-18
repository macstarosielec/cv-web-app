import 'package:admin_content/presentation/profile/cubit/admin_profile_cubit.dart';
import 'package:admin_content/presentation/profile/cubit/admin_profile_state.dart';
import 'package:admin_content/presentation/profile/view/widgets/skills_editor.dart';
import 'package:admin_content/presentation/widgets/form_section.dart';
import 'package:admin_content/presentation/work_experience/view/widgets/admin_experience_card.dart';
import 'package:admin_content/presentation/work_experience/view/widgets/experience_form.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/l10n/l10n.dart';

class WorkExperienceContent extends StatelessWidget {
  const WorkExperienceContent({
    required this.experiences,
    required this.editingExperience,
    required this.listItemAnimation,
    required this.onEdit,
    required this.onSave,
    required this.onDiscard,
    required this.onSkillsChanged,
    super.key,
  });

  final List<WorkExperience> experiences;
  final WorkExperience? editingExperience;
  final Animation<double> Function(int index, int total) listItemAnimation;
  final ValueChanged<WorkExperience> onEdit;
  final ValueChanged<WorkExperience> onSave;
  final VoidCallback onDiscard;
  final ValueChanged<List<Skill>> onSkillsChanged;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          BlocBuilder<AdminProfileCubit, AdminProfileState>(
            builder: (context, state) {
              final skills = state.whenOrNull(
                loaded: (p) => p.skills,
                saving: (p) => p.skills,
                saved: (p) => p.skills,
              );
              if (skills == null) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: FormSection(
                  title: AppLocalizations.of(context).skills,
                  child: SkillsEditor(
                    skills: skills,
                    onChanged: onSkillsChanged,
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ExperienceForm(
                    workExperience: editingExperience,
                    onSave: onSave,
                    onDiscard: onDiscard,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.all(AppDimensions.paddingMedium),
                    itemCount: experiences.length,
                    itemBuilder: (context, index) {
                      final animation =
                          listItemAnimation(index, experiences.length);
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: animation.drive(
                            Tween(
                              begin: const Offset(0, 0.1),
                              end: Offset.zero,
                            ),
                          ),
                          child: AdminExperienceCard(
                            workExperience: experiences[index],
                            onEdit: onEdit,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
