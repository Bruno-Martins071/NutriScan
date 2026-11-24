import '../../../../core/utils/text_normalizer.dart';

class RestrictionSuggestion {
  const RestrictionSuggestion({required this.name, this.aliases = const []});

  final String name;
  final List<String> aliases;

  String? matchedTermFor(String query) {
    final normalizedQuery = TextNormalizer.normalize(query);
    if (normalizedQuery.isEmpty) return null;

    for (final term in [name, ...aliases]) {
      if (TextNormalizer.normalize(term).contains(normalizedQuery)) return term;
    }
    return null;
  }
}
