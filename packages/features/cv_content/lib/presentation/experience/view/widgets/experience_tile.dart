import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/analytics/analytics_service.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';

class ExperienceTile extends StatefulWidget {
  const ExperienceTile({required this.experience, super.key});

  final WorkExperience experience;

  @override
  State<ExperienceTile> createState() => _ExperienceTileState();
}

class _ExperienceTileState extends State<ExperienceTile> {
  bool _isHovered = false;

  static List<String> _months(AppLocalizations l10n) => [
    l10n.monthJan, l10n.monthFeb, l10n.monthMar, l10n.monthApr,
    l10n.monthMay, l10n.monthJun, l10n.monthJul, l10n.monthAug,
    l10n.monthSep, l10n.monthOct, l10n.monthNov, l10n.monthDec,
  ];

  String _formatDate(AppLocalizations l10n, DateTime date) =>
      '${_months(l10n)[date.month - 1]} ${date.year}';

  String _dateRange(AppLocalizations l10n) {
    final start = _formatDate(l10n, widget.experience.startDate);
    final end = widget.experience.isCurrent
        ? l10n.present
        : _formatDate(l10n, widget.experience.endDate!);
    return '$start - $end';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        unawaited(
          GetIt.instance<AnalyticsService>().logExperienceHovered(
            title: widget.experience.title,
            company: widget.experience.company,
          ),
        );
      },
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.all(AppDimensions.paddingSmall),
        decoration: BoxDecoration(
          color: _isHovered
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.06)
              : Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.experience.title,
                    style: textTheme.titleMedium?.copyWith(
                      color: ColorName.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (widget.experience.isCurrent)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.15),
                    ),
                    child: Text(
                      l10n.current,
                      style: textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.experience.company,
              style: textTheme.bodyMedium?.copyWith(
                color: ColorName.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              _dateRange(l10n),
              style: textTheme.bodySmall?.copyWith(
                color: ColorName.textMuted,
              ),
            ),
            if (widget.experience.responsibilities.isNotEmpty) ...[
              const SizedBox(height: AppDimensions.spacingSmall),
              ...widget.experience.responsibilities.map(
                (r) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\u2022  ',
                        style: textTheme.bodySmall?.copyWith(
                          color: ColorName.textMuted,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          r,
                          style: textTheme.bodySmall?.copyWith(
                            color: ColorName.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
