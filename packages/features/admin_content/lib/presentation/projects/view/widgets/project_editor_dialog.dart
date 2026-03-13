import 'dart:async';

import 'package:admin_content/presentation/projects/cubit/admin_projects_cubit.dart';
import 'package:admin_content/presentation/widgets/form_section.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/gen/colors.gen.dart';

class ProjectEditorDialog extends StatefulWidget {
  const ProjectEditorDialog({this.project, super.key});

  final Project? project;

  static Future<void> show(
    BuildContext context, {
    required AdminProjectsCubit cubit,
    Project? project,
  }) =>
      showDialog<void>(
        context: context,
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: ProjectEditorDialog(project: project),
        ),
      );

  @override
  State<ProjectEditorDialog> createState() => _ProjectEditorDialogState();
}

class _ProjectEditorDialogState extends State<ProjectEditorDialog> {
  late bool _isCommercial;
  late final TextEditingController _id;
  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _company;
  late final TextEditingController _role;
  late final TextEditingController _githubUrl;
  late List<String> _techStack;
  late List<String> _responsibilities;
  final _techController = TextEditingController();
  final _responsibilityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final p = widget.project;
    _isCommercial = p is CommercialProject || p == null;

    if (p is CommercialProject) {
      _id = TextEditingController(text: p.id);
      _name = TextEditingController(text: p.name);
      _description = TextEditingController(text: p.description ?? '');
      _company = TextEditingController(text: p.company);
      _role = TextEditingController(text: p.role);
      _githubUrl = TextEditingController();
      _techStack = List.from(p.techStack);
      _responsibilities = List.from(p.responsibilities);
    } else if (p is PersonalProject) {
      _isCommercial = false;
      _id = TextEditingController(text: p.id);
      _name = TextEditingController(text: p.name);
      _description = TextEditingController(text: p.description ?? '');
      _company = TextEditingController();
      _role = TextEditingController();
      _githubUrl = TextEditingController(text: p.githubUrl ?? '');
      _techStack = List.from(p.techStack);
      _responsibilities = [];
    } else {
      _id = TextEditingController(
        text: DateTime.now().millisecondsSinceEpoch.toString(),
      );
      _name = TextEditingController();
      _description = TextEditingController();
      _company = TextEditingController();
      _role = TextEditingController();
      _githubUrl = TextEditingController();
      _techStack = [];
      _responsibilities = [];
    }
  }

  @override
  void dispose() {
    _id.dispose();
    _name.dispose();
    _description.dispose();
    _company.dispose();
    _role.dispose();
    _githubUrl.dispose();
    _techController.dispose();
    _responsibilityController.dispose();
    super.dispose();
  }

  void _save() {
    final cubit = context.read<AdminProjectsCubit>();
    final isNew = widget.project == null;
    final project = _isCommercial
        ? Project.commercial(
            id: _id.text.trim(),
            name: _name.text.trim(),
            company: _company.text.trim(),
            role: _role.text.trim(),
            description: _description.text.trim().isEmpty
                ? null
                : _description.text.trim(),
            techStack: _techStack,
            responsibilities: _responsibilities,
          )
        : Project.personal(
            id: _id.text.trim(),
            name: _name.text.trim(),
            description: _description.text.trim().isEmpty
                ? null
                : _description.text.trim(),
            techStack: _techStack,
            githubUrl: _githubUrl.text.trim().isEmpty
                ? null
                : _githubUrl.text.trim(),
          );

    if (isNew) {
      unawaited(cubit.addProject(project));
    } else {
      unawaited(cubit.updateProject(project));
    }
    Navigator.of(context).pop();
  }

  void _addTech() {
    final value = _techController.text.trim();
    if (value.isEmpty) return;
    setState(() => _techStack = [..._techStack, value]);
    _techController.clear();
  }

  void _removeTech(int index) =>
      setState(() => _techStack = List.from(_techStack)..removeAt(index));

  void _addResponsibility() {
    final value = _responsibilityController.text.trim();
    if (value.isEmpty) return;
    setState(() => _responsibilities = [..._responsibilities, value]);
    _responsibilityController.clear();
  }

  void _removeResponsibility(int index) => setState(
        () => _responsibilities = List.from(_responsibilities)..removeAt(index),
      );

  @override
  Widget build(BuildContext context) => Dialog(
        backgroundColor: ColorName.surface,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.project == null ? 'Add Project' : 'Edit Project',
                  style: const TextStyle(
                    color: ColorName.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      'Type:',
                      style: TextStyle(color: ColorName.textSecondary),
                    ),
                    const SizedBox(width: 12),
                    ChoiceChip(
                      label: const Text('Commercial'),
                      selected: _isCommercial,
                      onSelected: (_) => setState(() => _isCommercial = true),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Personal'),
                      selected: !_isCommercial,
                      onSelected: (_) => setState(() => _isCommercial = false),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _field(_name, 'Name'),
                        const SizedBox(height: 12),
                        _field(_description, 'Description (optional)',
                            maxLines: 3),
                        if (_isCommercial) ...[
                          const SizedBox(height: 12),
                          _field(_company, 'Company'),
                          const SizedBox(height: 12),
                          _field(_role, 'Role'),
                        ] else ...[
                          const SizedBox(height: 12),
                          _field(_githubUrl, 'GitHub URL (optional)'),
                        ],
                        const SizedBox(height: 16),
                        FormSection(
                          title: 'TECH STACK',
                          child: _listEditor(
                            items: _techStack,
                            controller: _techController,
                            hint: 'Add technology',
                            onAdd: _addTech,
                            onRemove: _removeTech,
                          ),
                        ),
                        if (_isCommercial)
                          FormSection(
                            title: 'RESPONSIBILITIES',
                            child: _listEditor(
                              items: _responsibilities,
                              controller: _responsibilityController,
                              hint: 'Add responsibility',
                              onAdd: _addResponsibility,
                              onRemove: _removeResponsibility,
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
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: ColorName.textSecondary),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: _save,
                      style: FilledButton.styleFrom(
                        backgroundColor: ColorName.accent,
                      ),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget _field(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
  }) =>
      TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(labelText: label, isDense: true),
        style: const TextStyle(color: ColorName.textPrimary),
      );

  Widget _listEditor({
    required List<String> items,
    required TextEditingController controller,
    required String hint,
    required VoidCallback onAdd,
    required ValueChanged<int> onRemove,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < items.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      items[i],
                      style: const TextStyle(color: ColorName.textPrimary),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 16,
                      color: ColorName.textMuted,
                    ),
                    onPressed: () => onRemove(i),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration:
                      InputDecoration(hintText: hint, isDense: true),
                  style: const TextStyle(color: ColorName.textPrimary),
                  onSubmitted: (_) => onAdd(),
                ),
              ),
              const SizedBox(width: 8),
              TextButton(onPressed: onAdd, child: const Text('Add')),
            ],
          ),
        ],
      );
}
