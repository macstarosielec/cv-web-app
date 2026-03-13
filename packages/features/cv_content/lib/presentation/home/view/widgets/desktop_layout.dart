import 'package:cv_content/presentation/home/view/home_view.dart';
import 'package:cv_content/presentation/home/view/widgets/detail_panel.dart';
import 'package:cv_content/presentation/home/view/widgets/profile_card.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({
    required this.profile,
    required this.selectedPanel,
    required this.onChipSelected,
    required this.animation,
    required this.shouldAnimate,
    super.key,
  });

  final Profile profile;
  final DetailPanelType? selectedPanel;
  final ValueChanged<DetailPanelType> onChipSelected;
  final Animation<double> animation;
  final bool shouldAnimate;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          final expandProgress = animation.value;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedContainer(
                duration: Duration.zero,
                width: _profileCardWidth(context, expandProgress),
                child: ProfileCard(
                  profile: profile,
                  selectedPanel: selectedPanel,
                  onChipSelected: onChipSelected,
                  animate: shouldAnimate,
                ),
              ),
              if (expandProgress > 0) ...[
                const SizedBox(width: 24),
                SizedBox(
                  width: _detailPanelWidth(context, expandProgress),
                  child: Opacity(
                    opacity: expandProgress,
                    child: DetailPanel(
                      type: selectedPanel,
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
    final screenWidth = MediaQuery.sizeOf(context).width;
    final maxCardWidth = (screenWidth - 80).clamp(0.0, 600.0);
    final halfWidth = (screenWidth - 80) * 0.45;
    return maxCardWidth - (maxCardWidth - halfWidth) * expandProgress;
  }

  double _detailPanelWidth(
    BuildContext context,
    double expandProgress,
  ) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return ((screenWidth - 80) * 0.5) * expandProgress;
  }
}
