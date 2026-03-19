import 'package:admin_app/app/widgets/auth_phase_indicator.dart';
import 'package:admin_app/app/widgets/login_card_placeholder.dart';
import 'package:admin_app/app/widgets/transition_nav_content.dart';
import 'package:flutter/material.dart';
import 'package:shared/widgets/gradient_card.dart';

class AuthCardContent extends StatelessWidget {
  const AuthCardContent({
    required this.phase,
    required this.fadeAnimation,
    required this.navFadeAnimation,
    required this.onStaggerComplete,
    super.key,
  });

  final AuthPhase phase;
  final Animation<double> fadeAnimation;
  final Animation<double> navFadeAnimation;
  final VoidCallback onStaggerComplete;

  @override
  Widget build(BuildContext context) {
    if (phase == AuthPhase.fadeOutContent ||
        phase == AuthPhase.fadeInContent) {
      return AnimatedBuilder(
        animation: fadeAnimation,
        builder: (context, child) => GradientCard(
          child: Opacity(
            opacity: 1 - fadeAnimation.value,
            child: child,
          ),
        ),
        child: const LoginCardPlaceholder(),
      );
    }

    if (phase == AuthPhase.morphCard || phase == AuthPhase.unmorphCard) {
      return const GradientCard(child: SizedBox.expand());
    }

    if (phase == AuthPhase.staggerNav ||
        phase == AuthPhase.revealContent) {
      return GradientCard(
        child: TransitionNavContent(onComplete: onStaggerComplete),
      );
    }

    if (phase == AuthPhase.unstaggerNav ||
        phase == AuthPhase.hideContent) {
      return AnimatedBuilder(
        animation: navFadeAnimation,
        builder: (context, child) => GradientCard(
          child: Opacity(
            opacity: navFadeAnimation.value,
            child: Transform.translate(
              offset: Offset(0, 8 * (1 - navFadeAnimation.value)),
              child: child,
            ),
          ),
        ),
        child: TransitionNavContent(
          onComplete: () {},
          animate: false,
        ),
      );
    }

    return const GradientCard(child: SizedBox.expand());
  }
}
