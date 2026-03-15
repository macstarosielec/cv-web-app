import 'dart:async';

import 'package:cv_content/presentation/home/view/widgets/profile_card_content.dart';
import 'package:cv_content/presentation/models/detail_panel_type.dart';
import 'package:cv_content/presentation/widgets/navigation_chips_row.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/widgets/gradient_card.dart';
import 'package:shared/widgets/stagger_item.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    required this.profile,
    required this.selectedPanels,
    required this.onChipSelected,
    this.animate = false,
    super.key,
  });

  final Profile profile;
  final Set<DetailPanelType> selectedPanels;
  final ValueChanged<DetailPanelType> onChipSelected;
  final bool animate;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _chipsController;
  late final Animation<double> _chipsAnimation;

  @override
  void initState() {
    super.initState();
    _chipsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      value: widget.animate ? 0 : 1,
    );
    _chipsAnimation = CurvedAnimation(
      parent: _chipsController,
      curve: Curves.easeOutCubic,
    );

    if (widget.animate) {
      unawaited(_animateChips());
    }
  }

  Future<void> _animateChips() async {
    // Wait for the 5 content items to stagger (5 * 100ms = 500ms),
    // then add one more delay for the chips
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (mounted) unawaited(_chipsController.forward());
  }

  @override
  void dispose() {
    _chipsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GradientCard(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfileCardContent(
                profile: widget.profile,
                animate: widget.animate,
              ),
              const SizedBox(height: 32),
              StaggerItem(
                animation: _chipsAnimation,
                child: NavigationChipsRow(
                  selectedPanels: widget.selectedPanels,
                  onChipSelected: widget.onChipSelected,
                ),
              ),
            ],
          ),
        ),
      );
}
