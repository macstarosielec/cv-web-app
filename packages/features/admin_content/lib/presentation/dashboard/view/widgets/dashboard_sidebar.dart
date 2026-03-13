import 'package:admin_content/router/admin_content_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class DashboardSidebar extends StatelessWidget {
  const DashboardSidebar({required this.onSignOut, super.key});

  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);
    final currentRoute = router.current.name;

    return Container(
      width: 250,
      color: ColorName.surface,
      child: Column(
        children: [
          const SizedBox(height: 32),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Admin Dashboard',
              style: TextStyle(
                color: ColorName.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 32),
          _NavItem(
            label: 'Profile',
            icon: Icons.person_outline,
            routeName: ProfileEditorRoute.name,
            isActive: currentRoute == ProfileEditorRoute.name,
            onTap: () => router.navigate(const ProfileEditorRoute()),
          ),
          _NavItem(
            label: 'Projects',
            icon: Icons.work_outline,
            routeName: ProjectsListRoute.name,
            isActive: currentRoute == ProjectsListRoute.name,
            onTap: () => router.navigate(const ProjectsListRoute()),
          ),
          _NavItem(
            label: 'Experience',
            icon: Icons.history_edu_outlined,
            routeName: WorkExperienceListRoute.name,
            isActive: currentRoute == WorkExperienceListRoute.name,
            onTap: () => router.navigate(const WorkExperienceListRoute()),
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout, color: ColorName.textMuted),
            title: const Text(
              'Sign Out',
              style: TextStyle(color: ColorName.textMuted),
            ),
            onTap: onSignOut,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.routeName,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final String routeName;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Icon(
          icon,
          color: isActive ? ColorName.accent : ColorName.textSecondary,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isActive ? ColorName.accent : ColorName.textSecondary,
            fontWeight:
                isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        tileColor: isActive ? ColorName.surfaceLight : Colors.transparent,
        onTap: onTap,
      );
}
