import 'package:admin_app/app/widgets/auth_transition.dart';
import 'package:admin_content/admin_content.dart';
import 'package:auth/auth.dart';
import 'package:auth/presentation/login/view/widgets/login_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthPhase {
  login,
  fadeOutContent,
  morphCard,
  staggerNav,
  revealContent,
  dashboard,
  hideContent,
  unstaggerNav,
  unmorphCard,
  fadeInContent,
}

class AuthPhaseIndicator extends StatelessWidget {
  const AuthPhaseIndicator({
    required this.phase,
    required this.fadeAnimation,
    required this.morphAnimation,
    required this.contentRevealAnimation,
    required this.navFadeAnimation,
    required this.onStaggerComplete,
    super.key,
  });

  final AuthPhase phase;
  final Animation<double> fadeAnimation;
  final Animation<double> morphAnimation;
  final Animation<double> contentRevealAnimation;
  final Animation<double> navFadeAnimation;
  final VoidCallback onStaggerComplete;

  static const margin = 24.0;
  static const navCardWidth = 250.0;
  static const double loginCardWidth = LoginCard.cardWidth;
  static const double loginCardHeight = LoginCard.cardHeight;

  @override
  Widget build(BuildContext context) => switch (phase) {
        AuthPhase.login => const LoginView(),
        AuthPhase.dashboard => DashboardPage(
            onSignOut: () => context.read<AuthCubit>().signOut(),
          ),
        _ => AuthTransition(
            phase: phase,
            fadeAnimation: fadeAnimation,
            morphAnimation: morphAnimation,
            contentRevealAnimation: contentRevealAnimation,
            onStaggerComplete: onStaggerComplete,
            navFadeAnimation: navFadeAnimation,
          ),
      };
}
