import 'package:admin_content/presentation/dashboard/view/widgets/dashboard_sidebar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared/gen/colors.gen.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({required this.onSignOut, super.key});

  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorName.background,
        body: Row(
          children: [
            DashboardSidebar(onSignOut: onSignOut),
            Container(width: 1, color: ColorName.surfaceBorder),
            const Expanded(child: AutoRouter()),
          ],
        ),
      );
}
