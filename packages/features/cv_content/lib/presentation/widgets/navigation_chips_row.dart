import 'package:cv_content/presentation/models/detail_panel_type.dart';
import 'package:flutter/material.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/widgets/action_chip.dart' as shared;

class NavigationChipsRow extends StatelessWidget {
  const NavigationChipsRow({
    required this.selectedPanels,
    required this.onChipSelected,
    this.iconOnly = false,
    super.key,
  });

  final Set<DetailPanelType> selectedPanels;
  final ValueChanged<DetailPanelType> onChipSelected;
  final bool iconOnly;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: shared.ActionChip(
            label: l10n.projects,
            icon: Icons.code_rounded,
            isSelected: selectedPanels.contains(DetailPanelType.projects),
            onTap: () => onChipSelected(DetailPanelType.projects),
            iconOnly: iconOnly,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: shared.ActionChip(
            label: l10n.experience,
            icon: Icons.work_outline_rounded,
            isSelected: selectedPanels.contains(DetailPanelType.experience),
            onTap: () => onChipSelected(DetailPanelType.experience),
            iconOnly: iconOnly,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: shared.ActionChip(
            label: l10n.contact,
            icon: Icons.mail_outline_rounded,
            isSelected: selectedPanels.contains(DetailPanelType.contact),
            onTap: () => onChipSelected(DetailPanelType.contact),
            iconOnly: iconOnly,
          ),
        ),
      ],
    );
  }
}
