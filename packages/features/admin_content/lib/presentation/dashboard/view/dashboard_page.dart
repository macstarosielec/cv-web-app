import 'dart:async';

import 'package:admin_content/presentation/dashboard/view/dashboard_view.dart';
import 'package:admin_content/presentation/profile/cubit/admin_profile_cubit.dart';
import 'package:admin_content/presentation/projects/cubit/admin_projects_cubit.dart';
import 'package:admin_content/presentation/work_experience/cubit/admin_work_experience_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class DashboardPage extends HookWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit =
        useMemoized(() => GetIt.instance<AdminProfileCubit>());
    final projectsCubit =
        useMemoized(() => GetIt.instance<AdminProjectsCubit>());
    final workExperienceCubit =
        useMemoized(() => GetIt.instance<AdminWorkExperienceCubit>());

    useEffect(
      () {
        unawaited(profileCubit.loadProfile());
        unawaited(projectsCubit.loadProjects());
        unawaited(workExperienceCubit.loadWorkExperiences());
        return null;
      },
      [],
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: profileCubit),
        BlocProvider.value(value: projectsCubit),
        BlocProvider.value(value: workExperienceCubit),
      ],
      child: DashboardView(
        onSignOut: () => context.router.root.replaceAll([]),
      ),
    );
  }
}
