import 'package:admin_content/presentation/widgets/admin_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class AdminFormField extends StatelessWidget {
  const AdminFormField({
    required this.controller,
    required this.label,
    this.maxLines = 1,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final int maxLines;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: adminInputDecoration(
          context: context,
          label: label,
          isDense: true,
        ),
        style: const TextStyle(color: ColorName.textPrimary),
      );
}
