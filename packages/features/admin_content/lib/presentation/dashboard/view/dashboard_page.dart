import 'dart:async';

import 'package:admin_content/presentation/dashboard/view/dashboard_view.dart';
import 'package:admin_content/presentation/profile/cubit/admin_profile_cubit.dart';
import 'package:admin_content/presentation/projects/cubit/admin_projects_cubit.dart';
import 'package:admin_content/presentation/work_experience/cubit/admin_work_experience_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({this.onSignOut, super.key});

  final VoidCallback? onSignOut;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) {
              final cubit = GetIt.instance<AdminProfileCubit>();
              unawaited(cubit.loadProfile());
              return cubit;
            },
          ),
          BlocProvider(
            create: (_) {
              final cubit = GetIt.instance<AdminProjectsCubit>();
              unawaited(cubit.loadProjects());
              return cubit;
            },
          ),
          BlocProvider(
            create: (_) {
              final cubit = GetIt.instance<AdminWorkExperienceCubit>();
              unawaited(cubit.loadWorkExperiences());
              return cubit;
            },
          ),
        ],
        child: DashboardView(
          onSignOut: onSignOut ?? () {},
        ),
      );
}
