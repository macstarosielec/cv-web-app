import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

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
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: ColorName.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Delete',
              style: TextStyle(color: ColorName.accent),
            ),
          ),
        ],
      );
}
