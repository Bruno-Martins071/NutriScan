import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/user_avatar.dart';

typedef ProfileIdentity = ({String name, int avatarColorIndex});

Future<ProfileIdentity?> showProfileIdentitySheet(
  BuildContext context, {
  required String name,
  required int avatarColorIndex,
}) {
  return showModalBottomSheet<ProfileIdentity>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: AppColors.lightCard,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: (_) => Theme(
      data: AppTheme.light,
      child: ProfileIdentitySheet(
        initialName: name,
        initialAvatarColorIndex: avatarColorIndex,
      ),
    ),
  );
}

class ProfileIdentitySheet extends StatefulWidget {
  const ProfileIdentitySheet({
    super.key,
    required this.initialName,
    required this.initialAvatarColorIndex,
  });

  final String initialName;
  final int initialAvatarColorIndex;

  @override
  State<ProfileIdentitySheet> createState() => _ProfileIdentitySheetState();
}

class _ProfileIdentitySheetState extends State<ProfileIdentitySheet> {
  late final TextEditingController _nameController = TextEditingController(
    text: widget.initialName,
  );
  late int _avatarColorIndex = widget.initialAvatarColorIndex;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String get _initial {
    final trimmed = _nameController.text.trim();
    return trimmed.isEmpty ? '' : trimmed[0].toUpperCase();
  }

  void _save() {
    Navigator.of(context).pop<ProfileIdentity>((
      name: _nameController.text.trim(),
      avatarColorIndex: _avatarColorIndex,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        0,
        24,
        24 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quem usa este perfil?',
              style: AppTextStyles.pageTitle.copyWith(fontSize: 24),
            ),
            const SizedBox(height: 6),
            const Text(
              'O nome aparece na câmera e no histórico. Fica só no aparelho.',
              style: AppTextStyles.sectionSubtitle,
            ),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: [
                for (
                  var index = 0;
                  index < AppColors.avatarColors.length;
                  index++
                )
                  _AvatarColorOption(
                    initial: _initial,
                    color: AppColors.avatarColors[index],
                    isSelected: index == _avatarColorIndex,
                    onTap: () => setState(() => _avatarColorIndex = index),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              autofocus: true,
              maxLength: 40,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              style: AppTextStyles.lightBody.copyWith(fontSize: 18),
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) => _save(),
              decoration: InputDecoration(
                labelText: 'Nome',
                counterText: '',
                floatingLabelStyle: const TextStyle(
                  color: AppColors.brandStrong,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: AppColors.lightBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: AppColors.brandStrong,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Pode ser o seu nome ou o de quem você cuida, como "Júlia (filha)".',
              style: AppTextStyles.sectionSubtitle,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.lightBackground,
                        foregroundColor: AppColors.lightText,
                        side: const BorderSide(color: AppColors.lightBorder),
                        textStyle: AppTextStyles.primaryButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: FilledButton(
                      onPressed: _save,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.brandStrong,
                        foregroundColor: AppColors.lightCard,
                        textStyle: AppTextStyles.primaryButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Salvar'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarColorOption extends StatelessWidget {
  const _AvatarColorOption({
    required this.initial,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final String initial;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: 'Cor do avatar',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? AppColors.lightText : Colors.transparent,
              width: 2.5,
            ),
          ),
          child: UserAvatar(
            initial: initial.isEmpty ? 'A' : initial,
            color: color,
            size: 52,
          ),
        ),
      ),
    );
  }
}
