import 'dart:async';

import 'package:admin_app/app/widgets/auth_phase_indicator.dart';
import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminAuthShell extends StatefulWidget {
  const AdminAuthShell({super.key});

  @override
  State<AdminAuthShell> createState() => _AdminAuthShellState();
}

class _AdminAuthShellState extends State<AdminAuthShell>
    with TickerProviderStateMixin {
  AuthPhase _phase = AuthPhase.login;

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
        if (_phase == AuthPhase.login) {
          unawaited(_startLoginTransition());
        }
      },
      unauthenticated: () {
        if (_phase == AuthPhase.login) {
          setState(() => _phase = AuthPhase.login);
        } else if (_phase == AuthPhase.dashboard) {
          unawaited(_startLogoutTransition());
        }
      },
      error: (_) {},
    );
  }

  Future<void> _startLoginTransition() async {
    setState(() => _phase = AuthPhase.fadeOutContent);
    await _fadeController.forward();
    if (!mounted) return;

    setState(() => _phase = AuthPhase.morphCard);
    await _morphController.forward();
    if (!mounted) return;

    setState(() => _phase = AuthPhase.staggerNav);
  }

  void _onStaggerComplete() {
    if (!mounted) return;
    _navFadeController.value = 1;

    setState(() => _phase = AuthPhase.revealContent);
    unawaited(
      _contentRevealController.forward().then((_) {
        if (mounted) setState(() => _phase = AuthPhase.dashboard);
      }),
    );
  }

  Future<void> _startLogoutTransition() async {
    _contentRevealController.value = 1;
    _navFadeController.value = 1;
    _morphController.value = 1;
    _fadeController.value = 1;

    setState(() => _phase = AuthPhase.hideContent);
    await _contentRevealController.reverse();
    if (!mounted) return;

    setState(() => _phase = AuthPhase.unstaggerNav);
    await _navFadeController.reverse();
    if (!mounted) return;

    setState(() => _phase = AuthPhase.unmorphCard);
    await _morphController.reverse();
    if (!mounted) return;

    setState(() => _phase = AuthPhase.fadeInContent);
    await _fadeController.reverse();
    if (!mounted) return;

    setState(() => _phase = AuthPhase.login);
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<AuthCubit, AuthState>(
        listener: (context, state) => _onAuthStateChanged(state),
        child: AuthPhaseIndicator(
          phase: _phase,
          fadeAnimation: _fadeAnimation,
          morphAnimation: _morphAnimation,
          contentRevealAnimation: _contentRevealAnimation,
          navFadeAnimation: _navFadeAnimation,
          onStaggerComplete: _onStaggerComplete,
        ),
      );
}
