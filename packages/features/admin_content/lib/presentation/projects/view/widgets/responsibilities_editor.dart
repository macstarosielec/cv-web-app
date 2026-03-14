import 'package:admin_content/presentation/widgets/admin_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/widgets/action_chip.dart' as shared;

class ResponsibilitiesEditor extends StatefulWidget {
  const ResponsibilitiesEditor({
    required this.responsibilities,
    required this.onChanged,
    super.key,
  });

  final List<String> responsibilities;
  final ValueChanged<List<String>> onChanged;

  @override
  State<ResponsibilitiesEditor> createState() => _ResponsibilitiesEditorState();
}

class _ResponsibilitiesEditorState extends State<ResponsibilitiesEditor> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _add() {
    final value = _controller.text.trim();
    if (value.isEmpty) return;
    widget.onChanged([...widget.responsibilities, value]);
    _controller.clear();
  }

  void _remove(int index) {
    final updated = List<String>.from(widget.responsibilities)
      ..removeAt(index);
    widget.onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < widget.responsibilities.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.responsibilities[i],
                    style: const TextStyle(color: ColorName.textPrimary),
                  ),
                ),
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
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: adminInputDecoration(
                  context: context,
                  label: l10n.addResponsibility,
                  isDense: true,
                ),
                style: const TextStyle(color: ColorName.textPrimary),
                onSubmitted: (_) => _add(),
              ),
            ),
            const SizedBox(width: 8),
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
