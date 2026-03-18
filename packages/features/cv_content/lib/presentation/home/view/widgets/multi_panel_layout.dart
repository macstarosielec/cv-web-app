import 'package:cv_content/presentation/home/view/widgets/multi_panel_item.dart';
import 'package:cv_content/presentation/home/view/widgets/profile_card.dart';
import 'package:cv_content/presentation/models/detail_panel_type.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class MultiPanelLayout extends StatelessWidget {
  const MultiPanelLayout({
    required this.profile,
    required this.selectedPanels,
    required this.closingPanels,
    required this.maxPanels,
    required this.onChipSelected,
    required this.onPanelClosed,
    required this.shouldAnimate,
    super.key,
  });

  final Profile profile;
  final List<DetailPanelType> selectedPanels;
  final Set<DetailPanelType> closingPanels;
  final int maxPanels;
  final ValueChanged<DetailPanelType> onChipSelected;
  final ValueChanged<DetailPanelType> onPanelClosed;
  final bool shouldAnimate;

  static const _maxCollapsedWidth = 600.0;
  static const _maxSlotWidth = 500.0;
  static const _gap = 24.0;
  static const _animDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final available = screenWidth - 64;

    final activePanels =
        selectedPanels.where((t) => !closingPanels.contains(t)).toList();
    final activeCount = activePanels.length;
    final activeProjectsOpen =
        activePanels.contains(DetailPanelType.projects);
    final otherActiveCount = activeCount - (activeProjectsOpen ? 1 : 0);
    final projectsCanDouble =
        activeProjectsOpen && otherActiveCount + 2 <= maxPanels;
    final totalSlots = 1 + activeCount + (projectsCanDouble ? 1 : 0);
    final totalGaps = activeCount + (projectsCanDouble ? 1 : 0);
    final expandedSlotWidth =
        ((available - _gap * totalGaps) / totalSlots).clamp(0.0, _maxSlotWidth);

    final collapsedProfileWidth = available.clamp(0.0, _maxCollapsedWidth);
    final targetProfileWidth =
        activeCount > 0 ? expandedSlotWidth : collapsedProfileWidth;

    double widthForType(DetailPanelType type) =>
        type == DetailPanelType.projects && projectsCanDouble
            ? expandedSlotWidth * 2 + _gap
            : expandedSlotWidth;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedContainer(
          duration: _animDuration,
          curve: Curves.easeOut,
          width: targetProfileWidth,
          child: ProfileCard(
            profile: profile,
            selectedPanels: selectedPanels.toSet(),
            onChipSelected: onChipSelected,
            animate: shouldAnimate,
          ),
        ),
        ...selectedPanels.map(
          (type) => MultiPanelItem(
            key: ValueKey(type),
            targetWidth: widthForType(type),
            gap: _gap,
            type: type,
            isClosing: closingPanels.contains(type),
            onClosed: () => onPanelClosed(type),
          ),
        ),
      ],
    );
  }
}
