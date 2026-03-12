import 'dart:math';

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
import 'package:shared/l10n/l10n.dart';

class DetailPanel extends StatefulWidget {
  const DetailPanel({
    required this.type,
    required this.animationProgress,
    super.key,
  });

  final DetailPanelType? type;
  final double animationProgress;

  @override
  State<DetailPanel> createState() => _DetailPanelState();
}

class _DetailPanelState extends State<DetailPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flipController;
  late final Animation<double> _flipAnimation;
  DetailPanelType? _displayedType;
  DetailPanelType? _nextType;

  @override
  void initState() {
    super.initState();
    _displayedType = widget.type;
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _flipAnimation = CurvedAnimation(
      parent: _flipController,
      curve: Curves.easeInOut,
    );
    _flipController.addStatusListener(_onFlipComplete);
  }

  void _onFlipComplete(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _displayedType = _nextType;
        _flipController.reset();
      });
    }
  }

  @override
  void didUpdateWidget(DetailPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.type != oldWidget.type && widget.type != null) {
      if (_displayedType == null) {
        setState(() {
          _displayedType = widget.type;
        });
      } else if (widget.type != _displayedType) {
        _nextType = widget.type;
        _flipController.forward();
      }
    }
  }

  @override
  void dispose() {
    _flipController.removeStatusListener(_onFlipComplete);
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animationProgress < 1) {
      return GradientCard(seed: 42, child: const SizedBox.shrink());
    }

    return AnimatedBuilder(
      animation: _flipAnimation,
      builder: (context, _) {
        final value = _flipAnimation.value;
        final isFirstHalf = value <= 0.5;
        final type = isFirstHalf ? _displayedType : _nextType;

        final angle = isFirstHalf
            ? value * pi
            : (value - 1) * pi;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          child: GradientCard(
            seed: _seedForType(type),
            child: _buildPanelContent(context, type),
          ),
        );
      },
    );
  }

  int _seedForType(DetailPanelType? type) {
    return switch (type) {
      DetailPanelType.projects => 42,
      DetailPanelType.experience => 84,
      DetailPanelType.contact => 126,
      null => 42,
    };
  }

  Widget _buildPanelContent(
    BuildContext context,
    DetailPanelType? type,
  ) {
    return switch (type) {
      DetailPanelType.projects =>
        BlocBuilder<ProjectsCubit, ProjectsState>(
          builder: (context, state) => state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (projects) => ProjectsList(
              key: const ValueKey('projects'),
              projects: projects,
            ),
            error: (message) =>
                Center(
                child: Text(
                  AppLocalizations.of(context).errorMessage(message),
                ),
              ),
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
            error: (message) =>
                Center(
                child: Text(
                  AppLocalizations.of(context).errorMessage(message),
                ),
              ),
          ),
        ),
      DetailPanelType.contact => const ContactPanel(
          key: ValueKey('contact'),
        ),
      null => const SizedBox.shrink(),
    };
  }
}
