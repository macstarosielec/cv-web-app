import 'dart:async';

import 'package:admin_content/presentation/work_experience/cubit/admin_work_experience_cubit.dart';
import 'package:admin_content/presentation/work_experience/cubit/admin_work_experience_state.dart';
import 'package:admin_content/presentation/work_experience/view/widgets/admin_experience_card.dart';
import 'package:admin_content/presentation/work_experience/view/widgets/experience_editor_dialog.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/widgets/dot_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/gen/colors.gen.dart';

class WorkExperienceListView extends StatelessWidget {
  const WorkExperienceListView({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AdminWorkExperienceCubit, AdminWorkExperienceState>(
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.transparent,
          body: state.when(
            initial: () => const SizedBox.shrink(),
            loading: () =>
                const Center(child: DotLoader()),
            loaded: _buildList,
            saving: _buildList,
            error: (message) => Center(
              child: Text(
                message,
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: () => unawaited(
              ExperienceEditorDialog.show(
                context,
                cubit: context.read<AdminWorkExperienceCubit>(),
              ),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      );

  Widget _buildList(List<WorkExperience> workExperiences) => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: workExperiences.length,
        itemBuilder: (context, index) =>
            AdminExperienceCard(workExperience: workExperiences[index]),
      );
}
