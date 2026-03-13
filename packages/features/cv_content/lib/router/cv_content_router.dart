import 'package:auto_route/auto_route.dart';
import 'package:cv_content/presentation/home/view/home_page.dart';

part 'cv_content_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class CvContentRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page),
  ];
}
