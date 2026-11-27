// Ponto de entrada temporário para o preview web do app, com o perfil em memória. Não versionar.
import 'package:flutter/material.dart';

import 'core/routing/app_routes.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/profile/data/datasources/local/default_allergies.dart';
import 'features/profile/data/datasources/local/restriction_suggestions.dart';
import 'features/profile/domain/entities/allergy.dart';
import 'features/profile/domain/entities/restriction_suggestion.dart';
import 'features/profile/domain/entities/user_profile.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/presentation/pages/profile_page.dart';

void main() {
  runApp(const ProfilePreviewApp());
}

class InMemoryProfileRepository implements ProfileRepository {
  UserProfile? _profile;
  int _nextCustomId = 100;

  final List<Allergy> _defaults = [
    for (final (index, allergy) in defaultAllergies.indexed)
      Allergy(id: index + 1, code: allergy.code, name: allergy.name),
  ];

  @override
  Future<List<Allergy>> getDefaultAllergies() async => _defaults;

  @override
  Future<List<RestrictionSuggestion>> getRestrictionSuggestions() async =>
      restrictionSuggestions;

  @override
  Future<UserProfile?> getProfile() async => _profile;

  @override
  Future<UserProfile> saveProfile(UserProfile profile) async {
    _profile = profile.copyWith(
      id: profile.id ?? 1,
      allergies: [
        for (final allergy in profile.allergies)
          allergy.id != null
              ? allergy
              : Allergy(id: _nextCustomId++, name: allergy.name, isCustom: true),
      ],
    );
    return _profile!;
  }
}

class ProfilePreviewApp extends StatefulWidget {
  const ProfilePreviewApp({super.key});

  @override
  State<ProfilePreviewApp> createState() => _ProfilePreviewAppState();
}

class _ProfilePreviewAppState extends State<ProfilePreviewApp> {
  final _repository = InMemoryProfileRepository();
  int _version = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriScan - Preview',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: Scaffold(
        backgroundColor: AppColors.ink,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
          child: FittedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 412,
                height: 860,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppColors.glassBorder, width: 6),
                ),
                child: Navigator(
                  key: ValueKey(_version),
                  initialRoute: AppRoutes.home,
                  onGenerateRoute: (settings) => MaterialPageRoute(
                    settings: settings,
                    builder: (_) => settings.name == AppRoutes.profile
                        ? ProfilePage(repository: _repository)
                        : HomePage(repository: _repository),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () => setState(() => _version++),
                icon: const Icon(Icons.refresh_rounded, color: AppColors.text),
                label: const Text(
                  'Reiniciar o app (mantém o perfil salvo)',
                  style: TextStyle(color: AppColors.text),
                ),
              ),
            ],
          ),
          ),
          ),
        ),
      ),
    );
  }
}
