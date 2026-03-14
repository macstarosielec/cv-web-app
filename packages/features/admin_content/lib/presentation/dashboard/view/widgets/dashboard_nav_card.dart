import 'package:admin_content/presentation/models/admin_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
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

  @override
  Widget build(BuildContext context) => GradientCard(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Dashboard',
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
                    label: item.label,
                    icon: item.icon,
                    isSelected: selectedItem == item,
                    onTap: () => onItemSelected(item),
                  ),
                ),
              ),
              const Spacer(),
              shared.ActionChip(
                label: 'Sign Out',
                icon: Icons.logout,
                onTap: onSignOut,
              ),
            ],
          ),
        ),
      );
}
