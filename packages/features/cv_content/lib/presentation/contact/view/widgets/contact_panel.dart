import 'package:cv_content/presentation/contact/view/widgets/contact_panel_content.dart';
import 'package:cv_content/presentation/home/cubit/profile_cubit.dart';
import 'package:cv_content/presentation/home/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/widgets/dot_loader.dart';
import 'package:shared/widgets/section_error.dart';

class ContactPanel extends StatelessWidget {
  const ContactPanel({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) => state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(
            child: DotLoader(),
          ),
          loaded: (profile) => ContactPanelContent(profile: profile),
          error: (exception) => SectionError(
            exception: exception,
            onRetry: () => context.read<ProfileCubit>().loadProfile(),
          ),
        ),
      );
}
