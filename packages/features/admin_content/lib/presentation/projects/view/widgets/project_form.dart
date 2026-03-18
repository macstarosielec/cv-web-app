import 'dart:async';

import 'package:admin_content/presentation/projects/view/widgets/responsibilities_editor.dart';
import 'package:admin_content/presentation/projects/view/widgets/tech_stack_editor.dart';
import 'package:admin_content/presentation/widgets/admin_form_field.dart';
import 'package:admin_content/presentation/widgets/animated_form_item.dart';
import 'package:admin_content/presentation/widgets/form_section.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/widgets/action_chip.dart' as shared;

class ProjectForm extends StatefulWidget {
  const ProjectForm({
    required this.onSave,
    required this.onDiscard,
    this.project,
    super.key,
  });

  final Project? project;
  final ValueChanged<Project> onSave;
  final VoidCallback onDiscard;

  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm>
    with SingleTickerProviderStateMixin {
  late bool _isCommercial;
  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _company;
  late final TextEditingController _role;
  late final TextEditingController _githubUrl;
  late List<String> _techStack;
  late List<String> _responsibilities;
  late final AnimationController _staggerController;
  bool _isDirty = false;

  bool get _isEditing => widget.project != null;

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    unawaited(_staggerController.forward());

    _name = TextEditingController();
    _description = TextEditingController();
    _company = TextEditingController();
    _role = TextEditingController();
    _githubUrl = TextEditingController();
    _techStack = [];
    _responsibilities = [];
    _isCommercial = true;

    _populateFrom(widget.project);

    for (final c in [_name, _description, _company, _role, _githubUrl]) {
      c.addListener(_markDirty);
    }
  }

  @override
  void didUpdateWidget(ProjectForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.project != oldWidget.project) {
      _populateFrom(widget.project);
    }
  }

  void _populateFrom(Project? p) {
    if (p is CommercialProject) {
      _name.text = p.name;
      _description.text = p.description ?? '';
      _company.text = p.company;
      _role.text = p.role;
      _githubUrl.text = '';
      setState(() {
        _isCommercial = true;
        _techStack = List.from(p.techStack);
        _responsibilities = List.from(p.responsibilities);
        _isDirty = true;
      });
    } else if (p is PersonalProject) {
      _name.text = p.name;
      _description.text = p.description ?? '';
      _company.text = '';
      _role.text = '';
      _githubUrl.text = p.githubUrl ?? '';
      setState(() {
        _isCommercial = false;
        _techStack = List.from(p.techStack);
        _responsibilities = [];
        _isDirty = true;
      });
    } else {
      _name.clear();
      _description.clear();
      _company.clear();
      _role.clear();
      _githubUrl.clear();
      setState(() {
        _isCommercial = true;
        _techStack = [];
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
    _name.dispose();
    _description.dispose();
    _company.dispose();
    _role.dispose();
    _githubUrl.dispose();
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

  String get _projectId {
    final p = widget.project;
    if (p is CommercialProject) return p.id;
    if (p is PersonalProject) return p.id;
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  void _save() {
    final sortOrder = widget.project?.sortOrder ?? 0;
    final project = _isCommercial
        ? Project.commercial(
            id: _projectId,
            name: _name.text.trim(),
            company: _company.text.trim(),
            role: _role.text.trim(),
            description: _description.text.trim().isEmpty
                ? null
                : _description.text.trim(),
            techStack: _techStack,
            responsibilities: _responsibilities,
            sortOrder: sortOrder,
          )
        : Project.personal(
            id: _projectId,
            name: _name.text.trim(),
            description: _description.text.trim().isEmpty
                ? null
                : _description.text.trim(),
            techStack: _techStack,
            githubUrl: _githubUrl.text.trim().isEmpty
                ? null
                : _githubUrl.text.trim(),
            sortOrder: sortOrder,
          );
    widget.onSave(project);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const itemCount = 7;
    var index = 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedFormItem(
            animation: _itemAnimation(index++, itemCount),
            child: Text(
              _isEditing ? l10n.editProject : l10n.addProject,
              style: const TextStyle(
                color: ColorName.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spacingMedium),
          AnimatedFormItem(
            animation: _itemAnimation(index++, itemCount),
            child: Row(
              children: [
                Text(
                  l10n.projectType,
                  style: const TextStyle(color: ColorName.textSecondary),
                ),
                const SizedBox(width: AppDimensions.spacingSmall),
                ChoiceChip(
                  label: Text(
                    l10n.commercial,
                    style: TextStyle(
                      color: _isCommercial
                          ? ColorName.background
                          : ColorName.textSecondary,
                    ),
                  ),
                  selected: _isCommercial,
                  selectedColor: Theme.of(context).colorScheme.primary,
                  shape: const RoundedRectangleBorder(),
                  onSelected: (_) => setState(() => _isCommercial = true),
                ),
                const SizedBox(width: AppDimensions.spacingExtraSmall),
                ChoiceChip(
                  label: Text(
                    l10n.personal,
                    style: TextStyle(
                      color: !_isCommercial
                          ? ColorName.background
                          : ColorName.textSecondary,
                    ),
                  ),
                  selected: !_isCommercial,
                  selectedColor: Theme.of(context).colorScheme.primary,
                  shape: const RoundedRectangleBorder(),
                  onSelected: (_) => setState(() => _isCommercial = false),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spacingMedium),
          AnimatedFormItem(
            animation: _itemAnimation(index++, itemCount),
            child: AdminFormField(
              controller: _name,
              label: l10n.projectName,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingSmall),
          AnimatedFormItem(
            animation: _itemAnimation(index++, itemCount),
            child: AdminFormField(
              controller: _description,
              label: l10n.descriptionOptional,
              maxLines: 3,
            ),
          ),
          if (_isCommercial) ...[
            const SizedBox(height: AppDimensions.spacingSmall),
            AnimatedFormItem(
              animation: _itemAnimation(index++, itemCount),
              child: Row(
                children: [
                  Expanded(
                    child: AdminFormField(
                      controller: _company,
                      label: l10n.company,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingSmall),
                  Expanded(
                    child: AdminFormField(
                      controller: _role,
                      label: l10n.role,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            const SizedBox(height: AppDimensions.spacingSmall),
            AnimatedFormItem(
              animation: _itemAnimation(index++, itemCount),
              child: AdminFormField(
                controller: _githubUrl,
                label: l10n.githubUrl,
              ),
            ),
          ],
          const SizedBox(height: AppDimensions.spacingMedium),
          AnimatedFormItem(
            animation: _itemAnimation(index++, itemCount),
            child: FormSection(
              title: l10n.techStack,
              child: TechStackEditor(
                technologies: _techStack,
                onChanged: (techs) {
                  setState(() => _techStack = techs);
                  _markDirty();
                },
              ),
            ),
          ),
          if (_isCommercial)
            AnimatedFormItem(
              animation: _itemAnimation(index++, itemCount),
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
          AnimatedFormItem(
            animation: _itemAnimation(index, itemCount),
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
}
