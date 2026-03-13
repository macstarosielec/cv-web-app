import 'package:admin_content/presentation/work_experience/view/work_experience_list_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WorkExperienceListPage extends StatelessWidget {
  const WorkExperienceListPage({super.key});

  @override
  Widget build(BuildContext context) => const WorkExperienceListView();
}
