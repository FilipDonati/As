import 'package:login_ora/data/models/language_model.dart';

class LessonDataService {
  static List<Lesson> getLessons() {
    return [
      Lesson(
        id: 'lesson_1',
        title: 'Saluti e Presentazioni',
        description: 'Impara i saluti di base e come presentarti',
        level: 1,
        category: 'Base',
        vocabulary: [
          Vocabulary(
            word: 'Hello',
            translation: 'Ciao',
            pronunciation: '/həˈloʊ/',
            example: 'Hello! How are you?',
          ),
          Vocabulary(
            word: 'Good morning',
            translation: 'Buongiorno',
            pronunciation: '/ɡʊd ˈmɔːrnɪŋ/',
            example: 'Good morning, everyone!',
          ),
          Vocabulary(
            word: 'Thank you',
            translation: 'Grazie',
            pronunciation: '/θæŋk juː/',
            example: 'Thank you very much!',
          ),
          Vocabulary(
            word: 'Goodbye',
            translation: 'Arrivederci',
            pronunciation: '/ɡʊdˈbaɪ/',
            example: 'Goodbye! See you tomorrow.',
          ),
          Vocabulary(
            word: 'My name is',
            translation: 'Mi chiamo',
            pronunciation: '/maɪ neɪm ɪz/',
            example: 'My name is Marco.',
          ),
        ],
        grammar: [
          GrammarLesson(
            title: 'Pronomi Personali',
            description: 'I pronomi personali soggetto in inglese',
            category: 'Grammatica Base',
            rule: 'I, You, He, She, It, We, You, They',
            examples: [
              'I am a student - Io sono uno studente',
              'You are my friend - Tu sei mio amico',
              'He is tall - Lui è alto',
              'She is beautiful - Lei è bella',
              'We are happy - Noi siamo felici',
            ],
          ),
          GrammarLesson(
            title: 'Verbo "To Be" - Presente',
            description: 'Come usare il verbo essere al presente',
            category: 'Verbi',
            rule: 'I am, You are, He/She/It is, We are, They are',
            examples: [
              'I am tired - Sono stanco',
              'You are right - Hai ragione',
              'It is cold today - Oggi fa freddo',
            ],
          ),
        ],
        exercises: [
          Exercise(
            id: 'ex1',
            type: ExerciseType.fillInTheBlank,
            question: '_____ morning! How are you?',
            options: ['Good', 'Bad', 'Night', 'Evening'],
            correctAnswer: 'Good',
            explanation: '"Good morning" è il saluto corretto per la mattina',
          ),
          Exercise(
            id: 'ex2',
            type: ExerciseType.wordPosition,
            question: 'Metti le parole nell\'ordine corretto: "name / is / My / John"',
            options: ['My', 'name', 'is', 'John'],
            correctAnswer: 'My name is John',
            explanation: 'L\'ordine corretto è: soggetto + verbo + complemento',
          ),
          Exercise(
            id: 'ex3',
            type: ExerciseType.multipleChoice,
            question: 'Come si dice "Grazie" in inglese?',
            options: ['Please', 'Thank you', 'Sorry', 'Welcome'],
            correctAnswer: 'Thank you',
          ),
          Exercise(
            id: 'ex4',
            type: ExerciseType.fillInTheBlank,
            question: 'I _____ happy today.',
            options: ['am', 'is', 'are', 'be'],
            correctAnswer: 'am',
            explanation: 'Con "I" si usa sempre "am"',
          ),
        ],
      ),
      Lesson(
        id: 'lesson_2',
        title: 'La Famiglia',
        description: 'Vocaboli e frasi sulla famiglia',
        level: 1,
        category: 'Base',
        vocabulary: [
          Vocabulary(
            word: 'Mother',
            translation: 'Madre',
            pronunciation: '/ˈmʌðər/',
            example: 'My mother is kind.',
          ),
          Vocabulary(
            word: 'Father',
            translation: 'Padre',
            pronunciation: '/ˈfɑːðər/',
            example: 'My father works in a hospital.',
          ),
          Vocabulary(
            word: 'Sister',
            translation: 'Sorella',
            pronunciation: '/ˈsɪstər/',
            example: 'I have one sister.',
          ),
          Vocabulary(
            word: 'Brother',
            translation: 'Fratello',
            pronunciation: '/ˈbrʌðər/',
            example: 'My brother is younger than me.',
          ),
        ],
        grammar: [
          GrammarLesson(
            title: 'Aggettivi Possessivi',
            description: 'Come indicare il possesso',
            category: 'Grammatica',
            rule: 'my, your, his, her, its, our, their',
            examples: [
              'My family is big - La mia famiglia è grande',
              'Your mother is nice - Tua madre è simpatica',
              'His brother is tall - Suo fratello è alto',
            ],
          ),
        ],
        exercises: [
          Exercise(
            id: 'ex5',
            type: ExerciseType.fillInTheBlank,
            question: '_____ mother is a teacher.',
            options: ['My', 'Me', 'I', 'Mine'],
            correctAnswer: 'My',
          ),
          Exercise(
            id: 'ex6',
            type: ExerciseType.wordPosition,
            question: 'Ordina: "sister / My / young / is"',
            options: ['My', 'sister', 'is', 'young'],
            correctAnswer: 'My sister is young',
          ),
        ],
      ),
      Lesson(
        id: 'lesson_3',
        title: 'Numeri e Colori',
        description: 'Impara i numeri da 1 a 100 e i colori principali',
        level: 1,
        category: 'Base',
        vocabulary: [
          Vocabulary(
            word: 'One',
            translation: 'Uno',
            pronunciation: '/wʌn/',
            example: 'I have one apple.',
          ),
          Vocabulary(
            word: 'Red',
            translation: 'Rosso',
            pronunciation: '/red/',
            example: 'The apple is red.',
          ),
          Vocabulary(
            word: 'Blue',
            translation: 'Blu',
            pronunciation: '/bluː/',
            example: 'The sky is blue.',
          ),
        ],
        grammar: [],
        exercises: [
          Exercise(
            id: 'ex7',
            type: ExerciseType.multipleChoice,
            question: 'Qual è il colore del cielo?',
            options: ['Red', 'Blue', 'Green', 'Yellow'],
            correctAnswer: 'Blue',
          ),
        ],
      ),
    ];
  }
}