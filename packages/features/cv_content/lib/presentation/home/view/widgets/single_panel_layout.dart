import 'package:cv_content/presentation/home/view/widgets/detail_panel.dart';
import 'package:cv_content/presentation/home/view/widgets/profile_card.dart';
import 'package:cv_content/presentation/models/detail_panel_type.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class SinglePanelLayout extends StatelessWidget {
  const SinglePanelLayout({
    required this.profile,
    required this.selectedPanels,
    required this.onChipSelected,
    required this.animation,
    required this.shouldAnimate,
    super.key,
  });

  final Profile profile;
  final List<DetailPanelType> selectedPanels;
  final ValueChanged<DetailPanelType> onChipSelected;
  final Animation<double> animation;
  final bool shouldAnimate;

  static const _maxTotalWidth = 1200.0;
  static const _maxCollapsedWidth = 600.0;
  static const _gap = 24.0;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
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
