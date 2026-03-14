import 'dart:async';

import 'package:admin_content/presentation/widgets/admin_input_decoration.dart';
import 'package:admin_content/presentation/widgets/form_section.dart';
import 'package:admin_content/presentation/work_experience/cubit/admin_work_experience_cubit.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/widgets/action_chip.dart' as shared;

class ExperienceEditorDialog extends StatefulWidget {
  const ExperienceEditorDialog({this.workExperience, super.key});

  final WorkExperience? workExperience;

  static Future<void> show(
    BuildContext context, {
    required AdminWorkExperienceCubit cubit,
    WorkExperience? workExperience,
  }) =>
      showDialog<void>(
        context: context,
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: ExperienceEditorDialog(workExperience: workExperience),
        ),
      );

  @override
  State<ExperienceEditorDialog> createState() =>
      _ExperienceEditorDialogState();
}

class _ExperienceEditorDialogState extends State<ExperienceEditorDialog> {
  late final TextEditingController _id;
  late final TextEditingController _title;
  late final TextEditingController _company;
  late DateTime _startDate;
  DateTime? _endDate;
  late List<String> _responsibilities;
  final _responsibilityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final we = widget.workExperience;
    _id = TextEditingController(
      text: we?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
    );
    _title = TextEditingController(text: we?.title ?? '');
    _company = TextEditingController(text: we?.company ?? '');
    _startDate = we?.startDate ?? DateTime.now();
    _endDate = we?.endDate;
    _responsibilities = List.from(we?.responsibilities ?? []);
  }

  @override
  void dispose() {
    _id.dispose();
    _title.dispose();
    _company.dispose();
    _responsibilityController.dispose();
    super.dispose();
  }

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _startDate = picked);
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _endDate = picked);
  }

  void _clearEndDate() => setState(() => _endDate = null);

  void _addResponsibility() {
    final value = _responsibilityController.text.trim();
    if (value.isEmpty) return;
    setState(() => _responsibilities = [..._responsibilities, value]);
    _responsibilityController.clear();
  }

  void _removeResponsibility(int index) => setState(
        () =>
            _responsibilities = List.from(_responsibilities)..removeAt(index),
      );

  void _save() {
    final cubit = context.read<AdminWorkExperienceCubit>();
    final isNew = widget.workExperience == null;
    final workExperience = WorkExperience(
      id: _id.text.trim(),
      title: _title.text.trim(),
      company: _company.text.trim(),
      startDate: _startDate,
      endDate: _endDate,
      responsibilities: _responsibilities,
    );
    if (isNew) {
      unawaited(cubit.addWorkExperience(workExperience));
    } else {
      unawaited(cubit.updateWorkExperience(workExperience));
    }
    Navigator.of(context).pop();
  }

  String _formatDate(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) => Dialog(
        shape: const RoundedRectangleBorder(),
        backgroundColor: ColorName.surface,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.workExperience == null
                      ? 'Add Experience'
                      : 'Edit Experience',
                  style: const TextStyle(
                    color: ColorName.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _field(_title, 'Title'),
                        const SizedBox(height: 12),
                        _field(_company, 'Company'),
                        const SizedBox(height: 16),
                        FormSection(
                          title: 'DATES',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Start:',
                                    style: TextStyle(
                                      color: ColorName.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
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
                                  const Text(
                                    'End:',
                                    style: TextStyle(
                                      color: ColorName.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    onPressed: _pickEndDate,
                                    child: Text(
                                      _endDate != null
                                          ? _formatDate(_endDate!)
                                          : 'Present',
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
                                        size: 14,
                                        color: ColorName.textMuted,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        FormSection(
                          title: 'RESPONSIBILITIES',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i = 0;
                                  i < _responsibilities.length;
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _responsibilities[i],
                                          style: const TextStyle(
                                            color: ColorName.textPrimary,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            _removeResponsibility(i),
                                        child: const Icon(
                                          Icons.close,
                                          size: 14,
                                          color: ColorName.textMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _responsibilityController,
                                      decoration: adminInputDecoration(context: context, 
                                        label: 'Add responsibility',
                                        isDense: true,
                                      ),
                                      style: const TextStyle(
                                        color: ColorName.textPrimary,
                                      ),
                                      onSubmitted: (_) =>
                                          _addResponsibility(),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  shared.ActionChip(
                                    label: 'Add',
                                    icon: Icons.add,
                                    onTap: _addResponsibility,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    shared.ActionChip(
                      label: 'Cancel',
                      icon: Icons.close,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8),
                    shared.ActionChip(
                      label: 'Save',
                      icon: Icons.save_outlined,
                      onTap: _save,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget _field(TextEditingController controller, String label) => TextField(
        controller: controller,
        decoration: adminInputDecoration(context: context, label: label, isDense: true),
        style: const TextStyle(color: ColorName.textPrimary),
      );
}
