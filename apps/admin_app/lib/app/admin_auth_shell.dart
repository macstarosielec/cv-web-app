import 'dart:async';

import 'package:admin_app/app/widgets/login_card_placeholder.dart';
import 'package:admin_app/app/widgets/transition_nav_content.dart';
import 'package:admin_content/admin_content.dart';
import 'package:auth/auth.dart';
import 'package:auth/presentation/login/view/widgets/login_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/widgets/dot_loader.dart';
import 'package:shared/widgets/gradient_card.dart';

enum _Phase {
  initializing,
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

class AdminAuthShell extends StatefulWidget {
  const AdminAuthShell({super.key});

  @override
  State<AdminAuthShell> createState() => _AdminAuthShellState();
}

class _AdminAuthShellState extends State<AdminAuthShell>
    with TickerProviderStateMixin {
  _Phase _phase = _Phase.login;

  static const _margin = 24.0;
  static const _navCardWidth = 250.0;
  static const _loginCardWidth = LoginCard.cardWidth;
  static const _loginCardHeight = LoginCard.cardHeight;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  late final AnimationController _morphController;
  late final Animation<double> _morphAnimation;

  late final AnimationController _contentRevealController;
  late final Animation<double> _contentRevealAnimation;

  late final AnimationController _navFadeController;
  late final Animation<double> _navFadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _morphController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _morphAnimation = CurvedAnimation(
      parent: _morphController,
      curve: Curves.easeInOutCubic,
    );

    _contentRevealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _contentRevealAnimation = CurvedAnimation(
      parent: _contentRevealController,
      curve: Curves.easeOutCubic,
    );

    _navFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _navFadeAnimation = CurvedAnimation(
      parent: _navFadeController,
      curve: Curves.easeOut,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_phase == _Phase.initializing) {
      _onAuthStateChanged(context.read<AuthCubit>().state);
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _morphController.dispose();
    _contentRevealController.dispose();
    _navFadeController.dispose();
    super.dispose();
  }

  void _onAuthStateChanged(AuthState state) {
    state.when(
      initial: () {},
      loading: () {},
      authenticated: () {
        if (_phase == _Phase.initializing) {
          // Already logged in on load — skip to dashboard
          setState(() => _phase = _Phase.dashboard);
        } else if (_phase == _Phase.login) {
          unawaited(_startLoginTransition());
        }
      },
      unauthenticated: () {
        if (_phase == _Phase.initializing || _phase == _Phase.login) {
          setState(() => _phase = _Phase.login);
        } else if (_phase == _Phase.dashboard) {
          unawaited(_startLogoutTransition());
        }
      },
      error: (_) {
        if (_phase == _Phase.initializing) {
          setState(() => _phase = _Phase.login);
        }
      },
    );
  }

  Future<void> _startLoginTransition() async {
    setState(() => _phase = _Phase.fadeOutContent);
    await _fadeController.forward();
    if (!mounted) return;

    setState(() => _phase = _Phase.morphCard);
    await _morphController.forward();
    if (!mounted) return;

    setState(() => _phase = _Phase.staggerNav);
  }

  void _onStaggerComplete() {
    if (!mounted) return;
    _navFadeController.value = 1;

    setState(() => _phase = _Phase.revealContent);
    unawaited(
      _contentRevealController.forward().then((_) {
        if (mounted) setState(() => _phase = _Phase.dashboard);
      }),
    );
  }

  Future<void> _startLogoutTransition() async {
    _contentRevealController.value = 1;
    _navFadeController.value = 1;
    _morphController.value = 1;
    _fadeController.value = 1;

    setState(() => _phase = _Phase.hideContent);
    await _contentRevealController.reverse();
    if (!mounted) return;

    setState(() => _phase = _Phase.unstaggerNav);
    await _navFadeController.reverse();
    if (!mounted) return;

    setState(() => _phase = _Phase.unmorphCard);
    await _morphController.reverse();
    if (!mounted) return;

    setState(() => _phase = _Phase.fadeInContent);
    await _fadeController.reverse();
    if (!mounted) return;

    setState(() => _phase = _Phase.login);
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<AuthCubit, AuthState>(
        listener: (context, state) => _onAuthStateChanged(state),
        child: _buildPhase(context),
      );

  Widget _buildPhase(BuildContext context) => switch (_phase) {
        _Phase.initializing => Scaffold(
            backgroundColor: Colors.transparent,
            body: const Center(
              child: DotLoader(),
            ),
          ),
        _Phase.login => const LoginView(),
        _Phase.dashboard => DashboardPage(
            onSignOut: () => context.read<AuthCubit>().signOut(),
          ),
        _ => _buildTransition(context),
      };

  Widget _buildTransition(BuildContext context) => Scaffold(
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
                  animation: _morphAnimation,
                  builder: (context, _) {
                    final t = _morphAnimation.value;

                    return Positioned(
                      left: _lerp(loginLeft, _margin, t),
                      top: _lerp(loginTop, _margin, t),
                      width: _lerp(_loginCardWidth, _navCardWidth, t),
                      height: _lerp(_loginCardHeight, navHeight, t),
                      child: _buildCardContent(),
                    );
                  },
                ),
                if (_isContentCardVisible)
                  AnimatedBuilder(
                    animation: _contentRevealAnimation,
                    builder: (context, _) {
                      final t = _contentRevealAnimation.value;

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

  bool get _isContentCardVisible =>
      _phase == _Phase.revealContent || _phase == _Phase.hideContent;

  Widget _buildCardContent() {
    if (_phase == _Phase.fadeOutContent ||
        _phase == _Phase.fadeInContent) {
      return AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) => GradientCard(
          child: Opacity(
            opacity: 1 - _fadeAnimation.value,
            child: child,
          ),
        ),
        child: const LoginCardPlaceholder(),
      );
    }

    if (_phase == _Phase.morphCard || _phase == _Phase.unmorphCard) {
      return const GradientCard(child: SizedBox.expand());
    }

    if (_phase == _Phase.staggerNav ||
        _phase == _Phase.revealContent) {
      return GradientCard(
        child: TransitionNavContent(onComplete: _onStaggerComplete),
      );
    }

    if (_phase == _Phase.unstaggerNav ||
        _phase == _Phase.hideContent) {
      return AnimatedBuilder(
        animation: _navFadeAnimation,
        builder: (context, child) => GradientCard(
          child: Opacity(
            opacity: _navFadeAnimation.value,
            child: Transform.translate(
              offset: Offset(0, 8 * (1 - _navFadeAnimation.value)),
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

  double _lerp(double a, double b, double t) => a + (b - a) * t;
}
