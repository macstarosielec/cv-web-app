import 'package:admin_content/presentation/widgets/admin_input_decoration.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared/gen/colors.gen.dart';
import 'package:shared/l10n/l10n.dart';
import 'package:shared/utils/social_link_icons.dart';
import 'package:shared/widgets/action_chip.dart' as shared;

class SocialLinksEditor extends StatefulWidget {
  const SocialLinksEditor({
    required this.socialLinks,
    required this.onChanged,
    super.key,
  });

  final List<SocialLink> socialLinks;
  final ValueChanged<List<SocialLink>> onChanged;

  @override
  State<SocialLinksEditor> createState() => _SocialLinksEditorState();
}

class _SocialLinksEditorState extends State<SocialLinksEditor> {
  final _nameController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _add() {
    final name = _nameController.text.trim();
    final url = _urlController.text.trim();
    if (name.isEmpty || url.isEmpty) return;
    widget.onChanged([
      ...widget.socialLinks,
      SocialLink(name: name, url: url),
    ]);
    _nameController.clear();
    _urlController.clear();
  }

  void _remove(int index) {
    final updated = List<SocialLink>.from(widget.socialLinks)..removeAt(index);
    widget.onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final accentColor = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < widget.socialLinks.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                FaIcon(
                  socialLinkIcon(widget.socialLinks[i].name),
                  size: 16,
                  color: accentColor,
                ),
                const SizedBox(width: 12),
                Text(
                  widget.socialLinks[i].name,
                  style: const TextStyle(
                    color: ColorName.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.socialLinks[i].url,
                    style: const TextStyle(
                      color: ColorName.textSecondary,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _remove(i),
                  child: const Icon(
                    Icons.close,
                    size: 14,
                    color: ColorName.textMuted,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
              width: 140,
              child: TextField(
                controller: _nameController,
                decoration: adminInputDecoration(
                  context: context,
                  label: l10n.platformName,
                  isDense: true,
                ),
                style: const TextStyle(color: ColorName.textPrimary),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _urlController,
                decoration: adminInputDecoration(
                  context: context,
                  label: l10n.platformUrl,
                  isDense: true,
                ),
                style: const TextStyle(color: ColorName.textPrimary),
                onSubmitted: (_) => _add(),
              ),
            ),
            const SizedBox(width: 8),
            shared.ActionChip(
              label: l10n.add,
              icon: Icons.add,
              onTap: _add,
            ),
          ],
        ),
      ],
    );
  }
}
