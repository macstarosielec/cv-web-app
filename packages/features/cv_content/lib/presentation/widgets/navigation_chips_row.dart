import 'package:cv_content/presentation/models/detail_panel_type.dart';
import 'package:cv_content/presentation/widgets/navigation_chip.dart';
import 'package:flutter/material.dart';
import 'package:shared/l10n/l10n.dart';

class NavigationChipsRow extends StatelessWidget {
  const NavigationChipsRow({
    required this.selectedPanel,
    required this.onChipSelected,
    this.iconOnly = false,
    super.key,
  });

  final DetailPanelType? selectedPanel;
  final ValueChanged<DetailPanelType> onChipSelected;
  final bool iconOnly;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: NavigationChip(
            label: l10n.projects,
            icon: Icons.code_rounded,
            isSelected: selectedPanel == DetailPanelType.projects,
            onTap: () => onChipSelected(DetailPanelType.projects),
            iconOnly: iconOnly,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: NavigationChip(
            label: l10n.experience,
            icon: Icons.work_outline_rounded,
            isSelected: selectedPanel == DetailPanelType.experience,
            onTap: () => onChipSelected(DetailPanelType.experience),
            iconOnly: iconOnly,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: NavigationChip(
            label: l10n.contact,
            icon: Icons.mail_outline_rounded,
            isSelected: selectedPanel == DetailPanelType.contact,
            onTap: () => onChipSelected(DetailPanelType.contact),
            iconOnly: iconOnly,
          ),
        ),
      ],
    );
  }
}
