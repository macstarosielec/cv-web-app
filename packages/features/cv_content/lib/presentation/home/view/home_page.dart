import 'package:auto_route/auto_route.dart';
import 'package:cv_content/presentation/experience/cubit/work_experience_cubit.dart';
import 'package:cv_content/presentation/home/cubit/profile_cubit.dart';
import 'package:cv_content/presentation/home/view/home_view.dart';
import 'package:cv_content/presentation/projects/cubit/projects_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => GetIt.instance<ProfileCubit>()..loadProfile(),
          ),
          BlocProvider(
            create: (_) => GetIt.instance<ProjectsCubit>()..loadProjects(),
          ),
          BlocProvider(
            create: (_) =>
                GetIt.instance<WorkExperienceCubit>()..loadWorkExperiences(),
          ),
        ],
        child: const HomeView(),
      );
}
