import 'package:cv_content/presentation/contact/view/widgets/contact_panel.dart';
import 'package:cv_content/presentation/experience/cubit/work_experience_cubit.dart';
import 'package:cv_content/presentation/experience/cubit/work_experience_state.dart';
import 'package:cv_content/presentation/experience/view/widgets/experience_list.dart';
import 'package:cv_content/presentation/models/detail_panel_type.dart';
import 'package:cv_content/presentation/projects/cubit/projects_cubit.dart';
import 'package:cv_content/presentation/projects/cubit/projects_state.dart';
import 'package:cv_content/presentation/projects/view/widgets/projects_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/widgets/dot_loader.dart';
import 'package:shared/widgets/section_error.dart';

class DetailPanelContent extends StatelessWidget {
  const DetailPanelContent({
    required this.type,
    super.key,
  });

  final DetailPanelType type;

  @override
  Widget build(BuildContext context) => switch (type) {
        DetailPanelType.projects =>
          BlocBuilder<ProjectsCubit, ProjectsState>(
            builder: (context, state) => state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(
                child: DotLoader(),
              ),
              loaded: (projects) => ProjectsList(
                key: const ValueKey('projects'),
                projects: projects,
              ),
              error: (exception) => SectionError(
                exception: exception,
                onRetry: () =>
                    context.read<ProjectsCubit>().loadProjects(),
              ),
            ),
          ),
        DetailPanelType.experience =>
          BlocBuilder<WorkExperienceCubit, WorkExperienceState>(
            builder: (context, state) => state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(
                child: DotLoader(),
              ),
              loaded: (experiences) => ExperienceList(
                key: const ValueKey('experience'),
                experiences: experiences,
              ),
              error: (exception) => SectionError(
                exception: exception,
                onRetry: () => context
                    .read<WorkExperienceCubit>()
                    .loadWorkExperiences(),
              ),
            ),
          ),
        DetailPanelType.contact => const ContactPanel(
            key: ValueKey('contact'),
          ),
      };
}
