import 'dart:async';

import 'package:admin_content/presentation/projects/cubit/admin_projects_cubit.dart';
import 'package:admin_content/presentation/projects/cubit/admin_projects_state.dart';
import 'package:admin_content/presentation/projects/view/widgets/admin_project_card.dart';
import 'package:admin_content/presentation/projects/view/widgets/project_editor_dialog.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/gen/colors.gen.dart';

class ProjectsListView extends StatelessWidget {
  const ProjectsListView({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AdminProjectsCubit, AdminProjectsState>(
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.transparent,
          body: state.when(
            initial: () => const SizedBox.shrink(),
            loading: () =>
                const Center(child: CircularProgressIndicator()),
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
              ProjectEditorDialog.show(
                context,
                cubit: context.read<AdminProjectsCubit>(),
              ),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      );

  Widget _buildList(List<Project> projects) => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: projects.length,
        itemBuilder: (context, index) =>
            AdminProjectCard(project: projects[index]),
      );
}
