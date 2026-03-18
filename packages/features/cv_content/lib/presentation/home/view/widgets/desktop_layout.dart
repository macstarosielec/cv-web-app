import 'package:cv_content/presentation/home/view/widgets/multi_panel_layout.dart';
import 'package:cv_content/presentation/home/view/widgets/single_panel_layout.dart';
import 'package:cv_content/presentation/models/detail_panel_type.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({
    required this.profile,
    required this.selectedPanels,
    required this.closingPanels,
    required this.maxPanels,
    required this.onChipSelected,
    required this.onPanelClosed,
    required this.animation,
    required this.shouldAnimate,
    super.key,
  });

  final Profile profile;
  final List<DetailPanelType> selectedPanels;
  final Set<DetailPanelType> closingPanels;
  final int maxPanels;
  final ValueChanged<DetailPanelType> onChipSelected;
  final ValueChanged<DetailPanelType> onPanelClosed;
  final Animation<double> animation;
  final bool shouldAnimate;

  @override
  Widget build(BuildContext context) {
    if (maxPanels <= 1) {
      return SinglePanelLayout(
        profile: profile,
        selectedPanels: selectedPanels,
        onChipSelected: onChipSelected,
        animation: animation,
        shouldAnimate: shouldAnimate,
      );
    }
    return MultiPanelLayout(
      profile: profile,
      selectedPanels: selectedPanels,
      closingPanels: closingPanels,
      maxPanels: maxPanels,
      onChipSelected: onChipSelected,
      onPanelClosed: onPanelClosed,
      shouldAnimate: shouldAnimate,
    );
  }
}
