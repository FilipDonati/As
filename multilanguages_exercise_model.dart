// Modelli per il sistema di esercizi multilingua completo

enum ExerciseType {
  sentenceReorder,          // Riordina la frase da tradurre
  wordSelection,            // Scegli parole da inserire in ordine
  translateAndOrder,        // Traduci e scrivi nell'ordine corretto
  complexTranslation,       // Traduci frasi lunghe e complesse
  fillInBlank,             // Scegli la parola giusta tra 4
  listeningComprehension,  // Scegli la parola corretta dall'ascolto
}

class MultiLanguageText {
  final Map<String, String> translations;

  MultiLanguageText({required this.translations});

  String get(String languageCode) {
    return translations[languageCode] ?? translations['en'] ?? '';
  }

  // Tutte le 26 lingue supportate
  static const List<String> supportedLanguages = [
    'en', // English
    'it', // Italiano
    'de', // Deutsch
    'es', // Español
    'fr', // Français
    'ru', // Русский
    'zh', // 中文
    'bg', // Български
    'cs', // Čeština
    'da', // Dansk
    'et', // Eesti
    'fi', // Suomi
    'el', // Ελληνικά
    'ga', // Gaeilge
    'lv', // Latviešu
    'lt', // Lietuvių
    'mt', // Malti
    'nl', // Nederlands
    'pl', // Polski
    'pt', // Português
    'ro', // Română
    'sk', // Slovenčina
    'sl', // Slovenščina
    'sv', // Svenska
    'hu', // Magyar
    'hr', // Hrvatski
  ];
}

class MultilingualExercise {
  final String id;
  final ExerciseType type;
  final MultiLanguageText question;
  final MultiLanguageText sentence;
  final List<MultiLanguageText>? wordOptions;
  final MultiLanguageText correctAnswer;
  final MultiLanguageText? explanation;
  final String? audioUrl;
  final int difficulty; // 1-5
  final List<String> tags;

  MultilingualExercise({
    required this.id,
    required this.type,
    required this.question,
    required this.sentence,
    this.wordOptions,
    required this.correctAnswer,
    this.explanation,
    this.audioUrl,
    this.difficulty = 1,
    this.tags = const [],
  });
}

class ExerciseLesson {
  final String id;
  final MultiLanguageText title;
  final MultiLanguageText description;
  final int level;
  final String category;
  final List<MultilingualExercise> exercises;

  ExerciseLesson({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.category,
    required this.exercises,
  });
}

class UserAnswer {
  final String exerciseId;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;
  final DateTime timestamp;

  UserAnswer({
    required this.exerciseId,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    required this.timestamp,
  });
}

class ExerciseSession {
  final String lessonId;
  final DateTime startTime;
  DateTime? endTime;
  List<UserAnswer> answers;
  int correctCount = 0;
  int totalCount = 0;

  ExerciseSession({
    required this.lessonId,
    required this.startTime,
    this.endTime,
    List<UserAnswer>? answers,
  }) : answers = answers ?? [];

  double get percentage => totalCount > 0 ? (correctCount / totalCount) * 100 : 0;

  void addAnswer(UserAnswer answer) {
    answers.add(answer);
    totalCount++;
    if (answer.isCorrect) correctCount++;
  }

  void complete() {
    endTime = DateTime.now();
  }
}