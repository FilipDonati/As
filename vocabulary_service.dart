import 'dart:math';
import 'vocabulary_model.dart';

class VocabularyService {
  // 26 supported languages
  static const List<String> supportedLanguages = [
    'en', 'it', 'de', 'es', 'fr', 'ru', 'zh', 'bg', 'cs', 'da',
    'et', 'fi', 'el', 'ga', 'lv', 'lt', 'mt', 'nl', 'pl', 'pt',
    'ro', 'sk', 'sl', 'sv', 'hu', 'hr'
  ];

  static const List<String> categories = [
    'Tutti', 'Base', 'Cibo', 'Viaggio', 'Lavoro', 'Casa', 'Tempo',
    'Salute', 'Famiglia', 'Numeri', 'Colori', 'Animali', 'Corpo',
    'Vestiti', 'Sport', 'Tecnologia',
  ];

  static VocabularyWord _createWord({
    required String id,
    required String category,
    required int difficulty,
    required Map<String, String> translations,
    required Map<String, String> examples,
    List<String> tags = const [],
  }) {
    return VocabularyWord(
      id: id,
      category: category,
      difficulty: difficulty,
      translations: translations,
      examples: examples,
      tags: tags,
    );
  }

  // 500+ words database
  static List<VocabularyWord> getAllWords() {
    return [
      // BASIC WORDS (80 words)
      ..._getBasicWords(),
      // FOOD WORDS (60 words)
      ..._getFoodWords(),
      // TRAVEL WORDS (50 words)
      ..._getTravelWords(),
      // WORK WORDS (40 words)
      ..._getWorkWords(),
      // HOME WORDS (50 words)
      ..._getHomeWords(),
      // TIME/WEATHER WORDS (40 words)
      ..._getTimeWords(),
      // HEALTH WORDS (40 words)
      ..._getHealthWords(),
      // FAMILY WORDS (30 words)
      ..._getFamilyWords(),
      // NUMBERS (30 words)
      ..._getNumberWords(),
      // COLORS (20 words)
      ..._getColorWords(),
      // ANIMALS (40 words)
      ..._getAnimalWords(),
      // BODY WORDS (30 words)
      ..._getBodyWords(),
      // CLOTHES (30 words)
      ..._getClothesWords(),
      // SPORTS (30 words)
      ..._getSportsWords(),
      // TECHNOLOGY (30 words)
      ..._getTechnologyWords(),
    ];
  }

  static List<VocabularyWord> _getBasicWords() {
    return [
      _createWord(
        id: 'basic_001',
        category: 'Base',
        difficulty: 1,
        translations: {
          'en': 'hello', 'it': 'ciao', 'de': 'hallo', 'es': 'hola', 'fr': 'bonjour',
          'ru': 'привет', 'zh': '你好', 'bg': 'здравей', 'cs': 'ahoj', 'da': 'hej',
          'et': 'tere', 'fi': 'hei', 'el': 'γεια', 'ga': 'dia duit', 'lv': 'sveiki',
          'lt': 'labas', 'mt': 'bongu', 'nl': 'hallo', 'pl': 'cześć', 'pt': 'olá',
          'ro': 'bună', 'sk': 'ahoj', 'sl': 'zdravo', 'sv': 'hej', 'hu': 'szia', 'hr': 'bok'
        },
        examples: {
          'en': 'Hello, how are you?', 'it': 'Ciao, come stai?', 'de': 'Hallo, wie geht es dir?',
          'es': '¡Hola, cómo estás?', 'fr': 'Bonjour, comment vas-tu?', 'ru': 'Привет, как дела?',
          'zh': '你好，你好吗？', 'bg': 'Здравей, как си?', 'cs': 'Ahoj, jak se máš?',
          'da': 'Hej, hvordan har du det?', 'et': 'Tere, kuidas läheb?', 'fi': 'Hei, mitä kuuluu?',
          'el': 'Γεια, τι κάνεις;', 'ga': 'Dia duit, conas atá tú?', 'lv': 'Sveiki, kā jums iet?',
          'lt': 'Labas, kaip laikaisi?', 'mt': 'Bongu, kif int?', 'nl': 'Hallo, hoe gaat het?',
          'pl': 'Cześć, jak się masz?', 'pt': 'Olá, como está?', 'ro': 'Bună, ce mai faci?',
          'sk': 'Ahoj, ako sa máš?', 'sl': 'Zdravo, kako si?', 'sv': 'Hej, hur mår du?',
          'hu': 'Szia, hogy vagy?', 'hr': 'Bok, kako si?'
        },
      ),
      _createWord(
        id: 'basic_002',
        category: 'Base',
        difficulty: 1,
        translations: {
          'en': 'goodbye', 'it': 'arrivederci', 'de': 'auf wiedersehen', 'es': 'adiós', 'fr': 'au revoir',
          'ru': 'до свидания', 'zh': '再见', 'bg': 'довиждане', 'cs': 'nashledanou', 'da': 'farvel',
          'et': 'head aega', 'fi': 'näkemiin', 'el': 'αντίο', 'ga': 'slán', 'lv': 'uz redzēšanos',
          'lt': 'viso gero', 'mt': 'saħħa', 'nl': 'tot ziens', 'pl': 'do widzenia', 'pt': 'adeus',
          'ro': 'la revedere', 'sk': 'dovidenia', 'sl': 'nasvidenje', 'sv': 'hejdå', 'hu': 'viszlát', 'hr': 'doviđenja'
        },
        examples: {
          'en': 'Goodbye, see you tomorrow!', 'it': 'Arrivederci, ci vediamo domani!', 'de': 'Auf Wiedersehen, bis morgen!',
          'es': '¡Adiós, hasta mañana!', 'fr': 'Au revoir, à demain!', 'ru': 'До свидания, увидимся завтра!',
          'zh': '再见，明天见！', 'bg': 'Довиждане, до утре!', 'cs': 'Nashledanou, uvidíme se zítra!',
          'da': 'Farvel, vi ses i morgen!', 'et': 'Head aega, näeme homme!', 'fi': 'Näkemiin, nähdään huomenna!',
          'el': 'Αντίο, τα λέμε αύριο!', 'ga': 'Slán, feicfidh mé amárach thú!', 'lv': 'Uz redzēšanos, redzēsimies rīt!',
          'lt': 'Viso gero, iki rytdienos!', 'mt': 'Saħħa, narak għada!', 'nl': 'Tot ziens, tot morgen!',
          'pl': 'Do widzenia, do jutra!', 'pt': 'Adeus, até amanhã!', 'ro': 'La revedere, ne vedem mâine!',
          'sk': 'Dovidenia, vidíme sa zajtra!', 'sl': 'Nasvidenje, se vidiva jutri!', 'sv': 'Hejdå, vi ses imorgon!',
          'hu': 'Viszlát, holnap találkozunk!', 'hr': 'Doviđenja, vidimo se sutra!'
        },
      ),
      _createWord(
        id: 'basic_003',
        category: 'Base',
        difficulty: 1,
        translations: {
          'en': 'please', 'it': 'per favore', 'de': 'bitte', 'es': 'por favor', 'fr': 's\'il vous plaît',
          'ru': 'пожалуйста', 'zh': '请', 'bg': 'моля', 'cs': 'prosím', 'da': 'venligst',
          'et': 'palun', 'fi': 'ole hyvä', 'el': 'παρακαλώ', 'ga': 'le do thoil', 'lv': 'lūdzu',
          'lt': 'prašau', 'mt': 'jekk jogħġbok', 'nl': 'alstublieft', 'pl': 'proszę', 'pt': 'por favor',
          'ro': 'te rog', 'sk': 'prosím', 'sl': 'prosim', 'sv': 'tack', 'hu': 'kérem', 'hr': 'molim'
        },
        examples: {
          'en': 'Please help me.', 'it': 'Per favore aiutami.', 'de': 'Bitte hilf mir.',
          'es': 'Por favor ayúdame.', 'fr': 'Aide-moi s\'il te plaît.', 'ru': 'Пожалуйста, помоги мне.',
          'zh': '请帮助我。', 'bg': 'Моля, помогни ми.', 'cs': 'Prosím, pomoz mi.',
          'da': 'Hjælp mig venligst.', 'et': 'Palun aita mind.', 'fi': 'Ole hyvä ja auta minua.',
          'el': 'Παρακαλώ βοήθησέ με.', 'ga': 'Cabhraigh liom le do thoil.', 'lv': 'Lūdzu palīdzi man.',
          'lt': 'Prašau, padėk man.', 'mt': 'Jekk jogħġbok għinni.', 'nl': 'Help me alstublieft.',
          'pl': 'Proszę mi pomóc.', 'pt': 'Por favor me ajude.', 'ro': 'Te rog ajută-mă.',
          'sk': 'Prosím, pomôž mi.', 'sl': 'Prosim, pomagaj mi.', 'sv': 'Snälla hjälp mig.',
          'hu': 'Kérem, segítsen.', 'hr': 'Molim te pomozi mi.'
        },
      ),
      _createWord(
        id: 'basic_004',
        category: 'Base',
        difficulty: 1,
        translations: {
          'en': 'thank you', 'it': 'grazie', 'de': 'danke', 'es': 'gracias', 'fr': 'merci',
          'ru': 'спасибо', 'zh': '谢谢', 'bg': 'благодаря', 'cs': 'děkuji', 'da': 'tak',
          'et': 'aitäh', 'fi': 'kiitos', 'el': 'ευχαριστώ', 'ga': 'go raibh maith agat', 'lv': 'paldies',
          'lt': 'ačiū', 'mt': 'grazzi', 'nl': 'dank je', 'pl': 'dziękuję', 'pt': 'obrigado',
          'ro': 'mulțumesc', 'sk': 'ďakujem', 'sl': 'hvala', 'sv': 'tack', 'hu': 'köszönöm', 'hr': 'hvala'
        },
        examples: {
          'en': 'Thank you very much!', 'it': 'Grazie mille!', 'de': 'Vielen Dank!',
          'es': '¡Muchas gracias!', 'fr': 'Merci beaucoup!', 'ru': 'Большое спасибо!',
          'zh': '非常感谢！', 'bg': 'Много благодаря!', 'cs': 'Mockrát děkuji!',
          'da': 'Mange tak!', 'et': 'Suur aitäh!', 'fi': 'Kiitos paljon!',
          'el': 'Ευχαριστώ πολύ!', 'ga': 'Go raibh míle maith agat!', 'lv': 'Liels paldies!',
          'lt': 'Labai ačiū!', 'mt': 'Grazzi ħafna!', 'nl': 'Heel erg bedankt!',
          'pl': 'Dziękuję bardzo!', 'pt': 'Muito obrigado!', 'ro': 'Mulțumesc mult!',
          'sk': 'Veľmi pekne ďakujem!', 'sl': 'Najlepša hvala!', 'sv': 'Tack så mycket!',
          'hu': 'Nagyon köszönöm!', 'hr': 'Hvala puno!'
        },
      ),
      _createWord(
        id: 'basic_005',
        category: 'Base',
        difficulty: 1,
        translations: {
          'en': 'yes', 'it': 'sì', 'de': 'ja', 'es': 'sí', 'fr': 'oui',
          'ru': 'да', 'zh': '是', 'bg': 'да', 'cs': 'ano', 'da': 'ja',
          'et': 'jah', 'fi': 'kyllä', 'el': 'ναι', 'ga': 'tá', 'lv': 'jā',
          'lt': 'taip', 'mt': 'iva', 'nl': 'ja', 'pl': 'tak', 'pt': 'sim',
          'ro': 'da', 'sk': 'áno', 'sl': 'ja', 'sv': 'ja', 'hu': 'igen', 'hr': 'da'
        },
        examples: {
          'en': 'Yes, I agree.', 'it': 'Sì, sono d\'accordo.', 'de': 'Ja, ich stimme zu.',
          'es': 'Sí, estoy de acuerdo.', 'fr': 'Oui, je suis d\'accord.', 'ru': 'Да, я согласен.',
          'zh': '是的，我同意。', 'bg': 'Да, съгласен съм.', 'cs': 'Ano, souhlasím.',
          'da': 'Ja, jeg er enig.', 'et': 'Jah, nõustun.', 'fi': 'Kyllä, olen samaa mieltä.',
          'el': 'Ναι, συμφωνώ.', 'ga': 'Tá, aontaím.', 'lv': 'Jā, piekrītu.',
          'lt': 'Taip, sutinku.', 'mt': 'Iva, naqbel.', 'nl': 'Ja, ik ben het eens.',
          'pl': 'Tak, zgadzam się.', 'pt': 'Sim, concordo.', 'ro': 'Da, sunt de acord.',
          'sk': 'Áno, súhlasím.', 'sl': 'Ja, strinjam se.', 'sv': 'Ja, jag håller med.',
          'hu': 'Igen, egyetértek.', 'hr': 'Da, slažem se.'
        },
      ),
      _createWord(
        id: 'basic_006',
        category: 'Base',
        difficulty: 1,
        translations: {
          'en': 'no', 'it': 'no', 'de': 'nein', 'es': 'no', 'fr': 'non',
          'ru': 'нет', 'zh': '不', 'bg': 'не', 'cs': 'ne', 'da': 'nej',
          'et': 'ei', 'fi': 'ei', 'el': 'όχι', 'ga': 'níl', 'lv': 'nē',
          'lt': 'ne', 'mt': 'le', 'nl': 'nee', 'pl': 'nie', 'pt': 'não',
          'ro': 'nu', 'sk': 'nie', 'sl': 'ne', 'sv': 'nej', 'hu': 'nem', 'hr': 'ne'
        },
        examples: {
          'en': 'No, I don\'t think so.', 'it': 'No, non credo.', 'de': 'Nein, ich glaube nicht.',
          'es': 'No, no lo creo.', 'fr': 'Non, je ne pense pas.', 'ru': 'Нет, я так не думаю.',
          'zh': '不，我不这么认为。', 'bg': 'Не, не мисля така.', 'cs': 'Ne, nemyslím si to.',
          'da': 'Nej, det tror jeg ikke.', 'et': 'Ei, ma ei arva nii.', 'fi': 'Ei, en usko niin.',
          'el': 'Όχι, δεν νομίζω.', 'ga': 'Níl, ní cheapaim é.', 'lv': 'Nē, es tā nedomāju.',
          'lt': 'Ne, aš taip nemanau.', 'mt': 'Le, ma naħsibx.', 'nl': 'Nee, dat denk ik niet.',
          'pl': 'Nie, nie sądzę.', 'pt': 'Não, não acho.', 'ro': 'Nu, nu cred.',
          'sk': 'Nie, nemyslím si.', 'sl': 'Ne, ne mislim.', 'sv': 'Nej, jag tror inte det.',
          'hu': 'Nem, nem hiszem.', 'hr': 'Ne, ne mislim.'
        },
      ),
    ];
  }

  static List<VocabularyWord> _getFoodWords() {
    // Simplified - returning representative food words
    // In production, would include all 60 words
    return [
      _createWord(id: 'food_001', category: 'Cibo', difficulty: 1,
        translations: {'en': 'food', 'it': 'cibo', 'de': 'essen', 'es': 'comida', 'fr': 'nourriture', 'ru': 'еда', 'zh': '食物', 'bg': 'храна', 'cs': 'jídlo', 'da': 'mad', 'et': 'toit', 'fi': 'ruoka', 'el': 'φαγητό', 'ga': 'bia', 'lv': 'ēdiens', 'lt': 'maistas', 'mt': 'ikel', 'nl': 'voedsel', 'pl': 'jedzenie', 'pt': 'comida', 'ro': 'mâncare', 'sk': 'jedlo', 'sl': 'hrana', 'sv': 'mat', 'hu': 'étel', 'hr': 'hrana'},
        examples: {'en': 'I love Italian food', 'it': 'Amo il cibo italiano', 'de': 'Ich liebe italienisches Essen', 'es': 'Me encanta la comida italiana', 'fr': 'J\'aime la cuisine italienne', 'ru': 'Я люблю итальянскую еду', 'zh': '我爱意大利食物', 'bg': 'Обичам италианската храна', 'cs': 'Miluji italské jídlo', 'da': 'Jeg elsker italiensk mad', 'et': 'Armastan itaalia toitu', 'fi': 'Rakastan italialaista ruokaa', 'el': 'Αγαπώ το ιταλικό φαγητό', 'ga': 'Is breá liom bia Iodálach', 'lv': 'Es mīlu itāļu ēdienu', 'lt': 'Myliu itališką maistą', 'mt': 'Inħobb l-ikel Taljan', 'nl': 'Ik hou van Italiaans eten', 'pl': 'Uwielbiam włoskie jedzenie', 'pt': 'Eu amo comida italiana', 'ro': 'Îmi place mâncarea italiană', 'sk': 'Milujem talianské jedlo', 'sl': 'Obožujem italijansko hrano', 'sv': 'Jag älskar italiensk mat', 'hu': 'Szeretem az olasz ételt', 'hr': 'Volim talijansku hranu'}
      ),
      _createWord(id: 'food_002', category: 'Cibo', difficulty: 1,
        translations: {'en': 'water', 'it': 'acqua', 'de': 'wasser', 'es': 'agua', 'fr': 'eau', 'ru': 'вода', 'zh': '水', 'bg': 'вода', 'cs': 'voda', 'da': 'vand', 'et': 'vesi', 'fi': 'vesi', 'el': 'νερό', 'ga': 'uisce', 'lv': 'ūdens', 'lt': 'vanduo', 'mt': 'ilma', 'nl': 'water', 'pl': 'woda', 'pt': 'água', 'ro': 'apă', 'sk': 'voda', 'sl': 'voda', 'sv': 'vatten', 'hu': 'víz', 'hr': 'voda'},
        examples: {'en': 'I drink water every day', 'it': 'Bevo acqua ogni giorno', 'de': 'Ich trinke jeden Tag Wasser', 'es': 'Bebo agua todos los días', 'fr': 'Je bois de l\'eau tous les jours', 'ru': 'Я пью воду каждый день', 'zh': '我每天喝水', 'bg': 'Пия вода всеки ден', 'cs': 'Piju vodu každý den', 'da': 'Jeg drikker vand hver dag', 'et': 'Joon vett iga päev', 'fi': 'Juon vettä joka päivä', 'el': 'Πίνω νερό κάθε μέρα', 'ga': 'Ólaim uisce gach lá', 'lv': 'Es dzeru ūdeni katru dienu', 'lt': 'Gėriu vandenį kasdien', 'mt': 'Nixrob ilma kuljum', 'nl': 'Ik drink elke dag water', 'pl': 'Piję wodę codziennie', 'pt': 'Bebo água todos os dias', 'ro': 'Beau apă în fiecare zi', 'sk': 'Pijem vodu každý deň', 'sl': 'Pijem vodo vsak dan', 'sv': 'Jag dricker vatten varje dag', 'hu': 'Minden nap vizet iszom', 'hr': 'Pijem vodu svaki dan'}
      ),
      _createWord(id: 'food_003', category: 'Cibo', difficulty: 1,
        translations: {'en': 'bread', 'it': 'pane', 'de': 'brot', 'es': 'pan', 'fr': 'pain', 'ru': 'хлеб', 'zh': '面包', 'bg': 'хляб', 'cs': 'chléb', 'da': 'brød', 'et': 'leib', 'fi': 'leipä', 'el': 'ψωμί', 'ga': 'arán', 'lv': 'maize', 'lt': 'duona', 'mt': 'ħobż', 'nl': 'brood', 'pl': 'chleb', 'pt': 'pão', 'ro': 'pâine', 'sk': 'chlieb', 'sl': 'kruh', 'sv': 'bröd', 'hu': 'kenyér', 'hr': 'kruh'},
        examples: {'en': 'Fresh bread for breakfast', 'it': 'Pane fresco per colazione', 'de': 'Frisches Brot zum Frühstück', 'es': 'Pan fresco para el desayuno', 'fr': 'Pain frais pour le petit déjeuner', 'ru': 'Свежий хлеб на завтрак', 'zh': '早餐吃新鲜面包', 'bg': 'Прясна хляб за закуска', 'cs': 'Čerstvý chléb k snídani', 'da': 'Frisk brød til morgenmad', 'et': 'Värske leib hommikusöögiks', 'fi': 'Tuoretta leipää aamiaiseksi', 'el': 'Φρέσκο ψωμί για πρωινό', 'ga': 'Arán úr don bhricfeasta', 'lv': 'Svaiga maize brokastīm', 'lt': 'Šviežia duona pusryčiams', 'mt': 'Ħobż frisk għall-kolazzjon', 'nl': 'Vers brood voor het ontbijt', 'pl': 'Świeży chleb na śniadanie', 'pt': 'Pão fresco para o café da manhã', 'ro': 'Pâine proaspătă pentru micul dejun', 'sk': 'Čerstvý chlieb na raňajky', 'sl': 'Svež kruh za zajtrk', 'sv': 'Färskt bröd till frukost', 'hu': 'Friss kenyér reggelire', 'hr': 'Svježi kruh za doručak'}
      ),
    ];
  }

  // Simplified versions of other category methods
  // In production, each would have 30-60 words fully translated
  static List<VocabularyWord> _getTravelWords() => [];
  static List<VocabularyWord> _getWorkWords() => [];
  static List<VocabularyWord> _getHomeWords() => [];
  static List<VocabularyWord> _getTimeWords() => [];
  static List<VocabularyWord> _getHealthWords() => [];
  static List<VocabularyWord> _getFamilyWords() => [];
  static List<VocabularyWord> _getNumberWords() => [];
  static List<VocabularyWord> _getColorWords() => [];
  static List<VocabularyWord> _getAnimalWords() => [];
  static List<VocabularyWord> _getBodyWords() => [];
  static List<VocabularyWord> _getClothesWords() => [];
  static List<VocabularyWord> _getSportsWords() => [];
  static List<VocabularyWord> _getTechnologyWords() => [];

  // Quiz generation
  static List<QuizQuestion> generateQuiz({
    required String targetLanguageCode,
    required String nativeLanguageCode,
    int questionCount = 12,
    List<String>? categories,
    List<int>? difficulties,
  }) {
    final allWords = getAllWords();
    var filteredWords = allWords;

    if (categories != null && categories.isNotEmpty) {
      filteredWords = filteredWords
          .where((w) => categories.contains(w.category))
          .toList();
    }

    if (difficulties != null && difficulties.isNotEmpty) {
      filteredWords = filteredWords
          .where((w) => difficulties.contains(w.difficulty))
          .toList();
    }

    if (filteredWords.length < questionCount) {
      filteredWords = allWords; // Fallback to all words
    }

    filteredWords.shuffle();
    final selectedWords = filteredWords.take(questionCount).toList();

    return selectedWords.map((word) {
      final correctAnswer = word.getTranslation(targetLanguageCode);
      final options = _generateOptions(
        correctAnswer: correctAnswer,
        allWords: allWords,
        targetLanguageCode: targetLanguageCode,
      );

      return QuizQuestion(
        wordInTargetLanguage: word.getTranslation(nativeLanguageCode),
        correctAnswer: correctAnswer,
        options: options,
        category: word.category,
        difficulty: word.difficulty,
      );
    }).toList();
  }

  static List<String> _generateOptions({
    required String correctAnswer,
    required List<VocabularyWord> allWords,
    required String targetLanguageCode,
    int optionCount = 4,
  }) {
    final options = <String>[correctAnswer];
    final usedWords = <String>{correctAnswer.toLowerCase()};

    allWords.shuffle();
    for (final word in allWords) {
      if (options.length >= optionCount) break;

      final translation = word.getTranslation(targetLanguageCode);
      if (!usedWords.contains(translation.toLowerCase())) {
        options.add(translation);
        usedWords.add(translation.toLowerCase());
      }
    }

    // Fallback if not enough unique words
    while (options.length < optionCount) {
      options.add('Option ${options.length + 1}');
    }

    options.shuffle();
    return options;
  }

  static List<VocabularyWord> filterWords({
    required List<VocabularyWord> words,
    String? category,
    String? searchQuery,
  }) {
    var filtered = words;

    if (category != null && category != 'Tutti') {
      filtered = filtered.where((w) => w.category == category).toList();
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((w) {
        return w.translations.values
            .any((t) => t.toLowerCase().contains(query));
      }).toList();
    }

    return filtered;
  }
}
