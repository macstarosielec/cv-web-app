import 'package:flutter/material.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';

InputDecoration appInputDecoration({
  required BuildContext context,
  required String label,
  String? hint,
  IconData? prefixIcon,
  Widget? suffixIcon,
  bool isDense = false,
}) {
  final colors = Theme.of(context).colorScheme;
  return InputDecoration(
    labelText: label,
    hintText: hint,
    isDense: isDense,
    labelStyle: const TextStyle(color: ColorName.textSecondary),
    hintStyle: hint != null
        ? TextStyle(color: ColorName.textMuted.withValues(alpha: 0.4))
        : null,
    prefixIcon: prefixIcon != null
        ? Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Icon(
              prefixIcon,
              color: ColorName.textSecondary,
              size: AppDimensions.iconSizeDefault,
            ),
          )
        : null,
    suffixIcon: suffixIcon,
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
