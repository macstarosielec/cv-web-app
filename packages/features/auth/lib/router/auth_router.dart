import 'package:auth/presentation/login/view/login_page.dart';
import 'package:auto_route/auto_route.dart';

part 'auth_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AuthRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page),
      ];
}
