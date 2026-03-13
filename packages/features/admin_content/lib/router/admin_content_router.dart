import 'package:admin_content/presentation/dashboard/view/dashboard_page.dart';
import 'package:admin_content/presentation/profile/view/profile_editor_page.dart';
import 'package:admin_content/presentation/projects/view/projects_list_page.dart';
import 'package:admin_content/presentation/work_experience/view/work_experience_list_page.dart';
import 'package:auto_route/auto_route.dart';

part 'admin_content_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AdminContentRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: DashboardRoute.page,
          children: [
            AutoRoute(
              page: ProfileEditorRoute.page,
              initial: true,
            ),
            AutoRoute(page: ProjectsListRoute.page),
            AutoRoute(page: WorkExperienceListRoute.page),
          ],
        ),
      ];
}
