import 'dart:math';

class QuestionGenerator {
  final String languageCode;
  final String level;
  final Random random = Random();

  QuestionGenerator(this.languageCode, this.level);

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
    
    for (int i = 0; i < 10; i++) {
      final template = templates[random.nextInt(templates.length)];
      questions.add(template);
    }
    
    return questions;
  }

  List<Map<String, dynamic>> _generateElementaryQuestions() {
    final templates = _getElementaryTemplates();
    final questions = <Map<String, dynamic>>[];
    
    for (int i = 0; i < 10; i++) {
      final template = templates[random.nextInt(templates.length)];
      questions.add(template);
    }
    
    return questions;
  }

  List<Map<String, dynamic>> _generateIntermediateQuestions() {
    final templates = _getIntermediateTemplates();
    final questions = <Map<String, dynamic>>[];
    
    for (int i = 0; i < 10; i++) {
      final template = templates[random.nextInt(templates.length)];
      questions.add(template);
    }
    
    return questions;
  }

  List<Map<String, dynamic>> _generateAdvancedQuestions() {
    final templates = _getAdvancedTemplates();
    final questions = <Map<String, dynamic>>[];
    
    for (int i = 0; i < 10; i++) {
      final template = templates[random.nextInt(templates.length)];
      questions.add(template);
    }
    
    return questions;
  }

  List<Map<String, dynamic>> _getBeginnerTemplates() {
    switch (languageCode) {
      case 'en':
        return [
          {
            'question': 'How do you say "Hello"?',
            'options': ['Hello', 'Goodbye', 'Please', 'Thank you'],
            'correct': 'Hello',
          },
          {
            'question': 'What is "Good morning"?',
            'options': ['Good night', 'Good morning', 'Good afternoon', 'Good evening'],
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
        ];
      case 'es':
        return [
          {
            'question': 'Â¿CÃ³mo se dice "Hello"?',
            'options': ['Hola', 'AdiÃ³s', 'Por favor', 'Gracias'],
            'correct': 'Hola',
          },
          {
            'question': 'Â¿QuÃ© significa "Buenos dÃ­as"?',
            'options': ['Buenas noches', 'Buenos dÃ­as', 'Buenas tardes', 'Hola'],
            'correct': 'Buenos dÃ­as',
          },
          {
            'question': 'Â¿CÃ³mo se dice "Thank you"?',
            'options': ['Por favor', 'Lo siento', 'Gracias', 'De nada'],
            'correct': 'Gracias',
          },
          {
            'question': 'Â¿QuÃ© nÃºmero es "Cinco"?',
            'options': ['Tres', 'Cuatro', 'Cinco', 'Seis'],
            'correct': 'Cinco',
          },
          {
            'question': 'Â¿QuÃ© color es "Rojo"?',
            'options': ['Azul', 'Verde', 'Rojo', 'Amarillo'],
            'correct': 'Rojo',
          },
        ];
      case 'fr':
        return [
          {
            'question': 'Comment dit-on "Hello"?',
            'options': ['Bonjour', 'Au revoir', 'S\'il vous plaÃ®t', 'Merci'],
            'correct': 'Bonjour',
          },
          {
            'question': 'Que signifie "Bonne nuit"?',
            'options': ['Good night', 'Good morning', 'Good afternoon', 'Hello'],
            'correct': 'Good night',
          },
          {
            'question': 'Comment dit-on "Thank you"?',
            'options': ['S\'il vous plaÃ®t', 'DÃ©solÃ©', 'Merci', 'De rien'],
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
        ];
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
            'question': 'Che numero Ã¨ "Cinque"?',
            'options': ['Tre', 'Quattro', 'Cinque', 'Sei'],
            'correct': 'Cinque',
          },
          {
            'question': 'Che colore Ã¨ "Rosso"?',
            'options': ['Blu', 'Verde', 'Rosso', 'Giallo'],
            'correct': 'Rosso',
          },
        ];
    }
  }

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
        ];
      case 'es':
        return [
          {
            'question': 'Yo ___ estudiante.',
            'options': ['soy', 'eres', 'es', 'somos'],
            'correct': 'soy',
          },
          {
            'question': 'Ella ___ a la escuela todos los dÃ­as.',
            'options': ['ir', 'va', 'voy', 'van'],
            'correct': 'va',
          },
          {
            'question': 'Â¿CuÃ¡l es el plural de "niÃ±o"?',
            'options': ['niÃ±oes', 'niÃ±os', 'niÃ±as', 'niÃ±o'],
            'correct': 'niÃ±os',
          },
          {
            'question': 'Â¿___ vives?',
            'options': ['QuÃ©', 'DÃ³nde', 'QuiÃ©n', 'CuÃ¡ndo'],
            'correct': 'DÃ³nde',
          },
          {
            'question': 'Yo ___ un libro ayer.',
            'options': ['leo', 'leÃ­', 'leer', 'leyendo'],
            'correct': 'leÃ­',
          },
        ];
      case 'fr':
        return [
          {
            'question': 'Je ___ Ã©tudiant.',
            'options': ['suis', 'es', 'est', 'sommes'],
            'correct': 'suis',
          },
          {
            'question': 'Elle ___ Ã  l\'Ã©cole tous les jours.',
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
            'options': ['Quoi', 'OÃ¹', 'Qui', 'Quand'],
            'correct': 'OÃ¹',
          },
          {
            'question': 'J\'___ un livre hier.',
            'options': ['lis', 'ai lu', 'lire', 'lisant'],
            'correct': 'ai lu',
          },
        ];
      default:
        return [
          {
            'question': 'Io ___ uno studente.',
            'options': ['sono', 'sei', 'Ã¨', 'siamo'],
            'correct': 'sono',
          },
          {
            'question': 'Lei ___ a scuola ogni giorno.',
            'options': ['andare', 'va', 'vado', 'vanno'],
            'correct': 'va',
          },
          {
            'question': 'Qual Ã¨ il plurale di "libro"?',
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
        ];
    }
  }

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
            'options': ['complete', 'will complete', 'will have completed', 'completing'],
            'correct': 'will have completed',
          },
        ];
      case 'es':
        return [
          {
            'question': 'Si ___ rico, viajarÃ­a por el mundo.',
            'options': ['soy', 'era', 'fuera', 'ser'],
            'correct': 'fuera',
          },
          {
            'question': 'Ella ha estado trabajando aquÃ­ ___ cinco aÃ±os.',
            'options': ['desde', 'por', 'durante', 'mientras'],
            'correct': 'durante',
          },
          {
            'question': 'El libro ___ por millones de personas.',
            'options': ['fue leÃ­do', 'estÃ¡ leyendo', 'ha leyendo', 'leer'],
            'correct': 'fue leÃ­do',
          },
          {
            'question': 'OjalÃ¡ ___ hablar cinco idiomas.',
            'options': ['puedo', 'pudiera', 'pueda', 'poder'],
            'correct': 'pudiera',
          },
          {
            'question': 'Para el prÃ³ximo aÃ±o, ___ mi tÃ­tulo.',
            'options': ['completo', 'completarÃ©', 'habrÃ© completado', 'completando'],
            'correct': 'habrÃ© completado',
          },
        ];
      case 'fr':
        return [
          {
            'question': 'Si j\'___ riche, je voyagerais dans le monde.',
            'options': ['suis', 'Ã©tais', 'serais', 'Ãªtre'],
            'correct': 'Ã©tais',
          },
          {
            'question': 'Elle travaille ici ___ cinq ans.',
            'options': ['depuis', 'pour', 'pendant', 'tandis'],
            'correct': 'depuis',
          },
          {
            'question': 'Le livre ___ par des millions de personnes.',
            'options': ['a Ã©tÃ© lu', 'est en train de lire', 'a lisant', 'lire'],
            'correct': 'a Ã©tÃ© lu',
          },
          {
            'question': 'J\'aimerais ___ parler cinq langues.',
            'options': ['peux', 'pouvais', 'pouvoir', 'pu'],
            'correct': 'pouvoir',
          },
          {
            'question': 'L\'annÃ©e prochaine, j\'___ mon diplÃ´me.',
            'options': ['obtiens', 'obtiendrai', 'aurai obtenu', 'obtenant'],
            'correct': 'aurai obtenu',
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
            'options': ['Ã¨ stato letto', 'sta leggendo', 'ha leggendo', 'leggere'],
            'correct': 'Ã¨ stato letto',
          },
          {
            'question': 'Vorrei ___ parlare cinque lingue.',
            'options': ['posso', 'potessi', 'potere', 'potuto'],
            'correct': 'potere',
          },
          {
            'question': 'L\'anno prossimo, ___ la mia laurea.',
            'options': ['completo', 'completerÃ²', 'avrÃ² completato', 'completando'],
            'correct': 'avrÃ² completato',
          },
        ];
    }
  }

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
            'options': ['she passed', 'did she pass', 'she did pass', 'passed she'],
            'correct': 'did she pass',
          },
          {
            'question': 'The subtleties of the argument ___ lost on the audience.',
            'options': ['was', 'were', 'is', 'are'],
            'correct': 'were',
          },
        ];
      case 'es':
        return [
          {
            'question': 'Si hubiera sabido de la reuniÃ³n, ___ asistido.',
            'options': ['habrÃ­a', 'habrÃ©', 'habÃ­a', 'he'],
            'correct': 'habrÃ­a',
          },
          {
            'question': 'La propuesta fue rechazada, ___ sus mÃ©ritos.',
            'options': ['a pesar de', 'aunque', 'sin embargo', 'ademÃ¡s'],
            'correct': 'a pesar de',
          },
          {
            'question': 'Ella estÃ¡ acostumbrada ___ tarde.',
            'options': ['a trabajar', 'de trabajar', 'trabajar', 'trabajando'],
            'correct': 'a trabajar',
          },
          {
            'question': 'No solo ___ el examen, sino que obtuvo la nota mÃ¡s alta.',
            'options': ['aprobÃ³', 'aprobÃ³ ella', 'ella aprobÃ³', 'ha aprobado'],
            'correct': 'aprobÃ³',
          },
          {
            'question': 'Las sutilezas del argumento ___ perdidas para la audiencia.',
            'options': ['fue', 'fueron', 'es', 'son'],
            'correct': 'fueron',
          },
        ];
      case 'fr':
        return [
          {
            'question': 'Si j\'avais su pour la rÃ©union, j\'y ___ assistÃ©.',
            'options': ['aurais', 'aurai', 'avais', 'ai'],
            'correct': 'aurais',
          },
          {
            'question': 'La proposition a Ã©tÃ© rejetÃ©e, ___ ses mÃ©rites.',
            'options': ['malgrÃ©', 'bien que', 'cependant', 'de plus'],
            'correct': 'malgrÃ©',
          },
          {
            'question': 'Elle est habituÃ©e ___ tard.',
            'options': ['Ã  travailler', 'de travailler', 'travailler', 'travaillant'],
            'correct': 'Ã  travailler',
          },
          {
            'question': 'Non seulement elle ___ l\'examen, mais elle a eu la meilleure note.',
            'options': ['a rÃ©ussi', 'rÃ©ussit', 'avait rÃ©ussi', 'rÃ©ussissait'],
            'correct': 'a rÃ©ussi',
          },
          {
            'question': 'Les subtilitÃ©s de l\'argument ___ Ã©chappÃ© au public.',
            'options': ['a', 'ont', 'est', 'sont'],
            'correct': 'ont',
          },
        ];
      default:
        return [
          {
            'question': 'Se avessi saputo della riunione, ci ___ partecipato.',
            'options': ['avrei', 'avrÃ²', 'avevo', 'ho'],
            'correct': 'avrei',
          },
          {
            'question': 'La proposta Ã¨ stata respinta, ___ i suoi meriti.',
            'options': ['nonostante', 'sebbene', 'tuttavia', 'inoltre'],
            'correct': 'nonostante',
          },
          {
            'question': 'Lei Ã¨ abituata ___ tardi.',
            'options': ['a lavorare', 'di lavorare', 'lavorare', 'lavorando'],
            'correct': 'a lavorare',
          },
          {
            'question': 'Non solo ___ l\'esame, ma ha ottenuto il voto piÃ¹ alto.',
            'options': ['ha superato', 'superÃ²', 'aveva superato', 'superava'],
            'correct': 'ha superato',
          },
          {
            'question': 'Le sottigliezze dell\'argomento ___ sfuggite al pubblico.',
            'options': ['Ã¨', 'sono', 'era', 'erano'],
            'correct': 'sono',
          },
        ];
    }
  }
}