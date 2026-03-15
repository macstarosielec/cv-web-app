import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/analytics/analytics_service.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';

class ProjectTile extends StatefulWidget {
  const ProjectTile({required this.project, super.key});

  final Project project;

  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _hoverController;
  late final Animation<double> _hoverAnimation;

  static const _scale = 1.03;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _hoverAnimation = CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  List<Shadow> _textGlow(Color accent, double progress) => [
        Shadow(
          color: accent.withValues(alpha: 0.9 * progress),
          blurRadius: 20 * progress,
        ),
        Shadow(
          color: accent.withValues(alpha: 0.6 * progress),
          blurRadius: 40 * progress,
        ),
      ];

  List<BoxShadow> _chipGlow(Color accent, double progress) => [
        BoxShadow(
          color: accent.withValues(alpha: 0.35 * progress),
          blurRadius: 10 * progress,
        ),
        BoxShadow(
          color: accent.withValues(alpha: 0.2 * progress),
          blurRadius: 20 * progress,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final accent = Theme.of(context).colorScheme.primary;
    final project = widget.project;

    return RepaintBoundary(
      child: MouseRegion(
      onEnter: (_) {
        unawaited(_hoverController.forward());
        unawaited(
          GetIt.instance<AnalyticsService>().logProjectHovered(
            widget.project.name,
          ),
        );
      },
      onExit: (_) => unawaited(_hoverController.reverse()),
      child: AnimatedBuilder(
        animation: _hoverAnimation,
        builder: (context, _) {
          final progress = _hoverAnimation.value;
          final scale = 1.0 + (_scale - 1.0) * progress;
          final textShadows = _textGlow(accent, progress);
          final chipShadows = _chipGlow(accent, progress);

          return Container(
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.all(20),
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          project.name,
                          style: textTheme.titleMedium?.copyWith(
                            color: ColorName.textPrimary,
                            fontWeight: FontWeight.w600,
                            shadows: textShadows,
                          ),
                        ),
                      ),
                      if (project case PersonalProject(:final githubUrl?)
                          when githubUrl.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Tooltip(
                            message: AppLocalizations.of(context).gitHub,
                            child: const Icon(
                              Icons.code,
                              size: 18,
                              color: ColorName.textMuted,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (project
                      case CommercialProject(
                        :final company,
                        :final role,
                      )) ...[
                    const SizedBox(height: 4),
                    Text(
                      '$company \u2022 $role',
                      style: textTheme.bodySmall?.copyWith(
                        color: ColorName.textMuted,
                        shadows: textShadows,
                      ),
                    ),
                  ],
                  if (project.description != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      project.description!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: ColorName.textSecondary,
                        shadows: textShadows,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (project.techStack.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: project.techStack
                          .map(
                            (tech) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: ColorName.surfaceLight,
                                boxShadow: chipShadows,
                              ),
                              child: Text(
                                tech,
                                style: textTheme.labelSmall?.copyWith(
                                  color: ColorName.textMuted,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    ),
    );
  }
}
