import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class LanguagesEditor extends StatefulWidget {
  const LanguagesEditor({
    required this.languages,
    required this.onChanged,
    super.key,
  });

  final List<Language> languages;
  final ValueChanged<List<Language>> onChanged;

  @override
  State<LanguagesEditor> createState() => _LanguagesEditorState();
}

class _LanguagesEditorState extends State<LanguagesEditor> {
  final _nameController = TextEditingController();
  LanguageProficiency _proficiency = LanguageProficiency.b2;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _add() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    final language = Language(name: name, proficiency: _proficiency);
    widget.onChanged([...widget.languages, language]);
    _nameController.clear();
    setState(() => _proficiency = LanguageProficiency.b2);
  }

  void _remove(int index) {
    final updated = List<Language>.from(widget.languages)..removeAt(index);
    widget.onChanged(updated);
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < widget.languages.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.languages[i].name,
                      style: const TextStyle(color: ColorName.textPrimary),
                    ),
                  ),
                  Text(
                    widget.languages[i].proficiency.label,
                    style: const TextStyle(color: ColorName.textSecondary),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 16,
                      color: ColorName.textMuted,
                    ),
                    onPressed: () => _remove(i),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Language name',
                    isDense: true,
                  ),
                  style: const TextStyle(color: ColorName.textPrimary),
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<LanguageProficiency>(
                value: _proficiency,
                dropdownColor: ColorName.surface,
                style: const TextStyle(color: ColorName.textPrimary),
                items: LanguageProficiency.values
                    .map(
                      (p) => DropdownMenuItem(
                        value: p,
                        child: Text(p.label),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _proficiency = value);
                },
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
