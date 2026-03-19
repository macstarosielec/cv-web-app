import 'package:admin_app/app/widgets/auth_card_content.dart';
import 'package:admin_app/app/widgets/auth_phase_indicator.dart';
import 'package:auth/presentation/login/view/widgets/login_card.dart';
import 'package:flutter/material.dart';
import 'package:shared/widgets/gradient_card.dart';

class AuthTransition extends StatelessWidget {
  const AuthTransition({
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

  static const double _margin = AuthPhaseIndicator.margin;
  static const double _navCardWidth = AuthPhaseIndicator.navCardWidth;
  static const double _loginCardWidth = LoginCard.cardWidth;
  static const double _loginCardHeight = LoginCard.cardHeight;

  bool get _isContentCardVisible =>
      phase == AuthPhase.revealContent || phase == AuthPhase.hideContent;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            final loginLeft = (screenWidth - _loginCardWidth) / 2;
            final loginTop = (screenHeight - _loginCardHeight) / 2;
            final navHeight = screenHeight - _margin * 2;

            const contentLeft = _margin + _navCardWidth + 16;
            final contentWidth = screenWidth - contentLeft - _margin;

            return Stack(
              children: [
                AnimatedBuilder(
                  animation: morphAnimation,
                  builder: (context, _) {
                    final t = morphAnimation.value;

                    return Positioned(
                      left: _lerp(loginLeft, _margin, t),
                      top: _lerp(loginTop, _margin, t),
                      width: _lerp(_loginCardWidth, _navCardWidth, t),
                      height: _lerp(_loginCardHeight, navHeight, t),
                      child: AuthCardContent(
                        phase: phase,
                        fadeAnimation: fadeAnimation,
                        navFadeAnimation: navFadeAnimation,
                        onStaggerComplete: onStaggerComplete,
                      ),
                    );
                  },
                ),
                if (_isContentCardVisible)
                  AnimatedBuilder(
                    animation: contentRevealAnimation,
                    builder: (context, _) {
                      final t = contentRevealAnimation.value;

                      return Positioned(
                        left: contentLeft + (1 - t) * contentWidth,
                        top: _margin,
                        width: contentWidth,
                        height: screenHeight - _margin * 2,
                        child: Opacity(
                          opacity: t,
                          child: const GradientCard(
                            seed: 42,
                            child: SizedBox.expand(),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      );

  double _lerp(double a, double b, double t) => a + (b - a) * t;
}
