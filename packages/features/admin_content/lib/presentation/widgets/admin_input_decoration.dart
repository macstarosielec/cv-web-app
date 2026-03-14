import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

InputDecoration adminInputDecoration({
  required BuildContext context,
  required String label,
  String? hint,
  bool isDense = false,
}) {
  final colors = Theme.of(context).colorScheme;
  return InputDecoration(
    labelText: label,
    hintText: hint,
    isDense: isDense,
    labelStyle: const TextStyle(color: ColorName.textSecondary),
    hintStyle: const TextStyle(color: ColorName.textMuted),
    filled: true,
    fillColor: ColorName.background.withValues(alpha: 0.5),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: ColorName.surfaceBorder),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: colors.primary),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: colors.secondary),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: colors.secondary),
    ),
    errorStyle: TextStyle(color: colors.secondary),
  );
}
