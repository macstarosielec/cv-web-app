import 'package:admin_content/presentation/dashboard/view/widgets/dashboard_content_card.dart';
import 'package:admin_content/presentation/dashboard/view/widgets/dashboard_nav_card.dart';
import 'package:admin_content/presentation/models/admin_nav_item.dart';
import 'package:admin_content/presentation/profile/view/profile_editor_view.dart';
import 'package:admin_content/presentation/projects/view/projects_list_view.dart';
import 'package:admin_content/presentation/work_experience/view/work_experience_list_view.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({required this.onSignOut, super.key});

  final VoidCallback onSignOut;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  AdminNavItem _selectedItem = AdminNavItem.profile;

  Widget get _content => switch (_selectedItem) {
        AdminNavItem.profile => const ProfileEditorView(),
        AdminNavItem.projects => const ProjectsListView(),
        AdminNavItem.workExperience => const WorkExperienceListView(),
      };

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DashboardNavCard(
                selectedItem: _selectedItem,
                onItemSelected: (item) =>
                    setState(() => _selectedItem = item),
                onSignOut: widget.onSignOut,
              ),
              const SizedBox(width: 16),
              DashboardContentCard(child: _content),
            ],
          ),
        ),
      );
}
