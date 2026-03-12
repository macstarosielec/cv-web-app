import 'package:cv_content/presentation/cubit/profile/profile_cubit.dart';
import 'package:cv_content/presentation/cubit/profile/profile_state.dart';
import 'package:cv_content/presentation/cubit/projects/projects_cubit.dart';
import 'package:cv_content/presentation/cubit/projects/projects_state.dart';
import 'package:cv_content/presentation/cubit/work_experience/work_experience_cubit.dart';
import 'package:cv_content/presentation/cubit/work_experience/work_experience_state.dart';
import 'package:cv_content/presentation/widgets/interests_section.dart';
import 'package:cv_content/presentation/widgets/languages_section.dart';
import 'package:cv_content/presentation/widgets/profile_header.dart';
import 'package:cv_content/presentation/widgets/projects_section.dart';
import 'package:cv_content/presentation/widgets/skills_section.dart';
import 'package:cv_content/presentation/widgets/work_experience_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 32,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) => state.when(
                    initial: SizedBox.shrink,
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    loaded: (profile) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileHeader(profile: profile),
                        if (profile.skills.isNotEmpty) ...[
                          const SizedBox(height: 32),
                          SkillsSection(skills: profile.skills),
                        ],
                        if (profile.languages.isNotEmpty) ...[
                          const SizedBox(height: 32),
                          LanguagesSection(
                            languages: profile.languages,
                          ),
                        ],
                        if (profile.interests.isNotEmpty) ...[
                          const SizedBox(height: 32),
                          InterestsSection(
                            interests: profile.interests,
                          ),
                        ],
                      ],
                    ),
                    error: (message) => Text('Error: $message'),
                  ),
                ),
                const SizedBox(height: 32),
                BlocBuilder<WorkExperienceCubit, WorkExperienceState>(
                  builder: (context, state) => state.when(
                    initial: SizedBox.shrink,
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    loaded: (experiences) =>
                        WorkExperienceSection(experiences: experiences),
                    error: (message) => Text('Error: $message'),
                  ),
                ),
                const SizedBox(height: 32),
                BlocBuilder<ProjectsCubit, ProjectsState>(
                  builder: (context, state) => state.when(
                    initial: SizedBox.shrink,
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    loaded: (projects) =>
                        ProjectsSection(projects: projects),
                    error: (message) => Text('Error: $message'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
