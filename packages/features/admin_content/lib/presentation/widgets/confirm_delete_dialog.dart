import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/widgets/action_chip.dart' as shared;

class ConfirmDeleteDialog extends StatelessWidget {
  const ConfirmDeleteDialog({
    required this.title,
    required this.content,
    super.key,
  });

  final String title;
  final String content;

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String content,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmDeleteDialog(title: title, content: content),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(),
        backgroundColor: ColorName.surface,
        title: Text(
          title,
          style: const TextStyle(color: ColorName.textPrimary),
        ),
        content: Text(
          content,
          style: const TextStyle(color: ColorName.textSecondary),
        ),
        actions: [
          shared.ActionChip(
            label: 'Cancel',
            icon: Icons.close,
            onTap: () => Navigator.of(context).pop(false),
          ),
          shared.ActionChip(
            label: 'Delete',
            icon: Icons.delete_outline,
            onTap: () => Navigator.of(context).pop(true),
          ),
        ],
      );
}
