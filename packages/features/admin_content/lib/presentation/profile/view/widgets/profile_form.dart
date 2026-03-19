import 'dart:async';

import 'package:admin_content/presentation/profile/cubit/admin_profile_cubit.dart';
import 'package:admin_content/presentation/profile/view/widgets/interests_editor.dart';
import 'package:admin_content/presentation/profile/view/widgets/languages_editor.dart';
import 'package:admin_content/presentation/profile/view/widgets/social_links_editor.dart';
import 'package:admin_content/presentation/widgets/admin_input_decoration.dart';
import 'package:admin_content/presentation/widgets/form_section.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/constants/app_dimensions.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/widgets/action_chip.dart' as shared;

class ProfileForm extends StatefulWidget {
  const ProfileForm({required this.profile, super.key});

  final Profile profile;

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  late final TextEditingController _fullName;
  late final TextEditingController _title;
  late final TextEditingController _about;
  late final TextEditingController _email;
  late final TextEditingController _phoneNumber;
  late final TextEditingController _location;
  late String? _timezone;
  late final TextEditingController _cvUrl;
  late List<Language> _languages;
  late List<String> _interests;
  late List<SocialLink> _socialLinks;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _fullName = TextEditingController(text: p.fullName);
    _title = TextEditingController(text: p.title);
    _about = TextEditingController(text: p.about);
    _email = TextEditingController(text: p.email);
    _phoneNumber = TextEditingController(text: p.phoneNumber ?? '');
    _location = TextEditingController(text: p.location ?? '');
    _timezone = _timezones.contains(p.timezone) ? p.timezone : null;
    _cvUrl = TextEditingController(text: p.cvUrl ?? '');
    _languages = List.from(p.languages);
    _interests = List.from(p.interests);
    _socialLinks = List.from(p.socialLinks);
  }

  @override
  void dispose() {
    _fullName.dispose();
    _title.dispose();
    _about.dispose();
    _email.dispose();
    _phoneNumber.dispose();
    _location.dispose();
    _cvUrl.dispose();
    super.dispose();
  }

  void _save() {
    final profile = widget.profile.copyWith(
      fullName: _fullName.text.trim(),
      title: _title.text.trim(),
      about: _about.text.trim(),
      email: _email.text.trim(),
      phoneNumber:
          _phoneNumber.text.trim().isEmpty ? null : _phoneNumber.text.trim(),
      location:
          _location.text.trim().isEmpty ? null : _location.text.trim(),
      timezone: _timezone,
      cvUrl: _cvUrl.text.trim().isEmpty ? null : _cvUrl.text.trim(),
      languages: _languages,
      interests: _interests,
      socialLinks: _socialLinks,
    );
    unawaited(context.read<AdminProfileCubit>().saveProfile(profile));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormSection(
              title: l10n.basicInfo,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _field(_fullName, l10n.fullName)),
                      const SizedBox(width: AppDimensions.spacingSmall),
                      Expanded(child: _field(_title, l10n.title)),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spacingSmall),
                  _field(_about, l10n.about, maxLines: 5),
                ],
              ),
            ),
            FormSection(
              title: l10n.contact,
              child: Row(
                children: [
                  Expanded(child: _field(_email, l10n.email)),
                  const SizedBox(width: AppDimensions.spacingSmall),
                  Expanded(
                    child: _field(
                      _phoneNumber,
                      l10n.phoneNumber,
                    ),
                  ),
                ],
              ),
            ),
            FormSection(
              title: l10n.socialLinks,
              child: SocialLinksEditor(
                socialLinks: _socialLinks,
                onChanged: (links) =>
                    setState(() => _socialLinks = links),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FormSection(
                    title: l10n.languages,
                    child: LanguagesEditor(
                      languages: _languages,
                      onChanged: (langs) =>
                          setState(() => _languages = langs),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.spacingSmall),
                Expanded(
                  child: FormSection(
                    title: l10n.interests,
                    child: InterestsEditor(
                      interests: _interests,
                      onChanged: (interests) =>
                          setState(() => _interests = interests),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FormSection(
                    title: l10n.location,
                    child: _field(_location, l10n.location),
                  ),
                ),
                const SizedBox(width: AppDimensions.spacingSmall),
                Expanded(
                  child: FormSection(
                    title: l10n.timezone,
                    child: _timezoneDropdown(context),
                  ),
                ),
              ],
            ),
            FormSection(
              title: l10n.cvPdf,
              child: _field(_cvUrl, l10n.cvPdf),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: shared.ActionChip(
                label: l10n.saveProfile,
                icon: Icons.save_outlined,
                onTap: _save,
              ),
            ),
          ],
        ),
      );
  }

  static const _timezones = [
    'UTC-12:00 (Baker Island)',
    'UTC-11:00 (Pago Pago)',
    'UTC-10:00 (Honolulu)',
    'UTC-09:00 (Anchorage)',
    'UTC-08:00 (Los Angeles)',
    'UTC-07:00 (Denver)',
    'UTC-06:00 (Chicago)',
    'UTC-05:00 (New York)',
    'UTC-04:00 (Santiago)',
    'UTC-03:00 (São Paulo)',
    'UTC-02:00 (South Georgia)',
    'UTC-01:00 (Azores)',
    'UTC+00:00 (London)',
    'UTC+01:00 (Berlin, Paris, Warsaw)',
    'UTC+02:00 (Cairo, Helsinki)',
    'UTC+03:00 (Moscow, Istanbul)',
    'UTC+04:00 (Dubai)',
    'UTC+05:00 (Karachi)',
    'UTC+05:30 (Mumbai)',
    'UTC+06:00 (Dhaka)',
    'UTC+07:00 (Bangkok)',
    'UTC+08:00 (Singapore)',
    'UTC+09:00 (Tokyo)',
    'UTC+09:30 (Adelaide)',
    'UTC+10:00 (Sydney)',
    'UTC+11:00 (Solomon Islands)',
    'UTC+12:00 (Auckland)',
  ];

  Widget _timezoneDropdown(BuildContext context) =>
      DropdownButtonFormField<String>(
        initialValue: _timezone,
        isExpanded: true,
        decoration: adminInputDecoration(
          context: context,
          label: AppLocalizations.of(context).timezone,
        ),
        dropdownColor: ColorName.surface,
        style: const TextStyle(color: ColorName.textPrimary),
        items: [
          const DropdownMenuItem<String>(
            child: Text(
              '—',
              style: TextStyle(color: ColorName.textMuted),
            ),
          ),
          ..._timezones.map(
            (tz) => DropdownMenuItem(
              value: tz,
              child: Text(tz, overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
        onChanged: (value) => setState(() => _timezone = value),
      );

  Widget _field(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
  }) =>
      TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: adminInputDecoration(context: context, label: label),
        style: const TextStyle(color: ColorName.textPrimary),
      );
}
