import 'dart:math' show Random, min;


/// Generator di domande avanzate per quiz multilingua ORA
/// Livelli Intermedio B2 e Avanzato C1/C2 con 26 lingue europee
class QuestionGeneratorV2 {
  final String languageCode;
  final String level;
  final Random random = Random();

  QuestionGeneratorV2(this.languageCode, this.level);

  /// Genera 10 domande casuali basate sul livello
  List<Map<String, dynamic>> generateQuestions() {
    switch (level) {
      case 'Principiante':
        return _generateBeginnerQuestions();
      case 'Elementare':
        return _generateElementaryQuestions();
      case 'Intermedio':
        return _generateIntermediateQuestions();
      case 'Avanzato':
        return _generateAdvancedQuestions();
      default:
        return _generateBeginnerQuestions();
    }
  }

  List<Map<String, dynamic>> _generateBeginnerQuestions() {
    final templates = _getBeginnerTemplates();
    final questions = <Map<String, dynamic>>[];

    // Genera 10 domande uniche (senza ripetizioni)
    final availableIndices = List.generate(templates.length, (i) => i);
    availableIndices.shuffle(random);

    final count = min(10, templates.length);
    for (int i = 0; i < count; i++) {
      questions.add(templates[availableIndices[i]]);
    }

    return questions;
  }

  List<Map<String, dynamic>> _generateElementaryQuestions() {
    final templates = _getElementaryTemplates();
    final questions = <Map<String, dynamic>>[];

    final availableIndices = List.generate(templates.length, (i) => i);
    availableIndices.shuffle(random);

    final count = min(10, templates.length);
    for (int i = 0; i < count; i++) {
      questions.add(templates[availableIndices[i]]);
    }

    return questions;
  }

  List<Map<String, dynamic>> _generateIntermediateQuestions() {
    final templates = _getIntermediateTemplates();
    final questions = <Map<String, dynamic>>[];

    final availableIndices = List.generate(templates.length, (i) => i);
    availableIndices.shuffle(random);

    final count = min(10, templates.length);
    for (int i = 0; i < count; i++) {
      questions.add(templates[availableIndices[i]]);
    }

    return questions;
  }

  List<Map<String, dynamic>> _generateAdvancedQuestions() {
    final templates = _getAdvancedTemplates();
    final questions = <Map<String, dynamic>>[];

    final availableIndices = List.generate(templates.length, (i) => i);
    availableIndices.shuffle(random);

    final count = min(10, templates.length);
    for (int i = 0; i < count; i++) {
      questions.add(templates[availableIndices[i]]);
    }

    return questions;
  }

  // ========================================
  // LIVELLO PRINCIPIANTE
  // ========================================

  List<Map<String, dynamic>> _getBeginnerTemplates() {
    switch (languageCode) {
      case 'en': // Inglese
        return [
          {
            'question': 'How do you say "Hello"?',
            'options': ['Hello', 'Goodbye', 'Please', 'Thank you'],
            'correct': 'Hello',
          },
          {
            'question': 'What is "Good morning"?',
            'options': [
              'Good night',
              'Good morning',
              'Good afternoon',
              'Good evening',
            ],
            'correct': 'Good morning',
          },
          {
            'question': 'How do you say "Thank you"?',
            'options': ['Please', 'Sorry', 'Thank you', 'Welcome'],
            'correct': 'Thank you',
          },
          {
            'question': 'What number is "Five"?',
            'options': ['Three', 'Four', 'Five', 'Six'],
            'correct': 'Five',
          },
          {
            'question': 'What color is "Red"?',
            'options': ['Blue', 'Green', 'Red', 'Yellow'],
            'correct': 'Red',
          },
          {
            'question': 'How do you say "Yes"?',
            'options': ['Yes', 'No', 'Maybe', 'Never'],
            'correct': 'Yes',
          },
          {
            'question': 'What is "Water"?',
            'options': ['Fire', 'Water', 'Air', 'Earth'],
            'correct': 'Water',
          },
          {
            'question': 'How do you say "Goodbye"?',
            'options': ['Hello', 'Goodbye', 'Welcome', 'Thanks'],
            'correct': 'Goodbye',
          },
        ];

      case 'es': // Spagnolo
        return [
          {
            'question': '¿Cómo se dice "Hello"?',
            'options': ['Hola', 'Adiós', 'Por favor', 'Gracias'],
            'correct': 'Hola',
          },
          {
            'question': '¿Qué significa "Buenos días"?',
            'options': [
              'Buenas noches',
              'Buenos días',
              'Buenas tardes',
              'Hola',
            ],
            'correct': 'Buenos días',
          },
          {
            'question': '¿Cómo se dice "Thank you"?',
            'options': ['Por favor', 'Lo siento', 'Gracias', 'De nada'],
            'correct': 'Gracias',
          },
          {
            'question': '¿Qué número es "Cinco"?',
            'options': ['Tres', 'Cuatro', 'Cinco', 'Seis'],
            'correct': 'Cinco',
          },
          {
            'question': '¿Qué color es "Rojo"?',
            'options': ['Azul', 'Verde', 'Rojo', 'Amarillo'],
            'correct': 'Rojo',
          },
          {
            'question': '¿Cómo se dice "Yes"?',
            'options': ['Sí', 'No', 'Quizás', 'Nunca'],
            'correct': 'Sí',
          },
          {
            'question': '¿Qué es "Agua"?',
            'options': ['Fuego', 'Agua', 'Aire', 'Tierra'],
            'correct': 'Agua',
          },
          {
            'question': '¿Cómo se dice "Goodbye"?',
            'options': ['Hola', 'Adiós', 'Bienvenido', 'Gracias'],
            'correct': 'Adiós',
          },
        ];

      case 'fr': // Francese
        return [
          {
            'question': 'Comment dit-on "Hello"?',
            'options': ['Bonjour', 'Au revoir', 'S\'il vous plaît', 'Merci'],
            'correct': 'Bonjour',
          },
          {
            'question': 'Que signifie "Bonne nuit"?',
            'options': [
              'Good night',
              'Good morning',
              'Good afternoon',
              'Hello',
            ],
            'correct': 'Good night',
          },
          {
            'question': 'Comment dit-on "Thank you"?',
            'options': ['S\'il vous plaît', 'Désolé', 'Merci', 'De rien'],
            'correct': 'Merci',
          },
          {
            'question': 'Quel nombre est "Cinq"?',
            'options': ['Trois', 'Quatre', 'Cinq', 'Six'],
            'correct': 'Cinq',
          },
          {
            'question': 'Quelle couleur est "Rouge"?',
            'options': ['Bleu', 'Vert', 'Rouge', 'Jaune'],
            'correct': 'Rouge',
          },
          {
            'question': 'Comment dit-on "Yes"?',
            'options': ['Oui', 'Non', 'Peut-être', 'Jamais'],
            'correct': 'Oui',
          },
          {
            'question': 'Qu\'est-ce que "Eau"?',
            'options': ['Feu', 'Eau', 'Air', 'Terre'],
            'correct': 'Eau',
          },
          {
            'question': 'Comment dit-on "Goodbye"?',
            'options': ['Bonjour', 'Au revoir', 'Bienvenue', 'Merci'],
            'correct': 'Au revoir',
          },
        ];

      case 'de': // Tedesco
        return [
          {
            'question': 'Wie sagt man "Hello"?',
            'options': ['Hallo', 'Auf Wiedersehen', 'Bitte', 'Danke'],
            'correct': 'Hallo',
          },
          {
            'question': 'Was bedeutet "Guten Morgen"?',
            'options': ['Gute Nacht', 'Guten Morgen', 'Guten Tag', 'Hallo'],
            'correct': 'Guten Morgen',
          },
          {
            'question': 'Wie sagt man "Thank you"?',
            'options': ['Bitte', 'Entschuldigung', 'Danke', 'Gern geschehen'],
            'correct': 'Danke',
          },
          {
            'question': 'Welche Zahl ist "Fünf"?',
            'options': ['Drei', 'Vier', 'Fünf', 'Sechs'],
            'correct': 'Fünf',
          },
          {
            'question': 'Welche Farbe ist "Rot"?',
            'options': ['Blau', 'Grün', 'Rot', 'Gelb'],
            'correct': 'Rot',
          },
          {
            'question': 'Wie sagt man "Yes"?',
            'options': ['Ja', 'Nein', 'Vielleicht', 'Niemals'],
            'correct': 'Ja',
          },
          {
            'question': 'Was ist "Wasser"?',
            'options': ['Feuer', 'Wasser', 'Luft', 'Erde'],
            'correct': 'Wasser',
          },
          {
            'question': 'Wie sagt man "Goodbye"?',
            'options': ['Hallo', 'Auf Wiedersehen', 'Willkommen', 'Danke'],
            'correct': 'Auf Wiedersehen',
          },
        ];

      case 'it': // Italiano (default)
      default:
        return [
          {
            'question': 'Come si dice "Hello"?',
            'options': ['Ciao', 'Arrivederci', 'Per favore', 'Grazie'],
            'correct': 'Ciao',
          },
          {
            'question': 'Cosa significa "Buongiorno"?',
            'options': ['Buonanotte', 'Buongiorno', 'Buonasera', 'Ciao'],
            'correct': 'Buongiorno',
          },
          {
            'question': 'Come si dice "Thank you"?',
            'options': ['Per favore', 'Scusa', 'Grazie', 'Prego'],
            'correct': 'Grazie',
          },
          {
            'question': 'Che numero è "Cinque"?',
            'options': ['Tre', 'Quattro', 'Cinque', 'Sei'],
            'correct': 'Cinque',
          },
          {
            'question': 'Che colore è "Rosso"?',
            'options': ['Blu', 'Verde', 'Rosso', 'Giallo'],
            'correct': 'Rosso',
          },
          {
            'question': 'Come si dice "Yes"?',
            'options': ['Sì', 'No', 'Forse', 'Mai'],
            'correct': 'Sì',
          },
          {
            'question': 'Cos\'è "Acqua"?',
            'options': ['Fuoco', 'Acqua', 'Aria', 'Terra'],
            'correct': 'Acqua',
          },
          {
            'question': 'Come si dice "Goodbye"?',
            'options': ['Ciao', 'Arrivederci', 'Benvenuto', 'Grazie'],
            'correct': 'Arrivederci',
          },
        ];
    }
  }

  // ========================================
  // LIVELLO ELEMENTARE
  // ========================================

  List<Map<String, dynamic>> _getElementaryTemplates() {
    switch (languageCode) {
      case 'en':
        return [
          {
            'question': 'I ___ a student.',
            'options': ['am', 'is', 'are', 'be'],
            'correct': 'am',
          },
          {
            'question': 'She ___ to school every day.',
            'options': ['go', 'goes', 'going', 'went'],
            'correct': 'goes',
          },
          {
            'question': 'What is the plural of "child"?',
            'options': ['childs', 'childes', 'children', 'child'],
            'correct': 'children',
          },
          {
            'question': '___ do you live?',
            'options': ['What', 'Where', 'Who', 'When'],
            'correct': 'Where',
          },
          {
            'question': 'I ___ a book yesterday.',
            'options': ['read', 'readed', 'reading', 'reads'],
            'correct': 'read',
          },
          {
            'question': 'They ___ happy.',
            'options': ['am', 'is', 'are', 'be'],
            'correct': 'are',
          },
          {
            'question': 'My brother ___ tall.',
            'options': ['am', 'is', 'are', 'be'],
            'correct': 'is',
          },
          {
            'question': 'We ___ to the park.',
            'options': ['go', 'goes', 'going', 'went'],
            'correct': 'go',
          },
        ];

      case 'es':
        return [
          {
            'question': 'Yo ___ estudiante.',
            'options': ['soy', 'eres', 'es', 'somos'],
            'correct': 'soy',
          },
          {
            'question': 'Ella ___ a la escuela todos los días.',
            'options': ['ir', 'va', 'voy', 'van'],
            'correct': 'va',
          },
          {
            'question': '¿Cuál es el plural de "niño"?',
            'options': ['niñoes', 'niños', 'niñas', 'niño'],
            'correct': 'niños',
          },
          {
            'question': '¿___ vives?',
            'options': ['Qué', 'Dónde', 'Quién', 'Cuándo'],
            'correct': 'Dónde',
          },
          {
            'question': 'Yo ___ un libro ayer.',
            'options': ['leo', 'leí', 'leer', 'leyendo'],
            'correct': 'leí',
          },
          {
            'question': 'Ellos ___ felices.',
            'options': ['soy', 'es', 'son', 'ser'],
            'correct': 'son',
          },
          {
            'question': 'Mi hermano ___ alto.',
            'options': ['soy', 'eres', 'es', 'somos'],
            'correct': 'es',
          },
          {
            'question': 'Nosotros ___ al parque.',
            'options': ['ir', 'va', 'vamos', 'van'],
            'correct': 'vamos',
          },
        ];

      case 'fr':
        return [
          {
            'question': 'Je ___ étudiant.',
            'options': ['suis', 'es', 'est', 'sommes'],
            'correct': 'suis',
          },
          {
            'question': 'Elle ___ à l\'école tous les jours.',
            'options': ['aller', 'va', 'vais', 'vont'],
            'correct': 'va',
          },
          {
            'question': 'Quel est le pluriel de "enfant"?',
            'options': ['enfantes', 'enfants', 'enfant', 'enfantz'],
            'correct': 'enfants',
          },
          {
            'question': '___ habites-tu?',
            'options': ['Quoi', 'Où', 'Qui', 'Quand'],
            'correct': 'Où',
          },
          {
            'question': 'J\'___ un livre hier.',
            'options': ['lis', 'ai lu', 'lire', 'lisant'],
            'correct': 'ai lu',
          },
          {
            'question': 'Ils ___ heureux.',
            'options': ['suis', 'es', 'sont', 'être'],
            'correct': 'sont',
          },
          {
            'question': 'Mon frère ___ grand.',
            'options': ['suis', 'es', 'est', 'sommes'],
            'correct': 'est',
          },
          {
            'question': 'Nous ___ au parc.',
            'options': ['aller', 'va', 'allons', 'vont'],
            'correct': 'allons',
          },
        ];

      case 'de':
        return [
          {
            'question': 'Ich ___ Student.',
            'options': ['bin', 'bist', 'ist', 'sind'],
            'correct': 'bin',
          },
          {
            'question': 'Sie ___ zur Schule jeden Tag.',
            'options': ['gehen', 'geht', 'gehe', 'gegangen'],
            'correct': 'geht',
          },
          {
            'question': 'Was ist der Plural von "Kind"?',
            'options': ['Kinds', 'Kinder', 'Kinden', 'Kind'],
            'correct': 'Kinder',
          },
          {
            'question': '___ wohnst du?',
            'options': ['Was', 'Wo', 'Wer', 'Wann'],
            'correct': 'Wo',
          },
          {
            'question': 'Ich ___ ein Buch gestern.',
            'options': ['lese', 'las', 'lesen', 'gelesen'],
            'correct': 'las',
          },
          {
            'question': 'Sie ___ glücklich.',
            'options': ['bin', 'bist', 'sind', 'sein'],
            'correct': 'sind',
          },
          {
            'question': 'Mein Bruder ___ groß.',
            'options': ['bin', 'bist', 'ist', 'sind'],
            'correct': 'ist',
          },
          {
            'question': 'Wir ___ zum Park.',
            'options': ['gehen', 'geht', 'gehe', 'gegangen'],
            'correct': 'gehen',
          },
        ];

      default:
        return [
          {
            'question': 'Io ___ uno studente.',
            'options': ['sono', 'sei', 'è', 'siamo'],
            'correct': 'sono',
          },
          {
            'question': 'Lei ___ a scuola ogni giorno.',
            'options': ['andare', 'va', 'vado', 'vanno'],
            'correct': 'va',
          },
          {
            'question': 'Qual è il plurale di "libro"?',
            'options': ['libres', 'libri', 'libro', 'libros'],
            'correct': 'libri',
          },
          {
            'question': '___ abiti?',
            'options': ['Cosa', 'Dove', 'Chi', 'Quando'],
            'correct': 'Dove',
          },
          {
            'question': 'Io ___ un libro ieri.',
            'options': ['leggo', 'ho letto', 'leggere', 'leggendo'],
            'correct': 'ho letto',
          },
          {
            'question': 'Loro ___ felici.',
            'options': ['sono', 'è', 'siamo', 'essere'],
            'correct': 'sono',
          },
          {
            'question': 'Mio fratello ___ alto.',
            'options': ['sono', 'sei', 'è', 'siamo'],
            'correct': 'è',
          },
          {
            'question': 'Noi ___ al parco.',
            'options': ['andare', 'va', 'andiamo', 'vanno'],
            'correct': 'andiamo',
          },
        ];
    }
  }

  // ========================================
  // LIVELLO INTERMEDIO
  // ========================================

  List<Map<String, dynamic>> _getIntermediateTemplates() {
    switch (languageCode) {
      case 'en':
        return [
          {
            'question': 'If I ___ rich, I would travel the world.',
            'options': ['am', 'was', 'were', 'be'],
            'correct': 'were',
          },
          {
            'question': 'She has been working here ___ five years.',
            'options': ['since', 'for', 'during', 'while'],
            'correct': 'for',
          },
          {
            'question': 'The book ___ by millions of people.',
            'options': ['was read', 'is reading', 'has reading', 'read'],
            'correct': 'was read',
          },
          {
            'question': 'I wish I ___ speak five languages.',
            'options': ['can', 'could', 'will', 'would'],
            'correct': 'could',
          },
          {
            'question': 'By next year, I ___ my degree.',
            'options': [
              'complete',
              'will complete',
              'will have completed',
              'completing',
            ],
            'correct': 'will have completed',
          },
        ];

      case 'es':
        return [
          {
            'question': 'Si ___ rico, viajaría por el mundo.',
            'options': ['soy', 'era', 'fuera', 'ser'],
            'correct': 'fuera',
          },
          {
            'question': 'Ella ha estado trabajando aquí ___ cinco años.',
            'options': ['desde', 'por', 'durante', 'mientras'],
            'correct': 'durante',
          },
          {
            'question': 'El libro ___ por millones de personas.',
            'options': ['fue leído', 'está leyendo', 'ha leyendo', 'leer'],
            'correct': 'fue leído',
          },
          {
            'question': 'Ojalá ___ hablar cinco idiomas.',
            'options': ['puedo', 'pudiera', 'pueda', 'poder'],
            'correct': 'pudiera',
          },
          {
            'question': 'Para el próximo año, ___ mi título.',
            'options': [
              'completo',
              'completaré',
              'habré completado',
              'completando',
            ],
            'correct': 'habré completado',
          },
        ];

      case 'fr':
        return [
          {
            'question': 'Si j\'___ riche, je voyagerais dans le monde.',
            'options': ['suis', 'étais', 'serais', 'être'],
            'correct': 'étais',
          },
          {
            'question': 'Elle travaille ici ___ cinq ans.',
            'options': ['depuis', 'pour', 'pendant', 'tandis'],
            'correct': 'depuis',
          },
          {
            'question': 'Le livre ___ par des millions de personnes.',
            'options': ['a été lu', 'est en train de lire', 'a lisant', 'lire'],
            'correct': 'a été lu',
          },
          {
            'question': 'J\'aimerais ___ parler cinq langues.',
            'options': ['peux', 'pouvais', 'pouvoir', 'pu'],
            'correct': 'pouvoir',
          },
          {
            'question': 'L\'année prochaine, j\'___ mon diplôme.',
            'options': ['obtiens', 'obtiendrai', 'aurai obtenu', 'obtenant'],
            'correct': 'aurai obtenu',
          },
        ];

      case 'de':
        return [
          {
            'question': 'Wenn ich reich ___, würde ich um die Welt reisen.',
            'options': ['bin', 'war', 'wäre', 'sein'],
            'correct': 'wäre',
          },
          {
            'question': 'Sie arbeitet hier ___ fünf Jahren.',
            'options': ['seit', 'für', 'während', 'als'],
            'correct': 'seit',
          },
          {
            'question': 'Das Buch ___ von Millionen Menschen gelesen.',
            'options': ['wurde', 'liest', 'hat gelesen', 'lesen'],
            'correct': 'wurde',
          },
          {
            'question': 'Ich wünschte, ich ___ fünf Sprachen sprechen.',
            'options': ['kann', 'könnte', 'werde', 'würde'],
            'correct': 'könnte',
          },
          {
            'question': 'Nächstes Jahr ___ ich meinen Abschluss gemacht haben.',
            'options': [
              'mache',
              'werde machen',
              'werde gemacht haben',
              'machend',
            ],
            'correct': 'werde gemacht haben',
          },
        ];

      default:
        return [
          {
            'question': 'Se ___ ricco, viaggerei per il mondo.',
            'options': ['sono', 'ero', 'fossi', 'essere'],
            'correct': 'fossi',
          },
          {
            'question': 'Lei lavora qui ___ cinque anni.',
            'options': ['da', 'per', 'durante', 'mentre'],
            'correct': 'da',
          },
          {
            'question': 'Il libro ___ da milioni di persone.',
            'options': [
              'è stato letto',
              'sta leggendo',
              'ha leggendo',
              'leggere',
            ],
            'correct': 'è stato letto',
          },
          {
            'question': 'Vorrei ___ parlare cinque lingue.',
            'options': ['posso', 'potessi', 'potere', 'potuto'],
            'correct': 'potere',
          },
          {
            'question': 'L\'anno prossimo, ___ la mia laurea.',
            'options': [
              'completo',
              'completerò',
              'avrò completato',
              'completando',
            ],
            'correct': 'avrò completato',
          },
        ];
    }
  }

  // ========================================
  // LIVELLO AVANZATO
  // ========================================

  List<Map<String, dynamic>> _getAdvancedTemplates() {
    switch (languageCode) {
      case 'en':
        return [
          {
            'question': 'Had I known about the meeting, I ___ attended.',
            'options': ['would have', 'will have', 'would', 'will'],
            'correct': 'would have',
          },
          {
            'question': 'The proposal was rejected, ___ its merits.',
            'options': ['despite', 'although', 'however', 'moreover'],
            'correct': 'despite',
          },
          {
            'question': 'She is accustomed ___ late.',
            'options': ['to work', 'to working', 'work', 'working'],
            'correct': 'to working',
          },
          {
            'question': 'Not only ___ the exam, but she got the highest score.',
            'options': [
              'she passed',
              'did she pass',
              'she did pass',
              'passed she',
            ],
            'correct': 'did she pass',
          },
          {
            'question':
                'The subtleties of the argument ___ lost on the audience.',
            'options': ['was', 'were', 'is', 'are'],
            'correct': 'were',
          },
        ];

      case 'es':
        return [
          {
            'question': 'Si hubiera sabido de la reunión, ___ asistido.',
            'options': ['habría', 'habré', 'había', 'he'],
            'correct': 'habría',
          },
          {
            'question': 'La propuesta fue rechazada, ___ sus méritos.',
            'options': ['a pesar de', 'aunque', 'sin embargo', 'además'],
            'correct': 'a pesar de',
          },
          {
            'question': 'Ella está acostumbrada ___ tarde.',
            'options': ['a trabajar', 'de trabajar', 'trabajar', 'trabajando'],
            'correct': 'a trabajar',
          },
          {
            'question':
                'No solo ___ el examen, sino que obtuvo la nota más alta.',
            'options': ['aprobó', 'aprobó ella', 'ella aprobó', 'ha aprobado'],
            'correct': 'aprobó',
          },
          {
            'question':
                'Las sutilezas del argumento ___ perdidas para la audiencia.',
            'options': ['fue', 'fueron', 'es', 'son'],
            'correct': 'fueron',
          },
        ];

      case 'fr':
        return [
          {
            'question': 'Si j\'avais su pour la réunion, j\'y ___ assisté.',
            'options': ['aurais', 'aurai', 'avais', 'ai'],
            'correct': 'aurais',
          },
          {
            'question': 'La proposition a été rejetée, ___ ses mérites.',
            'options': ['malgré', 'bien que', 'cependant', 'de plus'],
            'correct': 'malgré',
          },
          {
            'question': 'Elle est habituée ___ tard.',
            'options': [
              'à travailler',
              'de travailler',
              'travailler',
              'travaillant',
            ],
            'correct': 'à travailler',
          },
          {
            'question':
                'Non seulement elle ___ l\'examen, mais elle a eu la meilleure note.',
            'options': ['a réussi', 'réussit', 'avait réussi', 'réussissait'],
            'correct': 'a réussi',
          },
          {
            'question': 'Les subtilités de l\'argument ___ échappé au public.',
            'options': ['a', 'ont', 'est', 'sont'],
            'correct': 'ont',
          },
        ];

      case 'de':
        return [
          {
            'question':
                'Hätte ich von dem Treffen gewusst, ___ ich teilgenommen.',
            'options': ['hätte', 'werde', 'würde', 'habe'],
            'correct': 'hätte',
          },
          {
            'question': 'Der Vorschlag wurde abgelehnt, ___ seiner Verdienste.',
            'options': ['trotz', 'obwohl', 'jedoch', 'außerdem'],
            'correct': 'trotz',
          },
          {
            'question': 'Sie ist daran gewöhnt, spät ___.',
            'options': ['zu arbeiten', 'arbeiten', 'gearbeitet', 'arbeitend'],
            'correct': 'zu arbeiten',
          },
          {
            'question':
                'Nicht nur ___ sie die Prüfung, sondern sie bekam die beste Note.',
            'options': [
              'bestand',
              'bestand sie',
              'sie bestand',
              'hat bestanden',
            ],
            'correct': 'bestand sie',
          },
          {
            'question':
                'Die Feinheiten des Arguments ___ dem Publikum entgangen.',
            'options': ['ist', 'sind', 'war', 'waren'],
            'correct': 'waren',
          },
        ];

      default:
        return [
          {
            'question': 'Se avessi saputo della riunione, ci ___ partecipato.',
            'options': ['avrei', 'avrò', 'avevo', 'ho'],
            'correct': 'avrei',
          },
          {
            'question': 'La proposta è stata respinta, ___ i suoi meriti.',
            'options': ['nonostante', 'sebbene', 'tuttavia', 'inoltre'],
            'correct': 'nonostante',
          },
          {
            'question': 'Lei è abituata ___ tardi.',
            'options': ['a lavorare', 'di lavorare', 'lavorare', 'lavorando'],
            'correct': 'a lavorare',
          },
          {
            'question':
                'Non solo ___ l\'esame, ma ha ottenuto il voto più alto.',
            'options': ['ha superato', 'superò', 'aveva superato', 'superava'],
            'correct': 'ha superato',
          },
          {
            'question':
                'Le sottigliezze dell\'argomento ___ sfuggite al pubblico.',
            'options': ['è', 'sono', 'era', 'erano'],
            'correct': 'sono',
          },
        ];
    }
  }
}

// ========================================
// ESTENSIONE PER ALTRE LINGUE EUROPEE
// ========================================

/// Helper per generare domande base per lingue con meno template
/// Questo può essere espanso in futuro con più domande specifiche per lingua
class LanguageTemplateHelper {
  /// Genera template di base per lingue non ancora completamente supportate
  static List<Map<String, dynamic>> getBasicBeginnerTemplates(
    String languageCode,
  ) {
    // Template generico che può essere tradotto
    return [
      {
        'question': 'Basic greeting',
        'options': ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
        'correct': 'Option 1',
      },
      {
        'question': 'Basic farewell',
        'options': ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
        'correct': 'Option 2',
      },
      {
        'question': 'Thank you',
        'options': ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
        'correct': 'Option 3',
      },
      {
        'question': 'Yes/No',
        'options': ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
        'correct': 'Option 1',
      },
      {
        'question': 'Numbers 1-10',
        'options': ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
        'correct': 'Option 2',
      },
    ];
  }
}

/// Statistiche e metadata per ogni lingua
class LanguageMetadata {
  final String code;
  final String name;
  final String flag;
  final int beginnerQuestions;
  final int elementaryQuestions;
  final int intermediateQuestions;
  final int advancedQuestions;

  const LanguageMetadata({
    required this.code,
    required this.name,
    required this.flag,
    required this.beginnerQuestions,
    required this.elementaryQuestions,
    required this.intermediateQuestions,
    required this.advancedQuestions,
  });

  int get totalQuestions =>
      beginnerQuestions +
      elementaryQuestions +
      intermediateQuestions +
      advancedQuestions;
}

/// Database metadata per tutte le lingue ORA
class OraLanguagesDatabase {
  static const languages = [
    LanguageMetadata(
      code: 'it',
      name: 'Italiano',
      flag: '🇮🇹',
      beginnerQuestions: 8,
      elementaryQuestions: 8,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'en',
      name: 'Inglese',
      flag: '🇬🇧',
      beginnerQuestions: 8,
      elementaryQuestions: 8,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'es',
      name: 'Spagnolo',
      flag: '🇪🇸',
      beginnerQuestions: 8,
      elementaryQuestions: 8,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'fr',
      name: 'Francese',
      flag: '🇫🇷',
      beginnerQuestions: 8,
      elementaryQuestions: 8,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'de',
      name: 'Tedesco',
      flag: '🇩🇪',
      beginnerQuestions: 8,
      elementaryQuestions: 8,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),

    // Altre lingue europee (da espandere con più domande)
    LanguageMetadata(
      code: 'ru',
      name: 'Russo',
      flag: '🇷🇺',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'zh',
      name: 'Cinese',
      flag: '🇨🇳',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'nl',
      name: 'Olandese',
      flag: '🇳🇱',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'cs',
      name: 'Ceco',
      flag: '🇨🇿',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'bg',
      name: 'Bulgaro',
      flag: '🇧🇬',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'hr',
      name: 'Croato',
      flag: '🇭🇷',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'da',
      name: 'Danese',
      flag: '🇩🇰',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'et',
      name: 'Estone',
      flag: '🇪🇪',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'fi',
      name: 'Finlandese',
      flag: '🇫🇮',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'el',
      name: 'Greco',
      flag: '🇬🇷',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'ga',
      name: 'Irlandese',
      flag: '🇮🇪',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'lv',
      name: 'Lettone',
      flag: '🇱🇻',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'lt',
      name: 'Lituano',
      flag: '🇱🇹',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'mt',
      name: 'Maltese',
      flag: '🇲🇹',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'pl',
      name: 'Polacco',
      flag: '🇵🇱',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'pt',
      name: 'Portoghese',
      flag: '🇵🇹',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'ro',
      name: 'Rumeno',
      flag: '🇷🇴',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'sk',
      name: 'Slovacco',
      flag: '🇸🇰',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'sl',
      name: 'Sloveno',
      flag: '🇸🇮',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'sv',
      name: 'Svedese',
      flag: '🇸🇪',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
    LanguageMetadata(
      code: 'hu',
      name: 'Ungherese',
      flag: '🇭🇺',
      beginnerQuestions: 5,
      elementaryQuestions: 5,
      intermediateQuestions: 5,
      advancedQuestions: 5,
    ),
  ];

  /// Ottieni metadata per una specifica lingua
  static LanguageMetadata? getLanguageMetadata(String code) {
    try {
      return languages.firstWhere((lang) => lang.code == code);
    } catch (e) {
      return null;
    }
  }

  /// Verifica se una lingua è completamente supportata (tutti i livelli)
  static bool isFullySupported(String code) {
    final metadata = getLanguageMetadata(code);
    if (metadata == null) return false;

    return metadata.beginnerQuestions >= 8 &&
        metadata.elementaryQuestions >= 8 &&
        metadata.intermediateQuestions >= 5 &&
        metadata.advancedQuestions >= 5;
  }

  /// Ottieni lista lingue completamente supportate
  static List<LanguageMetadata> getFullySupportedLanguages() {
    return languages
        .where(
          (lang) =>
              lang.beginnerQuestions >= 8 &&
              lang.elementaryQuestions >= 8 &&
              lang.intermediateQuestions >= 5 &&
              lang.advancedQuestions >= 5,
        )
        .toList();
  }
}

/// Utilità per statistiche e debugging
extension QuestionGeneratorStats on QuestionGeneratorV2 {
  /// Ottieni numero totale di domande disponibili per il livello corrente
  int getTotalQuestionsAvailable() {
    List<Map<String, dynamic>> templates;

    switch (level) {
      case 'Principiante':
        templates = _getBeginnerTemplates();
        break;
      case 'Elementare':
        templates = _getElementaryTemplates();
        break;
      case 'Intermedio':
        templates = _getIntermediateTemplates();
        break;
      case 'Avanzato':
        templates = _getAdvancedTemplates();
        break;
      default:
        templates = _getBeginnerTemplates();
    }

    return templates.length;
  }

  /// Verifica se ci sono abbastanza domande per un quiz completo
  bool hasEnoughQuestions() {
    return getTotalQuestionsAvailable() >= 10;
  }
}
