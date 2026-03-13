import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

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
                Chip(
                  backgroundColor: ColorName.surfaceLight,
                  label: Text(
                    widget.skills[i].category != null
                        ? '${widget.skills[i].name} (${widget.skills[i].category})'
                        : widget.skills[i].name,
                    style: const TextStyle(color: ColorName.textPrimary),
                  ),
                  deleteIconColor: ColorName.textMuted,
                  onDeleted: () => _remove(i),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Skill name',
                    isDense: true,
                  ),
                  style: const TextStyle(color: ColorName.textPrimary),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _categoryController,
                  decoration: const InputDecoration(
                    hintText: 'Category (optional)',
                    isDense: true,
                  ),
                  style: const TextStyle(color: ColorName.textPrimary),
                ),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: _add,
                child: const Text('Add'),
              ),
            ],
          ),
        ],
      );
}
