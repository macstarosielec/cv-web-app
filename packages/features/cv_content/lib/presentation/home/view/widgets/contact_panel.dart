import 'package:cv_content/presentation/home/cubit/profile_cubit.dart';
import 'package:cv_content/presentation/home/cubit/profile_state.dart';
import 'package:cv_content/presentation/home/view/widgets/contact_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/gen/colors.gen.dart';

class ContactPanel extends StatelessWidget {
  const ContactPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) => state.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        loaded: (profile) => Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact',
                style: textTheme.headlineSmall?.copyWith(
                  color: ColorName.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              ContactRow(
                icon: Icons.email_outlined,
                label: 'Email',
                value: profile.email,
              ),
              if (profile.phoneNumber != null)
                ContactRow(
                  icon: Icons.phone_outlined,
                  label: 'Phone',
                  value: profile.phoneNumber!,
                ),
              if (profile.linkedInUrl != null)
                ContactRow(
                  icon: Icons.link,
                  label: 'LinkedIn',
                  value: profile.linkedInUrl!,
                ),
              if (profile.githubUrl != null)
                ContactRow(
                  icon: Icons.code,
                  label: 'GitHub',
                  value: profile.githubUrl!,
                ),
            ],
          ),
        ),
        error: (message) => Center(child: Text('Error: $message')),
      ),
    );
  }
}
