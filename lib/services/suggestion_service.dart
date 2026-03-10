class SuggestionService {
  static const int minCount = 2;
  static const int maxSuggestions = 5;

  List<String> getSuggestions(String query, Map<String, int> frequency) {
    if (query.isEmpty) return [];

    final matches = frequency.entries
        .where((e) =>
            e.value >= minCount &&
            e.key.toLowerCase().contains(query.toLowerCase()))
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return matches.map((e) => e.key).take(maxSuggestions).toList();
  }
}
