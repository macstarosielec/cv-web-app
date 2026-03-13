import 'package:cv_content/presentation/home/view/home_view.dart';
import 'package:cv_content/presentation/home/view/widgets/detail_panel.dart';
import 'package:cv_content/presentation/home/view/widgets/gradient_card.dart';
import 'package:cv_content/presentation/home/view/widgets/navigation_chips_row.dart';
import 'package:cv_content/presentation/home/view/widgets/profile_card_content.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({
    required this.profile,
    required this.selectedPanel,
    required this.onChipSelected,
    required this.animation,
    required this.shouldAnimate,
    this.iconOnlyChips = false,
    super.key,
  });

  final Profile profile;
  final DetailPanelType? selectedPanel;
  final ValueChanged<DetailPanelType> onChipSelected;
  final Animation<double> animation;
  final bool shouldAnimate;
  final bool iconOnlyChips;

  static const _gap = 16.0;
  static const _chipRowHeight = 36.0;

  double _cardPadding(double screenWidth) {
    const minPadding = 16.0;
    const maxPadding = 40.0;
    const minWidth = 600.0;
    const maxWidth = 1024.0;
    final t =
        ((screenWidth - minWidth) / (maxWidth - minWidth)).clamp(0.0, 1.0);
    return minPadding + (maxPadding - minPadding) * t;
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final totalHeight = constraints.maxHeight;
                final progress = animation.value;
                final cardPadding = _cardPadding(
                  MediaQuery.sizeOf(context).width,
                );
                final collapsedHeight =
                    cardPadding * 2 + _chipRowHeight;
                final profileHeight = totalHeight -
                    (totalHeight - collapsedHeight) * progress;
                final gap = _gap * progress;
                final detailHeight =
                    totalHeight - profileHeight - gap;

                return Column(
                  children: [
                    SizedBox(
                      height: profileHeight,
                      child: GradientCard(
                        child: Padding(
                          padding: EdgeInsets.all(cardPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRect(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  heightFactor: 1.0 - progress,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 32,
                                    ),
                                    child: ProfileCardContent(
                                      profile: profile,
                                      animate: shouldAnimate,
                                    ),
                                  ),
                                ),
                              ),
                              NavigationChipsRow(
                                selectedPanel: selectedPanel,
                                onChipSelected: onChipSelected,
                                iconOnly: iconOnlyChips,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (progress > 0) ...[
                      SizedBox(height: gap),
                      SizedBox(
                        height: detailHeight,
                        child: Opacity(
                          opacity: progress,
                          child: DetailPanel(
                            type: selectedPanel,
                            animationProgress: progress,
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      );
}
