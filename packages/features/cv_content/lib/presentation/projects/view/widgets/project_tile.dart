import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/analytics/analytics_service.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

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

          return Container(
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.06 * progress),
            ),
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
                          ),
                        ),
                      ),
                      if (project case PersonalProject(:final githubUrl?)
                          when githubUrl.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Tooltip(
                            message: AppLocalizations.of(context).gitHub,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () => unawaited(
                                  launchUrl(Uri.parse(githubUrl)),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.github,
                                  size: 18,
                                  color: accent,
                                ),
                              ),
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
                        color: ColorName.textSecondary,
                      ),
                    ),
                  ],
                  if (project.description != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      project.description!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: ColorName.textSecondary,
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
                              decoration: const BoxDecoration(
                                color: ColorName.surfaceLight,
                              ),
                              child: Text(
                                tech,
                                style: textTheme.labelSmall?.copyWith(
                                  color: ColorName.textSecondary,
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
