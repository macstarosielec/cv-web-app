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
    required this.maxPanels,
    required this.onChipSelected,
    required this.animation,
    required this.shouldAnimate,
    super.key,
  });

  final Profile profile;
  final List<DetailPanelType> selectedPanels;
  final int maxPanels;
  final ValueChanged<DetailPanelType> onChipSelected;
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
              AnimatedContainer(
                duration: Duration.zero,
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

  Widget _buildMultiPanelLayout(BuildContext context) =>
      AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          final expandProgress = animation.value;
          final screenWidth = MediaQuery.sizeOf(context).width;
          final available = screenWidth - 64;
          final panelCount = selectedPanels.length;

          // All items share equal slot width, capped at max.
          // Projects always gets 2 slots.
          final projectsIsOpen =
              selectedPanels.contains(DetailPanelType.projects);
          final totalSlots =
              1 + panelCount + (projectsIsOpen ? 1 : 0);
          final totalGaps =
              panelCount + (projectsIsOpen ? 1 : 0);
          final expandedSlotWidth =
              ((available - _gap * totalGaps) / totalSlots)
                  .clamp(0.0, _maxSlotWidth);

          // Profile lerps from collapsed (centered) to slot width.
          final collapsedProfileWidth =
              available.clamp(0.0, _maxCollapsedWidth);
          final targetProfileWidth = collapsedProfileWidth -
              (collapsedProfileWidth - expandedSlotWidth) *
                  expandProgress;

          final slotWidth = expandedSlotWidth * expandProgress;

          double widthForType(DetailPanelType type) =>
              type == DetailPanelType.projects
                  ? slotWidth * 2 + _gap * expandProgress
                  : slotWidth;

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
              if (expandProgress > 0)
                ...selectedPanels.indexed.map(
                  (entry) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: _gap * expandProgress),
                      Opacity(
                        opacity: expandProgress,
                        child: MultiPanelItem(
                          key: ValueKey(entry.$1),
                          width: widthForType(entry.$2),
                          type: entry.$2,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      );

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
