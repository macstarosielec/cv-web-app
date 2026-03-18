import 'package:admin_content/presentation/widgets/admin_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/widgets/action_chip.dart' as shared;
import 'package:shared/widgets/tag_chip.dart';

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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppDimensions.tagSpacing,
            runSpacing: AppDimensions.tagSpacing,
            children: [
              for (var i = 0; i < widget.interests.length; i++)
                TagChip(
                  label: widget.interests[i],
                  onRemove: () => _remove(i),
                ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacingSmall),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: adminInputDecoration(context: context,
                    label: l10n.addInterest,
                    isDense: true,
                  ),
                  style: const TextStyle(color: ColorName.textPrimary),
                  onSubmitted: (_) => _add(),
                ),
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
