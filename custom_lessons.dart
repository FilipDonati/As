// ESEMPIO: Come aggiungere nuove lezioni personalizzate
// Copia questo template e modifica i contenuti


import 'package:login_ora/data/models/language_model.dart';

class CustomLessonsExample {
  // Esempio 1: Lezione sui Numeri in Inglese
  static Lesson numbersLesson() {
    return Lesson(
      id: 'lesson_numbers',
      title: 'Numeri e Quantità',
      description: 'Impara a contare e usare i numeri in inglese',
      level: 1,
      category: 'Base',
      vocabulary: [
        Vocabulary(
          word: 'One',
          translation: 'Uno',
          pronunciation: '/wʌn/',
          example: 'I have one cat.',
        ),
        Vocabulary(
          word: 'Ten',
          translation: 'Dieci',
          pronunciation: '/ten/',
          example: 'Ten fingers on my hands.',
        ),
        Vocabulary(
          word: 'Hundred',
          translation: 'Cento',
          pronunciation: '/ˈhʌndrəd/',
          example: 'One hundred years.',
        ),
      ],
      grammar: [
        GrammarLesson(
          title: 'Numeri Cardinali',
          description: 'Come usare i numeri per contare',
          category: 'Numeri',
          rule: 'one, two, three, four, five...',
          examples: [
            'I have three books',
            'There are five apples',
            'She has two dogs',
          ],
        ),
      ],
      exercises: [
        Exercise(
          id: 'num_ex1',
          type: ExerciseType.multipleChoice,
          question: 'Come si dice "5" in inglese?',
          options: ['Four', 'Five', 'Six', 'Seven'],
          correctAnswer: 'Five',
          explanation: 'Five significa cinque in inglese',
        ),
        Exercise(
          id: 'num_ex2',
          type: ExerciseType.fillInTheBlank,
          question: 'I have _____ apples. (3)',
          options: ['one', 'two', 'three', 'four'],
          correctAnswer: 'three',
          explanation: 'Three = tre',
        ),
      ],
    );
  }

  // Esempio 2: Lezione sul Cibo
  static Lesson foodLesson() {
    return Lesson(
      id: 'lesson_food',
      title: 'Cibo e Bevande',
      description: 'Vocabolario essenziale per ristoranti e cucina',
      level: 1,
      category: 'Vita Quotidiana',
      vocabulary: [
        Vocabulary(
          word: 'Water',
          translation: 'Acqua',
          pronunciation: '/ˈwɔːtər/',
          example: 'I drink water every day.',
        ),
        Vocabulary(
          word: 'Bread',
          translation: 'Pane',
          pronunciation: '/bred/',
          example: 'I eat bread for breakfast.',
        ),
        Vocabulary(
          word: 'Apple',
          translation: 'Mela',
          pronunciation: '/ˈæpəl/',
          example: 'An apple a day keeps the doctor away.',
        ),
        Vocabulary(
          word: 'Coffee',
          translation: 'Caffè',
          pronunciation: '/ˈkɒfi/',
          example: 'I need coffee in the morning.',
        ),
      ],
      grammar: [
        GrammarLesson(
          title: 'Sostantivi Numerabili e Non',
          description: 'Differenza tra countable e uncountable',
          category: 'Sostantivi',
          rule: 'Numerabili: apple, banana | Non numerabili: water, bread',
          examples: [
            'I have an apple (numerabile)',
            'I drink water (non numerabile)',
            'Three apples (numerabile plurale)',
          ],
        ),
      ],
      exercises: [
        Exercise(
          id: 'food_ex1',
          type: ExerciseType.multipleChoice,
          question: 'Cosa ordini al bar per la colazione?',
          options: ['Water', 'Coffee', 'Juice', 'All of the above'],
          correctAnswer: 'All of the above',
          explanation: 'Tutte sono bevande tipiche per la colazione',
        ),
        Exercise(
          id: 'food_ex2',
          type: ExerciseType.fillInTheBlank,
          question: 'I want to drink some _____.',
          options: ['water', 'apple', 'bread', 'coffee'],
          correctAnswer: 'water',
          explanation: 'Water è una bevanda',
        ),
        Exercise(
          id: 'food_ex3',
          type: ExerciseType.wordPosition,
          question: 'Ordina: "eat / I / bread / morning / every"',
          options: ['I', 'eat', 'bread', 'every', 'morning'],
          correctAnswer: 'I eat bread every morning',
          explanation: 'Ordine: soggetto + verbo + oggetto + tempo',
        ),
      ],
    );
  }

  // Esempio 3: Lezione sui Verbi d'Azione
  static Lesson actionVerbsLesson() {
    return Lesson(
      id: 'lesson_verbs',
      title: 'Verbi d\'Azione Comuni',
      description: 'I verbi più usati nella vita quotidiana',
      level: 2,
      category: 'Intermedio',
      vocabulary: [
        Vocabulary(
          word: 'To eat',
          translation: 'Mangiare',
          pronunciation: '/tuː iːt/',
          example: 'I eat breakfast at 8am.',
        ),
        Vocabulary(
          word: 'To drink',
          translation: 'Bere',
          pronunciation: '/tuː drɪŋk/',
          example: 'She drinks coffee every morning.',
        ),
        Vocabulary(
          word: 'To sleep',
          translation: 'Dormire',
          pronunciation: '/tuː sliːp/',
          example: 'I sleep 8 hours per night.',
        ),
        Vocabulary(
          word: 'To work',
          translation: 'Lavorare',
          pronunciation: '/tuː wɜːrk/',
          example: 'He works from 9 to 5.',
        ),
      ],
      grammar: [
        GrammarLesson(
          title: 'Simple Present',
          description: 'Come formare il presente semplice',
          category: 'Tempi Verbali',
          rule: 'I/You/We/They + verbo | He/She/It + verbo + s',
          examples: [
            'I work every day',
            'She works in a hospital',
            'They eat lunch at noon',
            'He drinks water',
          ],
        ),
        GrammarLesson(
          title: 'Present Continuous',
          description: 'Azioni in corso di svolgimento',
          category: 'Tempi Verbali',
          rule: 'soggetto + am/is/are + verbo + ing',
          examples: [
            'I am eating now',
            'She is drinking coffee',
            'They are working',
          ],
        ),
      ],
      exercises: [
        Exercise(
          id: 'verb_ex1',
          type: ExerciseType.fillInTheBlank,
          question: 'She _____ coffee every morning. (drink)',
          options: ['drink', 'drinks', 'drinking', 'drinked'],
          correctAnswer: 'drinks',
          explanation: 'Con he/she/it si aggiunge -s al verbo',
        ),
        Exercise(
          id: 'verb_ex2',
          type: ExerciseType.multipleChoice,
          question: 'Quale frase è al presente continuo?',
          options: [
            'I eat pizza',
            'I am eating pizza',
            'I ate pizza',
            'I will eat pizza',
          ],
          correctAnswer: 'I am eating pizza',
          explanation: 'Il presente continuo usa am/is/are + verbo-ing',
        ),
        Exercise(
          id: 'verb_ex3',
          type: ExerciseType.wordPosition,
          question: 'Ordina: "is / He / now / working"',
          options: ['He', 'is', 'working', 'now'],
          correctAnswer: 'He is working now',
          explanation: 'Presente continuo: soggetto + is + verbo-ing + tempo',
        ),
      ],
    );
  }

  // Come usare queste lezioni nel tuo LessonDataService:
  static List<Lesson> getAllCustomLessons() {
    return [
      numbersLesson(),
      foodLesson(),
      actionVerbsLesson(),
    ];
  }
}

/* 
COME INTEGRARE NEL PROGETTO:

1. Aggiungi questo file in: lib/data/services/custom_lessons.dart

2. Modifica lesson_data_service.dart:

import 'custom_lessons.dart';

class LessonDataService {
  static List<Lesson> getLessons() {
    return [
      // Lezioni originali...
      ...CustomLessonsExample.getAllCustomLessons(),
    ];
  }
}

3. Oppure crea un metodo separato per le lezioni personalizzate:

class LessonDataService {
  static List<Lesson> getLessons() {
    // lezioni base
  }
  
  static List<Lesson> getCustomLessons() {
    return CustomLessonsExample.getAllCustomLessons();
  }
  
  static List<Lesson> getAllLessons() {
    return [...getLessons(), ...getCustomLessons()];
  }
}
*/