import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class InterestsEditor extends StatefulWidget {
  const InterestsEditor({
    required this.interests,
    required this.onChanged,
    super.key,
  });

  final List<String> interests;
  final ValueChanged<List<String>> onChanged;

  @override
  State<InterestsEditor> createState() => _InterestsEditorState();
}

class _InterestsEditorState extends State<InterestsEditor> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _add() {
    final value = _controller.text.trim();
    if (value.isEmpty) return;
    widget.onChanged([...widget.interests, value]);
    _controller.clear();
  }

  void _remove(int index) {
    final updated = List<String>.from(widget.interests)..removeAt(index);
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
              for (var i = 0; i < widget.interests.length; i++)
                Chip(
                  backgroundColor: ColorName.surfaceLight,
                  label: Text(
                    widget.interests[i],
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
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Add interest',
                    isDense: true,
                  ),
                  style: const TextStyle(color: ColorName.textPrimary),
                  onSubmitted: (_) => _add(),
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
