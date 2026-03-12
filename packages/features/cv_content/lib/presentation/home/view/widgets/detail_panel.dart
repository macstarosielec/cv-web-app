import 'package:cv_content/presentation/home/cubit/projects_cubit.dart';
import 'package:cv_content/presentation/home/cubit/projects_state.dart';
import 'package:cv_content/presentation/home/cubit/work_experience_cubit.dart';
import 'package:cv_content/presentation/home/cubit/work_experience_state.dart';
import 'package:cv_content/presentation/home/view/home_view.dart';
import 'package:cv_content/presentation/home/view/widgets/contact_panel.dart';
import 'package:cv_content/presentation/home/view/widgets/experience_list.dart';
import 'package:cv_content/presentation/home/view/widgets/gradient_card.dart';
import 'package:cv_content/presentation/home/view/widgets/projects_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DetailPanel extends StatelessWidget {
  const DetailPanel({
    required this.type,
    required this.animationProgress,
    super.key,
  });

  final DetailPanelType? type;
  final double animationProgress;

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      seed: 42,
      child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildContent(context),
        ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (animationProgress < 1) {
      return const SizedBox.shrink();
    }

    return switch (type) {
      DetailPanelType.projects =>
        BlocBuilder<ProjectsCubit, ProjectsState>(
          builder: (context, state) => state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (projects) =>
                ProjectsList(key: const ValueKey('projects'), projects: projects),
            error: (message) => Center(child: Text('Error: $message')),
          ),
        ),
      DetailPanelType.experience =>
        BlocBuilder<WorkExperienceCubit, WorkExperienceState>(
          builder: (context, state) => state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (experiences) => ExperienceList(
              key: const ValueKey('experience'),
              experiences: experiences,
            ),
            error: (message) => Center(child: Text('Error: $message')),
          ),
        ),
      DetailPanelType.contact => const ContactPanel(
          key: ValueKey('contact'),
        ),
      null => const SizedBox.shrink(),
    };
  }
}
