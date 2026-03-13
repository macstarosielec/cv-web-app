import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/utils/breakpoints.dart';

class BreakpointToast extends StatelessWidget {
  const BreakpointToast({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return const SizedBox.shrink();

    final breakpoint = Breakpoints.of(context);

    return Positioned(
      top: 8,
      right: 8,
      child: IgnorePointer(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: ColorName.surface,
            border: Border.all(color: ColorName.accent),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            breakpoint.name,
            style: const TextStyle(
              fontSize: 12,
              color: ColorName.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
