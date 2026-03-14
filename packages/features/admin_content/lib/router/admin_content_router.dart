import 'package:admin_content/presentation/dashboard/view/dashboard_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';

part 'admin_content_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AdminContentRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: DashboardRoute.page),
      ];
}
