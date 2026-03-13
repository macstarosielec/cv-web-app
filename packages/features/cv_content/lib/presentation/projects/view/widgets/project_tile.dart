import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';

class ProjectTile extends StatefulWidget {
  const ProjectTile({required this.project, super.key});

  final Project project;

  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isHovered
              ? ColorName.accent.withValues(alpha: 0.06)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
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
                      child: const Icon(
                        Icons.code,
                        size: 18,
                        color: ColorName.textMuted,
                      ),
                    ),
                  ),
              ],
            ),
            if (project case CommercialProject(:final company, :final role)) ...[
              const SizedBox(height: 4),
              Text(
                '$company \u2022 $role',
                style: textTheme.bodySmall?.copyWith(
                  color: ColorName.textMuted,
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
  }
}
