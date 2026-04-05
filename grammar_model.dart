// Models for Grammar Exercise System

import 'package:flutter/material.dart';

class GrammarTense {
  final String id;
  final String name;
  final Map<String, String> nameTranslations; // 26 lingue
  final Map<String, String> descriptions; // 26 lingue
  final Map<String, List<String>> usageExamples; // 26 lingue
  final Map<String, String> formationRules; // 26 lingue
  final int difficulty; // 1-5

  GrammarTense({
    required this.id,
    required this.name,
    required this.nameTranslations,
    required this.descriptions,
    required this.usageExamples,
    required this.formationRules,
    required this.difficulty,
  });

  String getNameTranslation(String languageCode) {
    return nameTranslations[languageCode] ?? nameTranslations['en'] ?? name;
  }

  String getDescription(String languageCode) {
    return descriptions[languageCode] ?? descriptions['en'] ?? '';
  }

  List<String> getUsageExamples(String languageCode) {
    return usageExamples[languageCode] ?? usageExamples['en'] ?? [];
  }

  String getFormationRule(String languageCode) {
    return formationRules[languageCode] ?? formationRules['en'] ?? '';
  }
}

class GrammarExercise {
  final String id;
  final String tenseId;
  final GrammarExerciseType type;
  final Map<String, String> questions; // 26 lingue
  final Map<String, List<String>> options; // 26 lingue, opzioni multiple
  final Map<String, String> correctAnswers; // 26 lingue
  final Map<String, String> explanations; // 26 lingue
  final int difficulty; // 1-5

  GrammarExercise({
    required this.id,
    required this.tenseId,
    required this.type,
    required this.questions,
    required this.options,
    required this.correctAnswers,
    required this.explanations,
    required this.difficulty,
  });

  String getQuestion(String languageCode) {
    return questions[languageCode] ?? questions['en'] ?? '';
  }

  List<String> getOptions(String languageCode) {
    return options[languageCode] ?? options['en'] ?? [];
  }

  String getCorrectAnswer(String languageCode) {
    return correctAnswers[languageCode] ?? correctAnswers['en'] ?? '';
  }

  String getExplanation(String languageCode) {
    return explanations[languageCode] ?? explanations['en'] ?? '';
  }
}

enum GrammarExerciseType {
  fillInBlank,      // Riempi lo spazio
  multipleChoice,   // Scelta multipla
  conjugation,      // Coniugazione verbo
  sentenceBuilding, // Costruisci frase
  correction,       // Correggi l'errore
  translation,      // Traduci
}

class GrammarExerciseSession {
  final String tenseId;
  final String languageCode;
  final DateTime startTime;
  DateTime? endTime;
  final List<GrammarExerciseResult> results;

  GrammarExerciseSession({
    required this.tenseId,
    required this.languageCode,
    required this.startTime,
    this.endTime,
    required this.results,
  });

  int get correctCount => results.where((r) => r.isCorrect).length;
  int get totalCount => results.length;
  double get percentage => totalCount > 0 ? (correctCount / totalCount) * 100 : 0;
  bool get passed => percentage >= 70;
  
  Duration get duration {
    if (endTime == null) return Duration.zero;
    return endTime!.difference(startTime);
  }
}

class GrammarExerciseResult {
  final String exerciseId;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;
  final DateTime answeredAt;

  GrammarExerciseResult({
    required this.exerciseId,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    required this.answeredAt,
  });
}

class GrammarTopic {
  final String id;
  final Map<String, String> titles; // 26 lingue
  final Map<String, String> descriptions; // 26 lingue
  final IconData icon;
  final Color color;
  final List<GrammarTense> tenses;
  final int completedLessons;
  final int totalLessons;

  GrammarTopic({
    required this.id,
    required this.titles,
    required this.descriptions,
    required this.icon,
    required this.color,
    required this.tenses,
    required this.completedLessons,
    required this.totalLessons,
  });

  String getTitle(String languageCode) {
    return titles[languageCode] ?? titles['en'] ?? '';
  }

  String getDescription(String languageCode) {
    return descriptions[languageCode] ?? descriptions['en'] ?? '';
  }

  double get progress => totalLessons > 0 ? completedLessons / totalLessons : 0;
}