import 'dart:async';

import 'package:admin_content/presentation/work_experience/cubit/admin_work_experience_cubit.dart';
import 'package:admin_content/presentation/work_experience/cubit/admin_work_experience_state.dart';
import 'package:admin_content/presentation/work_experience/view/widgets/admin_experience_card.dart';
import 'package:admin_content/presentation/work_experience/view/widgets/experience_form.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/widgets/dot_loader.dart';
import 'package:shared/widgets/section_error.dart';

class WorkExperienceListView extends StatefulWidget {
  const WorkExperienceListView({super.key});

  @override
  State<WorkExperienceListView> createState() =>
      _WorkExperienceListViewState();
}

class _WorkExperienceListViewState extends State<WorkExperienceListView>
    with SingleTickerProviderStateMixin {
  WorkExperience? _editingExperience;
  late final AnimationController _listStagger;

  @override
  void initState() {
    super.initState();
    _listStagger = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _listStagger.dispose();
    super.dispose();
  }

  void _onEdit(WorkExperience experience) {
    setState(() => _editingExperience = experience);
  }

  void _onDiscard() {
    setState(() => _editingExperience = null);
  }

  void _onSave(WorkExperience experience) {
    final cubit = context.read<AdminWorkExperienceCubit>();
    if (_editingExperience != null) {
      unawaited(cubit.updateWorkExperience(experience));
    } else {
      unawaited(cubit.addWorkExperience(experience));
    }
    setState(() => _editingExperience = null);
  }

  Animation<double> _listItemAnimation(int index, int total) {
    if (total == 0) return const AlwaysStoppedAnimation(1);
    final start = (index / (total + 1)).clamp(0.0, 1.0);
    final end = ((index + 2) / (total + 1)).clamp(0.0, 1.0);
    return CurvedAnimation(
      parent: _listStagger,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AdminWorkExperienceCubit, AdminWorkExperienceState>(
        builder: (context, state) => state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: DotLoader()),
          loaded: _buildContent,
          saving: _buildContent,
          error: (exception) => SectionError(
            exception: exception,
            onRetry: () =>
                context.read<AdminWorkExperienceCubit>().loadWorkExperiences(),
          ),
        ),
      );

  Widget _buildContent(List<WorkExperience> experiences) {
    if (!_listStagger.isCompleted && !_listStagger.isAnimating) {
      unawaited(_listStagger.forward());
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ExperienceForm(
            workExperience: _editingExperience,
            onSave: _onSave,
            onDiscard: _onDiscard,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: experiences.length,
            itemBuilder: (context, index) {
              final animation =
                  _listItemAnimation(index, experiences.length);
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
                    onEdit: _onEdit,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
