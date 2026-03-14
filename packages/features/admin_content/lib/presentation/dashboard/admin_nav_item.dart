import 'package:flutter/material.dart';

enum AdminNavItem {
  profile,
  projects,
  workExperience;

  // Labels are hardcoded here as the enum has no BuildContext.
  // Localize at the usage site (dashboard_nav_card.dart,
  // transition_nav_content.dart) via AdminNavItem.localizedLabel(l10n).
  String get label => switch (this) {
        AdminNavItem.profile => 'Profile',
        AdminNavItem.projects => 'Projects',
        AdminNavItem.workExperience => 'Experience',
      };

  IconData get icon => switch (this) {
        AdminNavItem.profile => Icons.person_outline,
        AdminNavItem.projects => Icons.code_rounded,
        AdminNavItem.workExperience => Icons.work_outline_rounded,
      };
}
