import 'package:flutter/material.dart';
import 'package:shared/widgets/app_input_decoration.dart';

InputDecoration adminInputDecoration({
  required BuildContext context,
  required String label,
  String? hint,
  bool isDense = false,
}) =>
    appInputDecoration(
      context: context,
      label: label,
      hint: hint,
      isDense: isDense,
    );
