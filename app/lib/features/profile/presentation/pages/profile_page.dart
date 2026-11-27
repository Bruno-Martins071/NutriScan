import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/feedback/info_banner.dart';
import '../../../../core/widgets/page_header.dart';
import '../../../../core/widgets/section_card.dart';
import '../../domain/repositories/profile_repository.dart';
import '../controllers/profile_controller.dart';
import '../state/profile_state.dart';
import '../widgets/custom_restriction_chip.dart';
import '../widgets/custom_restriction_input.dart';
import '../widgets/profile_identity_sheet.dart';
import '../widgets/profile_identity_tile.dart';
import '../widgets/selectable_allergy_chip.dart';
import '../widgets/trace_warning_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.repository});

  final ProfileRepository repository;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const double _maxContentWidth = 600;

  late final ProfileController _controller = ProfileController(
    widget.repository,
  );

  @override
  void initState() {
    super.initState();
    _controller.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _editIdentity() async {
    final state = _controller.state;
    final identity = await showProfileIdentitySheet(
      context,
      name: state.name,
      avatarColorIndex: state.avatarColorIndex,
    );
    if (identity == null) return;
    _controller.updateIdentity(
      name: identity.name,
      avatarColorIndex: identity.avatarColorIndex,
    );
  }

  Future<void> _save() async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final saved = await _controller.save();

    messenger.showSnackBar(
      SnackBar(
        content: Text(
          saved
              ? 'Perfil salvo no aparelho.'
              : 'Não foi possível salvar o perfil. Tente de novo.',
        ),
      ),
    );
    if (saved && navigator.canPop()) navigator.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.light,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: AppColors.lightBackground,
          body: SafeArea(
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, _) {
                final state = _controller.state;
                return Column(
                  children: [
                    _centered(
                      PageHeader(
                        title:
                            state.isFirstUse &&
                                state.status == ProfileStatus.ready
                            ? 'Monte seu perfil'
                            : 'Perfil',
                      ),
                    ),
                    Expanded(child: _buildBody(state)),
                    if (state.status == ProfileStatus.ready)
                      _centered(_SaveBar(state: state, onSave: _save)),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(ProfileState state) {
    switch (state.status) {
      case ProfileStatus.loading:
        return const Center(
          child: CircularProgressIndicator(color: AppColors.brandStrong),
        );
      case ProfileStatus.failure:
        return _LoadFailure(onRetry: _controller.load);
      case ProfileStatus.ready:
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: _centered(
            Column(
              children: [
                const InfoBanner(
                  icon: Icons.lock_rounded,
                  message: 'Fica só neste aparelho. Nada vai para servidores.',
                ),
                const SizedBox(height: 16),
                SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Para quem é este perfil?',
                        style: AppTextStyles.sectionTitle,
                      ),
                      const SizedBox(height: 16),
                      ProfileIdentityTile(
                        name: state.name,
                        initial: state.initial,
                        avatarColor: _avatarColor(state.avatarColorIndex),
                        onTap: _editIdentity,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _AllergiesCard(state: state, controller: _controller),
                const SizedBox(height: 16),
                TraceWarningCard(
                  value: state.warnAboutTraces,
                  onChanged: _controller.setWarnAboutTraces,
                ),
              ],
            ),
          ),
        );
    }
  }

  Widget _centered(Widget child) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _maxContentWidth),
        child: child,
      ),
    );
  }

  Color _avatarColor(int index) {
    final colors = AppColors.avatarColors;
    return colors[index.clamp(0, colors.length - 1)];
  }
}

class _AllergiesCard extends StatelessWidget {
  const _AllergiesCard({required this.state, required this.controller});

  final ProfileState state;
  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Alergias e intolerâncias',
            style: AppTextStyles.sectionTitle,
          ),
          const SizedBox(height: 4),
          const Text(
            'Toque para marcar. O semáforo usa esta lista.',
            style: AppTextStyles.sectionSubtitle,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              for (final allergy in state.defaultAllergies)
                SelectableAllergyChip(
                  label: allergy.name,
                  isSelected: state.selectedAllergyIds.contains(allergy.id),
                  onTap: () => controller.toggleAllergy(allergy.id!),
                ),
            ],
          ),
          const SizedBox(height: 20),
          CustomRestrictionInput(
            onAdd: controller.addCustomRestriction,
            suggestionsFor: controller.suggestionsFor,
          ),
          if (state.customRestrictions.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final restriction in state.customRestrictions)
                  CustomRestrictionChip(
                    label: restriction,
                    onRemove: () =>
                        controller.removeCustomRestriction(restriction),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _SaveBar extends StatelessWidget {
  const _SaveBar({required this.state, required this.onSave});

  final ProfileState state;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Salvar perfil',
            isLoading: state.isSaving,
            onPressed: state.canSave ? onSave : null,
          ),
          const SizedBox(height: 10),
          Text(
            state.summary,
            textAlign: TextAlign.center,
            style: AppTextStyles.sectionSubtitle.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _LoadFailure extends StatelessWidget {
  const _LoadFailure({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Não foi possível carregar o perfil.',
              textAlign: TextAlign.center,
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            TextButton(onPressed: onRetry, child: const Text('Tentar de novo')),
          ],
        ),
      ),
    );
  }
}
