import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cv_content/presentation/experience/cubit/work_experience_cubit.dart';
import 'package:cv_content/presentation/home/cubit/profile_cubit.dart';
import 'package:cv_content/presentation/home/view/home_view.dart';
import 'package:cv_content/presentation/projects/cubit/projects_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit =
        useMemoized(() => GetIt.instance<ProfileCubit>());
    final projectsCubit =
        useMemoized(() => GetIt.instance<ProjectsCubit>());
    final workExperienceCubit =
        useMemoized(() => GetIt.instance<WorkExperienceCubit>());

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
      child: const HomeView(),
    );
  }
}
