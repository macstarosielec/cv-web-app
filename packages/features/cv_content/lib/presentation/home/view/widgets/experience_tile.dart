import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class ExperienceTile extends StatefulWidget {
  const ExperienceTile({required this.experience, super.key});

  final WorkExperience experience;

  @override
  State<ExperienceTile> createState() => _ExperienceTileState();
}

class _ExperienceTileState extends State<ExperienceTile> {
  bool _isHovered = false;

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String _formatDate(DateTime date) =>
      '${_months[date.month - 1]} ${date.year}';

  String get _dateRange {
    final start = _formatDate(widget.experience.startDate);
    final end = widget.experience.isCurrent
        ? 'Present'
        : _formatDate(widget.experience.endDate!);
    return '$start - $end';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                      color: ColorName.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Current',
                      style: textTheme.labelSmall?.copyWith(
                        color: ColorName.accent,
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
              _dateRange,
              style: textTheme.bodySmall?.copyWith(
                color: ColorName.textMuted,
              ),
            ),
            if (widget.experience.responsibilities.isNotEmpty) ...[
              const SizedBox(height: 12),
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
