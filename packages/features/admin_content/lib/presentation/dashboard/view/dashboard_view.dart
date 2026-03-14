import 'dart:async';

import 'package:admin_content/presentation/dashboard/view/widgets/dashboard_nav_card.dart';
import 'package:admin_content/presentation/dashboard/admin_nav_item.dart';
import 'package:admin_content/presentation/profile/view/profile_editor_view.dart';
import 'package:admin_content/presentation/projects/view/projects_list_view.dart';
import 'package:admin_content/presentation/work_experience/view/work_experience_list_view.dart';
import 'package:flutter/material.dart';
import 'package:shared/widgets/gradient_card.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({required this.onSignOut, super.key});

  final VoidCallback onSignOut;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
  static const _margin = 24.0;
  static const _navCardWidth = 250.0;
  static const _gap = 16.0;

  AdminNavItem _selectedItem = AdminNavItem.profile;

  late final AnimationController _controller;
  Widget? _oldContent;
  bool _isTransitioning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _isTransitioning = false;
            _oldContent = null;
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemSelected(AdminNavItem item) {
    if (item == _selectedItem) return;
    setState(() {
      _oldContent = _contentFor(_selectedItem);
      _selectedItem = item;
      _isTransitioning = true;
    });
    unawaited(_controller.forward(from: 0));
  }

  Widget _contentFor(AdminNavItem item) => switch (item) {
        AdminNavItem.profile => const ProfileEditorView(),
        AdminNavItem.projects => const ProjectsListView(),
        AdminNavItem.workExperience => const WorkExperienceListView(),
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;
            const contentLeft = _margin + _navCardWidth + _gap;
            final contentWidth =
                constraints.maxWidth - contentLeft - _margin;
            final contentHeight = screenHeight - _margin * 2;

            return Stack(
              children: [
                Positioned(
                  left: _margin,
                  top: _margin,
                  width: _navCardWidth,
                  height: contentHeight,
                  child: DashboardNavCard(
                    selectedItem: _selectedItem,
                    onItemSelected: _onItemSelected,
                    onSignOut: widget.onSignOut,
                  ),
                ),
                if (_isTransitioning) ...[
                  if (_oldContent != null)
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        final t = Curves.easeInCubic
                            .transform(_controller.value);
                        return Positioned(
                          left: contentLeft,
                          top: _margin + t * screenHeight,
                          width: contentWidth,
                          height: contentHeight,
                          child: child!,
                        );
                      },
                      child: GradientCard(
                        seed: 42,
                        child: _oldContent!,
                      ),
                    ),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final t = Curves.easeOutCubic
                          .transform(_controller.value);
                      return Positioned(
                        left: contentLeft,
                        top: _margin + (t - 1) * screenHeight,
                        width: contentWidth,
                        height: contentHeight,
                        child: child!,
                      );
                    },
                    child: GradientCard(
                      seed: 42,
                      child: _contentFor(_selectedItem),
                    ),
                  ),
                ] else
                  Positioned(
                    left: contentLeft,
                    top: _margin,
                    width: contentWidth,
                    height: contentHeight,
                    child: GradientCard(
                      seed: 42,
                      child: _contentFor(_selectedItem),
                    ),
                  ),
              ],
            );
          },
        ),
      );
}
