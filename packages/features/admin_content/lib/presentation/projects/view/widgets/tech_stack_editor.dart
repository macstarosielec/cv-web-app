import 'package:admin_content/presentation/widgets/admin_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/widgets/action_chip.dart' as shared;

class TechStackEditor extends StatefulWidget {
  const TechStackEditor({
    required this.technologies,
    required this.onChanged,
    super.key,
  });

  final List<String> technologies;
  final ValueChanged<List<String>> onChanged;

  @override
  State<TechStackEditor> createState() => _TechStackEditorState();
}

class _TechStackEditorState extends State<TechStackEditor> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _add() {
    final value = _controller.text.trim();
    if (value.isEmpty) return;
    widget.onChanged([...widget.technologies, value]);
    _controller.clear();
  }

  void _remove(int index) {
    final updated = List<String>.from(widget.technologies)..removeAt(index);
    widget.onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var i = 0; i < widget.technologies.length; i++)
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
                      widget.technologies[i],
                      style: const TextStyle(color: ColorName.textPrimary),
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
        if (widget.technologies.isNotEmpty) const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: adminInputDecoration(
                  context: context,
                  label: l10n.addTechnology,
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
