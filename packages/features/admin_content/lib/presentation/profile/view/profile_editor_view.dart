import 'package:admin_content/presentation/profile/cubit/admin_profile_cubit.dart';
import 'package:admin_content/presentation/profile/cubit/admin_profile_state.dart';
import 'package:admin_content/presentation/profile/view/widgets/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/gen/colors.gen.dart';

class ProfileEditorView extends StatelessWidget {
  const ProfileEditorView({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AdminProfileCubit, AdminProfileState>(
        builder: (context, state) => state.when(
          initial: () => const SizedBox.shrink(),
          loading: () =>
              const Center(child: CircularProgressIndicator()),
          loaded: (profile) => ProfileForm(profile: profile),
          saving: (profile) => Stack(
            children: [
              ProfileForm(profile: profile),
              const ColoredBox(
                color: Color(0x66000000),
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
          saved: (profile) => ProfileForm(profile: profile),
          error: (message) => Center(
            child: Text(
              message,
              style: const TextStyle(color: ColorName.accentLight),
            ),
          ),
        ),
      );
}
