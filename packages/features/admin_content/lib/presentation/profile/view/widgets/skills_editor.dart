import 'package:admin_content/presentation/widgets/admin_input_decoration.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/widgets/action_chip.dart' as shared;

class SkillsEditor extends StatefulWidget {
  const SkillsEditor({
    required this.skills,
    required this.onChanged,
    super.key,
  });

  final List<Skill> skills;
  final ValueChanged<List<Skill>> onChanged;

  @override
  State<SkillsEditor> createState() => _SkillsEditorState();
}

class _SkillsEditorState extends State<SkillsEditor> {
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _add() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    final skill = Skill(
      name: name,
      category: _categoryController.text.trim().isEmpty
          ? null
          : _categoryController.text.trim(),
    );
    widget.onChanged([...widget.skills, skill]);
    _nameController.clear();
    _categoryController.clear();
  }

  void _remove(int index) {
    final updated = List<Skill>.from(widget.skills)..removeAt(index);
    widget.onChanged(updated);
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (var i = 0; i < widget.skills.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: const BoxDecoration(
                    color: ColorName.surfaceLight,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.skills[i].category != null
                            ? '${widget.skills[i].name} '
                                '(${widget.skills[i].category})'
                            : widget.skills[i].name,
                        style: const TextStyle(
                          color: ColorName.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => _remove(i),
                        child: const Icon(
                          Icons.close,
                          size: 14,
                          color: ColorName.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _nameController,
                  decoration: adminInputDecoration(context: context, 
                    label: 'Skill name',
                    isDense: true,
                  ),
                  style: const TextStyle(color: ColorName.textPrimary),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _categoryController,
                  decoration: adminInputDecoration(context: context, 
                    label: 'Category (optional)',
                    isDense: true,
                  ),
                  style: const TextStyle(color: ColorName.textPrimary),
                ),
              ),
              const SizedBox(width: 8),
              shared.ActionChip(
                label: 'Add',
                icon: Icons.add,
                onTap: _add,
              ),
            ],
          ),
        ],
      );
}
