// Model for multilingual vocabulary system
class VocabularyWord {
  final String id;
  final Map<String, String> translations; // languageCode -> translation
  final String category;
  final Map<String, String> examples; // languageCode -> example sentence
  final String? pronunciation; // IPA or phonetic
  final int difficulty; // 1-5
  final List<String> tags;

  VocabularyWord({
    required this.id,
    required this.translations,
    required this.category,
    required this.examples,
    this.pronunciation,
    this.difficulty = 1,
    this.tags = const [],
  });

  String getTranslation(String languageCode) {
    return translations[languageCode] ?? translations['en'] ?? '';
  }

  String getExample(String languageCode) {
    return examples[languageCode] ?? examples['en'] ?? '';
  }
}

class QuizQuestion {
  final String wordInTargetLanguage;
  final String correctAnswer;
  final List<String> options;
  final String category;
  final int difficulty;

  QuizQuestion({
    required this.wordInTargetLanguage,
    required this.correctAnswer,
    required this.options,
    required this.category,
    required this.difficulty,
  });
}

class QuizResult {
  final int correctAnswers;
  final int totalQuestions;
  final int timeSpentSeconds;
  final List<bool> answers;
  final DateTime completedAt;

  QuizResult({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.timeSpentSeconds,
    required this.answers,
    required this.completedAt,
  });

  double get percentage => (correctAnswers / totalQuestions) * 100;
  bool get passed => percentage >= 70;
}