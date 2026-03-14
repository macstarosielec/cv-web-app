import 'package:flutter/material.dart';

enum AdminNavItem {
  profile,
  projects,
  workExperience;

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
