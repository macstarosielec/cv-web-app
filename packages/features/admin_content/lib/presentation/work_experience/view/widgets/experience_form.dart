import 'dart:async';

import 'package:admin_content/presentation/projects/view/widgets/responsibilities_editor.dart';
import 'package:admin_content/presentation/widgets/admin_input_decoration.dart';
import 'package:admin_content/presentation/widgets/form_section.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/widgets/action_chip.dart' as shared;

class ExperienceForm extends StatefulWidget {
  const ExperienceForm({
    required this.onSave,
    required this.onDiscard,
    this.workExperience,
    super.key,
  });

  final WorkExperience? workExperience;
  final ValueChanged<WorkExperience> onSave;
  final VoidCallback onDiscard;

  @override
  State<ExperienceForm> createState() => _ExperienceFormState();
}

class _ExperienceFormState extends State<ExperienceForm>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _title;
  late final TextEditingController _company;
  late DateTime _startDate;
  DateTime? _endDate;
  late List<String> _responsibilities;
  late final AnimationController _staggerController;
  bool _isDirty = false;

  bool get _isEditing => widget.workExperience != null;

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    unawaited(_staggerController.forward());

    _title = TextEditingController();
    _company = TextEditingController();
    _startDate = DateTime.now();
    _responsibilities = [];

    _populateFrom(widget.workExperience);

    for (final c in [_title, _company]) {
      c.addListener(_markDirty);
    }
  }

  @override
  void didUpdateWidget(ExperienceForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.workExperience != oldWidget.workExperience) {
      _populateFrom(widget.workExperience);
    }
  }

  void _populateFrom(WorkExperience? we) {
    if (we != null) {
      _title.text = we.title;
      _company.text = we.company;
      setState(() {
        _startDate = we.startDate;
        _endDate = we.endDate;
        _responsibilities = List.from(we.responsibilities);
        _isDirty = true;
      });
    } else {
      _title.clear();
      _company.clear();
      setState(() {
        _startDate = DateTime.now();
        _endDate = null;
        _responsibilities = [];
        _isDirty = false;
      });
    }
  }

  void _markDirty() {
    if (!_isDirty) setState(() => _isDirty = true);
  }

  @override
  void dispose() {
    _staggerController.dispose();
    _title.dispose();
    _company.dispose();
    super.dispose();
  }

  Animation<double> _itemAnimation(int index, int total) {
    final start = (index / (total + 2)).clamp(0.0, 1.0);
    final end = ((index + 2) / (total + 2)).clamp(0.0, 1.0);
    return CurvedAnimation(
      parent: _staggerController,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );
  }

  String get _experienceId =>
      widget.workExperience?.id ??
      DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _startDate = picked);
      _markDirty();
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _endDate = picked);
      _markDirty();
    }
  }

  void _clearEndDate() {
    setState(() => _endDate = null);
    _markDirty();
  }

  void _save() {
    final workExperience = WorkExperience(
      id: _experienceId,
      title: _title.text.trim(),
      company: _company.text.trim(),
      startDate: _startDate,
      endDate: _endDate,
      responsibilities: _responsibilities,
    );
    widget.onSave(workExperience);
  }

  String _formatDate(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const itemCount = 6;
    var index = 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _animated(
            index: index++,
            total: itemCount,
            child: Text(
              _isEditing ? l10n.editExperience : l10n.addExperience,
              style: const TextStyle(
                color: ColorName.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spacingMedium),
          _animated(
            index: index++,
            total: itemCount,
            child: Row(
              children: [
                Expanded(child: _field(_title, l10n.title)),
                const SizedBox(width: AppDimensions.spacingSmall),
                Expanded(child: _field(_company, l10n.company)),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spacingMedium),
          _animated(
            index: index++,
            total: itemCount,
            child: FormSection(
              title: l10n.dates,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        l10n.startDate,
                        style: const TextStyle(
                          color: ColorName.textSecondary,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spacingExtraSmall),
                      TextButton(
                        onPressed: _pickStartDate,
                        child: Text(
                          _formatDate(_startDate),
                          style: const TextStyle(
                            color: ColorName.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        l10n.endDate,
                        style: const TextStyle(
                          color: ColorName.textSecondary,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spacingExtraSmall),
                      TextButton(
                        onPressed: _pickEndDate,
                        child: Text(
                          _endDate != null
                              ? _formatDate(_endDate!)
                              : l10n.present,
                          style: const TextStyle(
                            color: ColorName.textPrimary,
                          ),
                        ),
                      ),
                      if (_endDate != null)
                        GestureDetector(
                          onTap: _clearEndDate,
                          child: const Icon(
                            Icons.close,
                            size: AppDimensions.iconSizeSmall,
                            color: ColorName.textMuted,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _animated(
            index: index++,
            total: itemCount,
            child: FormSection(
              title: l10n.responsibilities,
              child: ResponsibilitiesEditor(
                responsibilities: _responsibilities,
                onChanged: (resps) {
                  setState(() => _responsibilities = resps);
                  _markDirty();
                },
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spacingMedium),
          _animated(
            index: index,
            total: itemCount,
            child: Row(
              children: [
                shared.ActionChip(
                  label: _isEditing ? l10n.edit : l10n.add,
                  icon: _isEditing ? Icons.save_outlined : Icons.add,
                  onTap: _save,
                ),
                if (_isDirty || _isEditing) ...[
                  const SizedBox(width: AppDimensions.spacingExtraSmall),
                  shared.ActionChip(
                    label: l10n.discard,
                    icon: Icons.close,
                    onTap: widget.onDiscard,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _animated({
    required int index,
    required int total,
    required Widget child,
  }) {
    final animation = _itemAnimation(index, total);
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: animation.drive(
          Tween(begin: const Offset(0, 0.1), end: Offset.zero),
        ),
        child: child,
      ),
    );
  }

  Widget _field(TextEditingController controller, String label) => TextField(
        controller: controller,
        decoration: adminInputDecoration(
          context: context,
          label: label,
          isDense: true,
        ),
        style: const TextStyle(color: ColorName.textPrimary),
      );
}
