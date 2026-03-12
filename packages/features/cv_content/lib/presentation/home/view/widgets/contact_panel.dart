import 'package:cv_content/presentation/home/cubit/profile_cubit.dart';
import 'package:cv_content/presentation/home/cubit/profile_state.dart';
import 'package:cv_content/presentation/home/view/widgets/contact_row.dart';
import 'package:cv_content/presentation/home/view/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/l10n/l10n.dart';

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
        loaded: (profile) {
          final l10n = AppLocalizations.of(context);
          return Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(l10n.contact),
                const SizedBox(height: 24),
                ContactRow(
                  icon: Icons.email_outlined,
                  label: l10n.email,
                  value: profile.email,
                ),
                if (profile.phoneNumber != null)
                  ContactRow(
                    icon: Icons.phone_outlined,
                    label: l10n.phone,
                    value: profile.phoneNumber!,
                  ),
                if (profile.linkedInUrl != null)
                  ContactRow(
                    icon: Icons.link,
                    label: l10n.linkedIn,
                    value: profile.linkedInUrl!,
                  ),
                if (profile.githubUrl != null)
                  ContactRow(
                    icon: Icons.code,
                    label: l10n.gitHub,
                    value: profile.githubUrl!,
                  ),
              ],
            ),
          );
        },
        error: (message) => Center(
          child: Text(AppLocalizations.of(context).errorMessage(message)),
        ),
      ),
    );
  }
}
