import 'dart:async';

import 'package:admin_content/presentation/profile/cubit/admin_profile_cubit.dart';
import 'package:admin_content/presentation/profile/view/widgets/interests_editor.dart';
import 'package:admin_content/presentation/profile/view/widgets/languages_editor.dart';
import 'package:admin_content/presentation/profile/view/widgets/skills_editor.dart';
import 'package:admin_content/presentation/widgets/admin_input_decoration.dart';
import 'package:admin_content/presentation/widgets/form_section.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late final TextEditingController _linkedInUrl;
  late final TextEditingController _githubUrl;
  late List<Skill> _skills;
  late List<Language> _languages;
  late List<String> _interests;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _fullName = TextEditingController(text: p.fullName);
    _title = TextEditingController(text: p.title);
    _about = TextEditingController(text: p.about);
    _email = TextEditingController(text: p.email);
    _phoneNumber = TextEditingController(text: p.phoneNumber ?? '');
    _linkedInUrl = TextEditingController(text: p.linkedInUrl ?? '');
    _githubUrl = TextEditingController(text: p.githubUrl ?? '');
    _skills = List.from(p.skills);
    _languages = List.from(p.languages);
    _interests = List.from(p.interests);
  }

  @override
  void dispose() {
    _fullName.dispose();
    _title.dispose();
    _about.dispose();
    _email.dispose();
    _phoneNumber.dispose();
    _linkedInUrl.dispose();
    _githubUrl.dispose();
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
      linkedInUrl:
          _linkedInUrl.text.trim().isEmpty ? null : _linkedInUrl.text.trim(),
      githubUrl:
          _githubUrl.text.trim().isEmpty ? null : _githubUrl.text.trim(),
      skills: _skills,
      languages: _languages,
      interests: _interests,
    );
    unawaited(context.read<AdminProfileCubit>().saveProfile(profile));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
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
                      const SizedBox(width: 12),
                      Expanded(child: _field(_title, l10n.title)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _field(_about, l10n.about, maxLines: 5),
                ],
              ),
            ),
            FormSection(
              title: l10n.contact,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _field(_email, l10n.email)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _field(
                          _phoneNumber,
                          l10n.phoneNumber,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _field(
                          _linkedInUrl,
                          l10n.linkedInUrl,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _field(
                          _githubUrl,
                          l10n.githubUrl,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            FormSection(
              title: l10n.skills,
              child: SkillsEditor(
                skills: _skills,
                onChanged: (skills) => setState(() => _skills = skills),
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
                const SizedBox(width: 12),
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
