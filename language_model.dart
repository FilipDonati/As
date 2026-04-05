class Vocabulary {
  final String word;
  final String translation;
  final String pronunciation;
  final String example;
  final String? imageUrl;

  Vocabulary({
    required this.word,
    required this.translation,
    required this.pronunciation,
    required this.example,
    this.imageUrl,
  });
}

class GrammarLesson {
  final String title;
  final String description;
  final String rule;
  final List<String> examples;
  final String category;

  GrammarLesson({
    required this.title,
    required this.description,
    required this.rule,
    required this.examples,
    required this.category,
  });
}

class Exercise {
  final String id;
  final ExerciseType type;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String? audioUrl;
  final String? explanation;

  Exercise({
    required this.id,
    required this.type,
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.audioUrl,
    this.explanation,
  });
}

enum ExerciseType {
  fillInTheBlank,
  wordPosition,
  listenAndComplete,
  multipleChoice,
}

class Lesson {
  final String id;
  final String title;
  final String description;
  final int level;
  final List<Vocabulary> vocabulary;
  final List<GrammarLesson> grammar;
  final List<Exercise> exercises;
  final String category;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.vocabulary,
    required this.grammar,
    required this.exercises,
    required this.category,
  });
}

class UserProgress {
  final String lessonId;
  final int completedExercises;
  final int totalExercises;
  final double score;
  final DateTime lastAccessed;

  UserProgress({
    required this.lessonId,
    required this.completedExercises,
    required this.totalExercises,
    required this.score,
    required this.lastAccessed,
  });

  double get progressPercentage =>
      (completedExercises / totalExercises) * 100;
}