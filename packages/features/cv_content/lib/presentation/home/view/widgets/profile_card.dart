import 'package:cv_content/presentation/home/view/widgets/profile_card_content.dart';
import 'package:cv_content/presentation/models/detail_panel_type.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/widgets/gradient_card.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    required this.profile,
    required this.selectedPanels,
    required this.onChipSelected,
    this.animate = false,
    super.key,
  });

  final Profile profile;
  final Set<DetailPanelType> selectedPanels;
  final ValueChanged<DetailPanelType> onChipSelected;
  final bool animate;

  @override
  Widget build(BuildContext context) => GradientCard(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: ProfileCardContent(
            profile: profile,
            selectedPanels: selectedPanels,
            onChipSelected: onChipSelected,
            animate: animate,
          ),
        ),
      );
}
