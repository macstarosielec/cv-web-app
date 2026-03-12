import 'dart:async';

import 'package:cv_content/presentation/home/cubit/profile_cubit.dart';
import 'package:cv_content/presentation/home/cubit/profile_state.dart';
import 'package:cv_content/presentation/home/view/widgets/detail_panel.dart';
import 'package:cv_content/presentation/home/view/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/utils/visit_tracker.dart';

enum DetailPanelType { projects, experience, contact }

class HomeView extends HookWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedPanel = useState<DetailPanelType?>(null);
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );
    final animation = useMemoized(
      () => CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOutCubic,
      ),
      [animationController],
    );

    final entranceController = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );
    final entranceAnimation = useMemoized(
      () => CurvedAnimation(
        parent: entranceController,
        curve: Curves.easeOutCubic,
      ),
      [entranceController],
    );

    final isFirstVisit = useMemoized(VisitTracker.isFirstVisit);
    final entranceReady = useState(false);

    useEffect(
      () {
        if (isFirstVisit) {
          VisitTracker.markVisited();
        } else {
          entranceController.value = 1;
        }
        entranceReady.value = true;
        return null;
      },
      [],
    );

    void onChipSelected(DetailPanelType type) {
      if (selectedPanel.value == type) {
        selectedPanel.value = null;
        unawaited(animationController.reverse());
      } else {
        selectedPanel.value = type;
        if (animationController.status == AnimationStatus.dismissed) {
          unawaited(animationController.forward());
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) => state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          loaded: (profile) {
            if (isFirstVisit &&
                entranceController.status == AnimationStatus.dismissed) {
              unawaited(entranceController.forward());
            }

            return AnimatedBuilder(
              animation: entranceAnimation,
              builder: (context, _) {
                if (!entranceReady.value) {
                  return const SizedBox.shrink();
                }

                final entranceProgress = entranceAnimation.value;

                return Transform.scale(
                  scale: 0.85 + 0.15 * entranceProgress,
                  child: Opacity(
                    opacity: entranceProgress,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) {
                            final expandProgress = animation.value;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                              children: [
                                AnimatedContainer(
                                  duration: Duration.zero,
                                  width: _profileCardWidth(
                                    context,
                                    expandProgress,
                                  ),
                                  child: ProfileCard(
                                    profile: profile,
                                    selectedPanel: selectedPanel.value,
                                    onChipSelected: onChipSelected,
                                  ),
                                ),
                                if (expandProgress > 0) ...[
                                  const SizedBox(width: 24),
                                  SizedBox(
                                    width: _detailPanelWidth(
                                      context,
                                      expandProgress,
                                    ),
                                    child: Opacity(
                                      opacity: expandProgress,
                                      child: DetailPanel(
                                        type: selectedPanel.value,
                                        animationProgress:
                                            expandProgress,
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
                  ),
                );
              },
            );
          },
          error: (message) => Center(
            child: Text(
              'Error: $message',
              style: const TextStyle(color: ColorName.accentLight),
            ),
          ),
        ),
      ),
    );
  }

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
