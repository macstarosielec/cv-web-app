import 'package:admin_content/presentation/widgets/admin_input_decoration.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/widgets/action_chip.dart' as shared;

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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
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
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => _remove(i),
                    child: const Icon(
                      Icons.close,
                      size: AppDimensions.iconSizeSmall,
                      color: ColorName.textMuted,
                    ),
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
                  decoration: adminInputDecoration(context: context,
                    label: l10n.languageName,
                    isDense: true,
                  ),
                  style: const TextStyle(color: ColorName.textPrimary),
                ),
              ),
              const SizedBox(width: AppDimensions.spacingExtraSmall),
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
              const SizedBox(width: AppDimensions.spacingExtraSmall),
              shared.ActionChip(
                label: l10n.add,
                icon: Icons.add,
                onTap: _add,
              ),
            ],
          ),
        ],
      );
  }
}
