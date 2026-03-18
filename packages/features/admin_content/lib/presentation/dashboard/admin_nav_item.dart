import 'package:flutter/material.dart';
import 'package:shared/l10n/l10n.dart';

enum AdminNavItem {
  profile,
  projects,
  workExperience;

  IconData get icon => switch (this) {
        AdminNavItem.profile => Icons.person_outline,
        AdminNavItem.projects => Icons.code_rounded,
        AdminNavItem.workExperience => Icons.work_outline_rounded,
      };

  String label(AppLocalizations l10n) => switch (this) {
        AdminNavItem.profile => l10n.profile,
        AdminNavItem.projects => l10n.projects,
        AdminNavItem.workExperience => l10n.experience,
      };
}
