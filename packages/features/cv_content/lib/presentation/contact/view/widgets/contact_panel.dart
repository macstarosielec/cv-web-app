import 'package:cv_content/presentation/contact/view/widgets/contact_row.dart';
import 'package:cv_content/presentation/home/cubit/profile_cubit.dart';
import 'package:cv_content/presentation/home/cubit/profile_state.dart';
import 'package:cv_content/presentation/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/utils/social_link_icons.dart';
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
        loaded: (profile) {
          final l10n = AppLocalizations.of(context);
          final accentColor = Theme.of(context).colorScheme.primary;
          return Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(l10n.contact),
                const SizedBox(height: AppDimensions.spacingLarge),
                ContactRow(
                  icon: Icon(
                    Icons.email_outlined,
                    size: AppDimensions.iconSizeMedium,
                    color: accentColor,
                  ),
                  label: l10n.email,
                  value: profile.email,
                ),
                if (profile.phoneNumber != null)
                  ContactRow(
                    icon: Icon(
                      Icons.phone_outlined,
                      size: AppDimensions.iconSizeMedium,
                      color: accentColor,
                    ),
                    label: l10n.phone,
                    value: profile.phoneNumber!,
                  ),
                for (final link in profile.socialLinks)
                  ContactRow(
                    icon: FaIcon(
                      socialLinkIcon(link.name),
                      size: AppDimensions.iconSizeMedium,
                      color: accentColor,
                    ),
                    label: link.name,
                    value: link.url,
                  ),
              ],
            ),
          );
        },
        error: (exception) => SectionError(
          exception: exception,
          onRetry: () =>
              context.read<ProfileCubit>().loadProfile(),
        ),
      ),
    );
}
