import 'dart:async';

import 'package:admin_app/app/widgets/stagger_item.dart';
import 'package:admin_content/presentation/dashboard/admin_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/widgets/action_chip.dart' as shared;

class TransitionNavContent extends StatefulWidget {
  const TransitionNavContent({
    required this.onComplete,
    this.animate = true,
    super.key,
  });

  final VoidCallback onComplete;
  final bool animate;

  @override
  State<TransitionNavContent> createState() => _TransitionNavContentState();
}

class _TransitionNavContentState extends State<TransitionNavContent>
    with TickerProviderStateMixin {
  static const _itemCount = 5;
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _itemCount,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
        value: widget.animate ? 0 : 1,
      ),
    );
    _animations = _controllers
        .map(
          (c) => CurvedAnimation(
            parent: c,
            curve: Curves.easeOutCubic,
          ),
        )
        .toList();

    if (widget.animate) unawaited(_staggerAnimations());
  }

  Future<void> _staggerAnimations() async {
    for (var i = 0; i < _controllers.length; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      if (mounted) unawaited(_controllers[i].forward());
    }
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (mounted) widget.onComplete();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String _localizedLabel(AppLocalizations l10n, AdminNavItem item) =>
      switch (item) {
        AdminNavItem.profile => l10n.profile,
        AdminNavItem.projects => l10n.projects,
        AdminNavItem.workExperience => l10n.experience,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StaggerItem(
              animation: _animations[0],
              child: Text(
                l10n.dashboard,
                textAlign: TextAlign.center,
                style:
                    Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: ColorName.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
              ),
            ),
            const SizedBox(height: 32),
            ...AdminNavItem.values.asMap().entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: StaggerItem(
                      animation: _animations[entry.key + 1],
                      child: shared.ActionChip(
                        label: _localizedLabel(l10n, entry.value),
                        icon: entry.value.icon,
                        isSelected: entry.key == 0,
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
            const Spacer(),
            StaggerItem(
              animation: _animations[4],
              child: shared.ActionChip(
                label: l10n.signOut,
                icon: Icons.logout,
                onTap: () {},
              ),
            ),
          ],
        ),
      );
  }
}
