import 'package:admin_content/presentation/dashboard/admin_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/widgets/action_chip.dart' as shared;
import 'package:shared/widgets/gradient_card.dart';
import 'package:shared/widgets/navigation_chip.dart';

class DashboardNavCard extends StatelessWidget {
  const DashboardNavCard({
    required this.selectedItem,
    required this.onItemSelected,
    required this.onSignOut,
    super.key,
  });

  final AdminNavItem selectedItem;
  final ValueChanged<AdminNavItem> onItemSelected;
  final VoidCallback onSignOut;

  String _localizedLabel(AppLocalizations l10n, AdminNavItem item) =>
      switch (item) {
        AdminNavItem.profile => l10n.profile,
        AdminNavItem.projects => l10n.projects,
        AdminNavItem.workExperience => l10n.experience,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return GradientCard(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.dashboard,
                textAlign: TextAlign.center,
                style:
                    Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: ColorName.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
              ),
              const SizedBox(height: 32),
              ...AdminNavItem.values.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: NavigationChip(
                    label: _localizedLabel(l10n, item),
                    icon: item.icon,
                    isSelected: selectedItem == item,
                    onTap: () => onItemSelected(item),
                  ),
                ),
              ),
              const Spacer(),
              shared.ActionChip(
                label: l10n.signOut,
                icon: Icons.logout,
                onTap: onSignOut,
              ),
            ],
          ),
        ),
      );
  }
}
