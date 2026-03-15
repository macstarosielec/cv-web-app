import 'package:cv_content/presentation/home/view/widgets/detail_panel.dart';
import 'package:cv_content/presentation/home/view/widgets/multi_panel_item.dart';
import 'package:cv_content/presentation/home/view/widgets/profile_card.dart';
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

  static const _maxTotalWidth = 1200.0;
  static const _maxCollapsedWidth = 600.0;
  static const _gap = 24.0;

  @override
  Widget build(BuildContext context) {
    if (maxPanels <= 1) {
      return _buildSinglePanelLayout(context);
    }
    return _buildMultiPanelLayout(context);
  }

  Widget _buildSinglePanelLayout(BuildContext context) => AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final expandProgress = animation.value;
          final singleSelected =
              selectedPanels.isNotEmpty ? selectedPanels.last : null;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: _profileCardWidth(context, expandProgress),
                child: ProfileCard(
                  profile: profile,
                  selectedPanels: selectedPanels.toSet(),
                  onChipSelected: onChipSelected,
                  animate: shouldAnimate,
                ),
              ),
              if (expandProgress > 0) ...[
                const SizedBox(width: _gap),
                SizedBox(
                  width: _detailPanelWidth(context, expandProgress),
                  child: Opacity(
                    opacity: expandProgress,
                    child: DetailPanel(
                      type: singleSelected,
                      animationProgress: expandProgress,
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      );

  static const _maxSlotWidth = 500.0;
  static const _animDuration = Duration(milliseconds: 300);

  Widget _buildMultiPanelLayout(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final available = screenWidth - 64;

    // Compute target widths based on ACTIVE panels only
    // (excluding closing ones) so remaining panels expand
    // to fill space as closing ones shrink out.
    final activePanels = selectedPanels
        .where((t) => !closingPanels.contains(t))
        .toList();
    final activeCount = activePanels.length;
    final activeProjectsOpen =
        activePanels.contains(DetailPanelType.projects);
    final otherActiveCount =
        activeCount - (activeProjectsOpen ? 1 : 0);
    final projectsCanDouble =
        activeProjectsOpen && otherActiveCount + 2 <= maxPanels;
    final totalSlots =
        1 + activeCount + (projectsCanDouble ? 1 : 0);
    final totalGaps =
        activeCount + (projectsCanDouble ? 1 : 0);
    final expandedSlotWidth =
        ((available - _gap * totalGaps) / totalSlots)
            .clamp(0.0, _maxSlotWidth);

    // Profile: AnimatedContainer smoothly transitions between
    // collapsed (no panels) and slot width (panels open).
    final collapsedProfileWidth =
        available.clamp(0.0, _maxCollapsedWidth);
    final targetProfileWidth = activeCount > 0
        ? expandedSlotWidth
        : collapsedProfileWidth;

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

  double _profileCardWidth(
    BuildContext context,
    double expandProgress,
  ) {
    final available =
        (MediaQuery.sizeOf(context).width - 80).clamp(0.0, _maxTotalWidth);
    final collapsedWidth = available.clamp(0.0, _maxCollapsedWidth);
    final expandedWidth = (available - _gap) * 0.5;
    return collapsedWidth -
        (collapsedWidth - expandedWidth) * expandProgress;
  }

  double _detailPanelWidth(
    BuildContext context,
    double expandProgress,
  ) {
    final available =
        (MediaQuery.sizeOf(context).width - 80).clamp(0.0, _maxTotalWidth);
    return ((available - _gap) * 0.5) * expandProgress;
  }
}
