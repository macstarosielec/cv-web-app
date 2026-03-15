import 'dart:async';

import 'package:cv_content/presentation/home/cubit/profile_cubit.dart';
import 'package:cv_content/presentation/home/cubit/profile_state.dart';
import 'package:cv_content/presentation/home/view/widgets/desktop_layout.dart';
import 'package:cv_content/presentation/home/view/widgets/mobile_layout.dart';
import 'package:cv_content/presentation/models/detail_panel_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/analytics/analytics_service.dart';
import 'package:shared/config/app_config.dart';
import 'package:shared/utils/breakpoints.dart';
import 'package:shared/utils/visit_tracker.dart';
import 'package:shared/widgets/dot_loader.dart';
import 'package:shared/widgets/full_page_error.dart';

class HomeView extends HookWidget {
  const HomeView({super.key});

  static const List<DetailPanelType> _autoPopulateOrder = [
    DetailPanelType.experience,
    DetailPanelType.projects,
    DetailPanelType.contact,
  ];

  @override
  Widget build(BuildContext context) {
    final config = useMemoized(() => GetIt.instance<IAppConfig>());
    final shouldAnimate = useMemoized(() {
      if (config.alwaysAnimateEntrance) return true;
      final first = VisitTracker.isFirstVisit();
      if (first) VisitTracker.markVisited();
      return first;
    });

    final hasAnimated = useState(false);
    final selectedPanels = useState<List<DetailPanelType>>([]);
    final hasInteracted = useState(false);
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

    final analyticsService = useMemoized(
      () => GetIt.instance<AnalyticsService>(),
    );

    final breakpoint = Breakpoints.of(context);
    final previousBreakpoint = useRef(breakpoint);
    final isDesktop = breakpoint == ScreenBreakpoint.desktop;
    final isMobile = breakpoint == ScreenBreakpoint.mobile;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final padding = _lerpPadding(screenWidth);

    final maxPanels = _computeMaxPanels(screenWidth);

    // Auto-populate panels on load or resize wider (if not interacted)
    useEffect(
      () {
        if (!hasInteracted.value && isDesktop && maxPanels > 1) {
          final autoPanels =
              _autoPopulateOrder.take(maxPanels).toList();
          selectedPanels.value = autoPanels;
          if (animationController.status == AnimationStatus.dismissed) {
            unawaited(animationController.forward());
          }
        }

        // Truncate panels from end if resized narrower
        if (selectedPanels.value.length > maxPanels) {
          selectedPanels.value =
              selectedPanels.value.take(maxPanels).toList();
          if (selectedPanels.value.isEmpty) {
            unawaited(animationController.reverse());
          }
        }

        return null;
      },
      [maxPanels, isDesktop],
    );

    void onChipSelected(DetailPanelType type) {
      hasInteracted.value = true;

      if (maxPanels <= 1) {
        // Single-panel mode: toggle behavior
        if (selectedPanels.value.contains(type)) {
          selectedPanels.value = [];
          unawaited(animationController.reverse());
        } else {
          selectedPanels.value = [type];
          unawaited(analyticsService.logPanelOpened(type.name));
          if (animationController.status == AnimationStatus.dismissed) {
            unawaited(animationController.forward());
          }
        }
      } else {
        // Multi-panel mode
        final current = List.of(selectedPanels.value);
        if (current.contains(type)) {
          current.remove(type);
          selectedPanels.value = current;
          if (current.isEmpty) {
            unawaited(animationController.reverse());
          }
        } else {
          unawaited(analyticsService.logPanelOpened(type.name));
          if (current.length >= maxPanels) {
            current.removeLast();
          }
          current.add(type);
          selectedPanels.value = current;
          if (animationController.status == AnimationStatus.dismissed) {
            unawaited(animationController.forward());
          }
        }
      }
    }

    final animate = shouldAnimate && !hasAnimated.value;
    useEffect(
      () {
        if (shouldAnimate) hasAnimated.value = true;
        return null;
      },
      const [],
    );

    useEffect(
      () {
        final prev = previousBreakpoint.value;
        final crossedDesktop =
            (prev == ScreenBreakpoint.desktop) !=
                (breakpoint == ScreenBreakpoint.desktop);
        if (crossedDesktop && selectedPanels.value.isNotEmpty) {
          animationController.reset();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            unawaited(animationController.forward());
          });
        }
        previousBreakpoint.value = breakpoint;
        return null;
      },
      [breakpoint],
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) => state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(
            child: DotLoader(),
          ),
          loaded: (profile) => Center(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: !isDesktop
                  ? MobileLayout(
                      profile: profile,
                      selectedPanel: selectedPanels.value.isNotEmpty
                          ? selectedPanels.value.first
                          : null,
                      selectedPanels: selectedPanels.value.toSet(),
                      onChipSelected: onChipSelected,
                      animation: animation,
                      shouldAnimate: animate,
                      iconOnlyChips: isMobile,
                    )
                  : DesktopLayout(
                      profile: profile,
                      selectedPanels: selectedPanels.value,
                      maxPanels: maxPanels,
                      onChipSelected: onChipSelected,
                      animation: animation,
                      shouldAnimate: animate,
                    ),
            ),
          ),
          error: (exception) => FullPageError(
            exception: exception,
            onRetry: () =>
                context.read<ProfileCubit>().loadProfile(),
          ),
        ),
      ),
    );
  }

  int _computeMaxPanels(double screenWidth) {
    // Only enable multi-panel on truly wide screens.
    // Single-panel layout already handles up to ~1200px content well.
    // 1600+ can fit 2 panels, 2200+ can fit 3.
    if (screenWidth >= 2200) return 3;
    if (screenWidth >= 1600) return 2;
    return 1;
  }

  double _lerpPadding(double screenWidth) {
    const minPadding = 16.0;
    const maxPadding = 32.0;
    const minWidth = 600.0;
    const maxWidth = 1024.0;
    final t = ((screenWidth - minWidth) / (maxWidth - minWidth))
        .clamp(0.0, 1.0);
    return minPadding + (maxPadding - minPadding) * t;
  }
}
