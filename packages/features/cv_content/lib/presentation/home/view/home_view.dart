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
import 'package:shared/config/app_config.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/utils/breakpoints.dart';
import 'package:shared/utils/visit_tracker.dart';
import 'package:shared/widgets/dot_loader.dart';

class HomeView extends HookWidget {
  const HomeView({super.key});

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

    final animate = shouldAnimate && !hasAnimated.value;
    useEffect(
      () {
        if (shouldAnimate) hasAnimated.value = true;
        return null;
      },
      const [],
    );

    final breakpoint = Breakpoints.of(context);
    final previousBreakpoint = useRef(breakpoint);
    final isDesktop = breakpoint == ScreenBreakpoint.desktop;
    final isMobile = breakpoint == ScreenBreakpoint.mobile;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final padding = _lerpPadding(screenWidth);

    useEffect(
      () {
        final prev = previousBreakpoint.value;
        final crossedDesktop =
            (prev == ScreenBreakpoint.desktop) != (breakpoint == ScreenBreakpoint.desktop);
        if (crossedDesktop && selectedPanel.value != null) {
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
                      selectedPanel: selectedPanel.value,
                      onChipSelected: onChipSelected,
                      animation: animation,
                      shouldAnimate: animate,
                      iconOnlyChips: isMobile,
                    )
                  : DesktopLayout(
                      profile: profile,
                      selectedPanel: selectedPanel.value,
                      onChipSelected: onChipSelected,
                      animation: animation,
                      shouldAnimate: animate,
                    ),
            ),
          ),
          error: (message) => Center(
            child: Text(
              AppLocalizations.of(context).errorMessage(message),
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _lerpPadding(double screenWidth) {
    const minPadding = 16.0;
    const maxPadding = 32.0;
    const minWidth = 600.0;
    const maxWidth = 1024.0;
    final t = ((screenWidth - minWidth) / (maxWidth - minWidth)).clamp(0.0, 1.0);
    return minPadding + (maxPadding - minPadding) * t;
  }
}
