import 'package:flutter/material.dart';

class MultilingualGrammarScreen extends StatefulWidget {
  final String language;
  final String languageCode;
  final String level;
  final String nativeLanguageCode;

  const MultilingualGrammarScreen({
    super.key,
    required this.language,
    required this.languageCode,
    required this.level,
    this.nativeLanguageCode = 'it',
  });

  @override
  State<MultilingualGrammarScreen> createState() =>
      _MultilingualGrammarScreenState();
}

class _MultilingualGrammarScreenState extends State<MultilingualGrammarScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Topic grammaticali con traduzioni multilingua
  List<Map<String, dynamic>> getTopics() {
    return [
      {
        'title': {
          'it': 'Tempi Verbali',
          'en': 'Verb Tenses',
          'es': 'Tiempos Verbales',
          'fr': 'Temps Verbaux',
          'de': 'Zeitformen',
          'pt': 'Tempos Verbais',
          'ru': 'Времена глаголов',
          'zh': '动词时态',
        },
        'icon': Icons.schedule,
        'color': const Color(0xFFFFA06B),
        'completed': 8,
        'total': 12,
        'lessons': _getVerbTenseLessons(),
      },
      {
        'title': {
          'it': 'Articoli',
          'en': 'Articles',
          'es': 'Artículos',
          'fr': 'Articles',
          'de': 'Artikel',
          'pt': 'Artigos',
          'ru': 'Артикли',
          'zh': '冠词',
        },
        'icon': Icons.article,
        'color': const Color(0xFF7C3AED),
        'completed': 5,
        'total': 6,
        'lessons': _getArticleLessons(),
      },
      {
        'title': {
          'it': 'Preposizioni',
          'en': 'Prepositions',
          'es': 'Preposiciones',
          'fr': 'Prépositions',
          'de': 'Präpositionen',
          'pt': 'Preposições',
          'ru': 'Предлоги',
          'zh': '介词',
        },
        'icon': Icons.location_on,
        'color': const Color(0xFF3B82F6),
        'completed': 6,
        'total': 10,
        'lessons': _getPrepositionLessons(),
      },
      {
        'title': {
          'it': 'Pronomi',
          'en': 'Pronouns',
          'es': 'Pronombres',
          'fr': 'Pronoms',
          'de': 'Pronomen',
          'pt': 'Pronomes',
          'ru': 'Местоимения',
          'zh': '代词',
        },
        'icon': Icons.person,
        'color': const Color(0xFFFF6B9D),
        'completed': 4,
        'total': 8,
        'lessons': _getPronounLessons(),
      },
      {
        'title': {
          'it': 'Aggettivi',
          'en': 'Adjectives',
          'es': 'Adjetivos',
          'fr': 'Adjectifs',
          'de': 'Adjektive',
          'pt': 'Adjetivos',
          'ru': 'Прилагательные',
          'zh': '形容词',
        },
        'icon': Icons.format_paint,
        'color': const Color(0xFFFFD93D),
        'completed': 3,
        'total': 7,
        'lessons': _getAdjectiveLessons(),
      },
      {
        'title': {
          'it': 'Condizionali',
          'en': 'Conditionals',
          'es': 'Condicionales',
          'fr': 'Conditionels',
          'de': 'Konditionale',
          'pt': 'Condicionais',
          'ru': 'Условные предложения',
          'zh': '条件句',
        },
        'icon': Icons.psychology,
        'color': const Color(0xFF6BCF7F),
        'completed': 0,
        'total': 4,
        'lessons': _getConditionalLessons(),
      },
    ];
  }

  List<Map<String, dynamic>> _getVerbTenseLessons() {
    return [
      {
        'name': {
          'it': 'Presente Semplice',
          'en': 'Present Simple',
          'es': 'Presente Simple',
          'fr': 'Présent Simple',
          'de': 'Präsens',
          'pt': 'Presente Simples',
          'ru': 'Настоящее простое',
          'zh': '一般现在时',
        },
        'duration': '15 min',
        'completed': true,
        'type': 'present_simple',
      },
      {
        'name': {
          'it': 'Presente Continuo',
          'en': 'Present Continuous',
          'es': 'Presente Continuo',
          'fr': 'Présent Continu',
          'de': 'Verlaufsform Präsens',
          'pt': 'Presente Contínuo',
          'ru': 'Настоящее продолженное',
          'zh': '现在进行时',
        },
        'duration': '12 min',
        'completed': true,
        'type': 'present_continuous',
      },
      {
        'name': {
          'it': 'Passato Semplice',
          'en': 'Past Simple',
          'es': 'Pasado Simple',
          'fr': 'Passé Simple',
          'de': 'Präteritum',
          'pt': 'Passado Simples',
          'ru': 'Прошедшее простое',
          'zh': '一般过去时',
        },
        'duration': '18 min',
        'completed': false,
        'type': 'past_simple',
      },
      {
        'name': {
          'it': 'Futuro',
          'en': 'Future Forms',
          'es': 'Formas Futuras',
          'fr': 'Futur',
          'de': 'Futur',
          'pt': 'Formas Futuras',
          'ru': 'Будущее время',
          'zh': '将来时',
        },
        'duration': '20 min',
        'completed': false,
        'type': 'future',
      },
    ];
  }

  List<Map<String, dynamic>> _getArticleLessons() {
    return [
      {
        'name': {
          'it': 'Articoli Determinativi',
          'en': 'Definite Articles',
          'es': 'Artículos Determinados',
          'fr': 'Articles Définis',
          'de': 'Bestimmte Artikel',
          'pt': 'Artigos Definidos',
          'ru': 'Определенные артикли',
          'zh': '定冠词',
        },
        'duration': '10 min',
        'completed': true,
        'type': 'definite_articles',
      },
      {
        'name': {
          'it': 'Articoli Indeterminativi',
          'en': 'Indefinite Articles',
          'es': 'Artículos Indefinidos',
          'fr': 'Articles Indéfinis',
          'de': 'Unbestimmte Artikel',
          'pt': 'Artigos Indefinidos',
          'ru': 'Неопределенные артикли',
          'zh': '不定冠词',
        },
        'duration': '10 min',
        'completed': false,
        'type': 'indefinite_articles',
      },
    ];
  }

  List<Map<String, dynamic>> _getPrepositionLessons() {
    return [
      {
        'name': {
          'it': 'Preposizioni di Tempo',
          'en': 'Time Prepositions',
          'es': 'Preposiciones de Tiempo',
          'fr': 'Prépositions de Temps',
          'de': 'Zeitpräpositionen',
          'pt': 'Preposições de Tempo',
          'ru': 'Предлоги времени',
          'zh': '时间介词',
        },
        'duration': '12 min',
        'completed': true,
        'type': 'time_prepositions',
      },
      {
        'name': {
          'it': 'Preposizioni di Luogo',
          'en': 'Place Prepositions',
          'es': 'Preposiciones de Lugar',
          'fr': 'Prépositions de Lieu',
          'de': 'Ortspräpositionen',
          'pt': 'Preposições de Lugar',
          'ru': 'Предлоги места',
          'zh': '地点介词',
        },
        'duration': '12 min',
        'completed': false,
        'type': 'place_prepositions',
      },
      {
        'name': {
          'it': 'Preposizioni di Modo',
          'en': 'Manner Prepositions',
          'es': 'Preposiciones de Modo',
          'fr': 'Prépositions de Manière',
          'de': 'Modalpräpositionen',
          'pt': 'Preposições de Modo',
          'ru': 'Предлоги образа действия',
          'zh': '方式介词',
        },
        'duration': '15 min',
        'completed': false,
        'type': 'manner_prepositions',
      },
    ];
  }

  List<Map<String, dynamic>> _getPronounLessons() {
    return [
      {
        'name': {
          'it': 'Pronomi Personali',
          'en': 'Personal Pronouns',
          'es': 'Pronombres Personales',
          'fr': 'Pronoms Personnels',
          'de': 'Personalpronomen',
          'pt': 'Pronomes Pessoais',
          'ru': 'Личные местоимения',
          'zh': '人称代词',
        },
        'duration': '10 min',
        'completed': true,
        'type': 'personal_pronouns',
      },
      {
        'name': {
          'it': 'Pronomi Possessivi',
          'en': 'Possessive Pronouns',
          'es': 'Pronombres Posesivos',
          'fr': 'Pronoms Possessifs',
          'de': 'Possessivpronomen',
          'pt': 'Pronomes Possessivos',
          'ru': 'Притяжательные местоимения',
          'zh': '物主代词',
        },
        'duration': '10 min',
        'completed': false,
        'type': 'possessive_pronouns',
      },
      {
        'name': {
          'it': 'Pronomi Relativi',
          'en': 'Relative Pronouns',
          'es': 'Pronombres Relativos',
          'fr': 'Pronoms Relatifs',
          'de': 'Relativpronomen',
          'pt': 'Pronomes Relativos',
          'ru': 'Относительные местоимения',
          'zh': '关系代词',
        },
        'duration': '15 min',
        'completed': false,
        'type': 'relative_pronouns',
      },
    ];
  }

  List<Map<String, dynamic>> _getAdjectiveLessons() {
    return [
      {
        'name': {
          'it': 'Aggettivi Qualificativi',
          'en': 'Descriptive Adjectives',
          'es': 'Adjetivos Calificativos',
          'fr': 'Adjectifs Qualificatifs',
          'de': 'Beschreibende Adjektive',
          'pt': 'Adjetivos Qualificativos',
          'ru': 'Описательные прилагательные',
          'zh': '描述性形容词',
        },
        'duration': '12 min',
        'completed': true,
        'type': 'descriptive_adjectives',
      },
      {
        'name': {
          'it': 'Aggettivi Comparativi',
          'en': 'Comparative Adjectives',
          'es': 'Adjetivos Comparativos',
          'fr': 'Adjectifs Comparatifs',
          'de': 'Komparativ',
          'pt': 'Adjetivos Comparativos',
          'ru': 'Сравнительная степень',
          'zh': '比较级',
        },
        'duration': '15 min',
        'completed': false,
        'type': 'comparative_adjectives',
      },
      {
        'name': {
          'it': 'Aggettivi Superlativi',
          'en': 'Superlative Adjectives',
          'es': 'Adjetivos Superlativos',
          'fr': 'Adjectifs Superlatifs',
          'de': 'Superlativ',
          'pt': 'Adjetivos Superlativos',
          'ru': 'Превосходная степень',
          'zh': '最高级',
        },
        'duration': '15 min',
        'completed': false,
        'type': 'superlative_adjectives',
      },
    ];
  }

  List<Map<String, dynamic>> _getConditionalLessons() {
    return [
      {
        'name': {
          'it': 'Primo Condizionale',
          'en': 'First Conditional',
          'es': 'Primer Condicional',
          'fr': 'Premier Conditionnel',
          'de': 'Erster Konditional',
          'pt': 'Primeiro Condicional',
          'ru': 'Первое условное',
          'zh': '第一条件句',
        },
        'duration': '18 min',
        'completed': false,
        'type': 'first_conditional',
      },
      {
        'name': {
          'it': 'Secondo Condizionale',
          'en': 'Second Conditional',
          'es': 'Segundo Condicional',
          'fr': 'Deuxième Conditionnel',
          'de': 'Zweiter Konditional',
          'pt': 'Segundo Condicional',
          'ru': 'Второе условное',
          'zh': '第二条件句',
        },
        'duration': '20 min',
        'completed': false,
        'type': 'second_conditional',
      },
      {
        'name': {
          'it': 'Terzo Condizionale',
          'en': 'Third Conditional',
          'es': 'Tercer Condicional',
          'fr': 'Troisième Conditionnel',
          'de': 'Dritter Konditional',
          'pt': 'Terceiro Condicional',
          'ru': 'Третье условное',
          'zh': '第三条件句',
        },
        'duration': '22 min',
        'completed': false,
        'type': 'third_conditional',
      },
    ];
  }

  String _getTranslation(Map<String, String> translations) {
    return translations[widget.nativeLanguageCode] ??
        translations['en'] ??
        translations.values.first;
  }

  double _calculateTotalProgress() {
    final topics = getTopics();
    int totalCompleted = 0;
    int totalLessons = 0;

    for (var topic in topics) {
      totalCompleted += topic['completed'] as int;
      totalLessons += topic['total'] as int;
    }

    return totalLessons > 0 ? totalCompleted / totalLessons : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final topics = getTopics();
    final totalProgress = _calculateTotalProgress();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFA06B).withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFA06B), Color(0xFFFF6B9D)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFA06B).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getTranslation({
                                  'it': 'Grammatica',
                                  'en': 'Grammar',
                                  'es': 'Gramática',
                                  'fr': 'Grammaire',
                                  'de': 'Grammatik',
                                  'pt': 'Gramática',
                                  'ru': 'Грамматика',
                                  'zh': '语法',
                                }),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${widget.language} - ${_capitalizeFirst(widget.level)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: 1.0 + (_animationController.value * 0.1),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.text_fields,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Progress Bar totale
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getTranslation({
                                    'it': 'Progresso Totale',
                                    'en': 'Total Progress',
                                    'es': 'Progreso Total',
                                    'fr': 'Progrès Total',
                                    'de': 'Gesamtfortschritt',
                                    'pt': 'Progresso Total',
                                    'ru': 'Общий прогресс',
                                    'zh': '总进度',
                                  }),
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: LinearProgressIndicator(
                                    value: totalProgress,
                                    minHeight: 8,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.3),
                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '${(totalProgress * 100).round()}%',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Lista Topic
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: topics.length,
                  itemBuilder: (context, index) {
                    return _buildTopicCard(topics[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopicCard(Map<String, dynamic> topic) {
    final progress = topic['completed'] / topic['total'];
    final titleMap = topic['title'] as Map<String, String>;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (topic['color'] as Color).withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.all(20),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                (topic['color'] as Color).withOpacity(0.3),
                (topic['color'] as Color).withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: (topic['color'] as Color).withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Icon(
            topic['icon'] as IconData,
            color: topic['color'] as Color,
            size: 30,
          ),
        ),
        title: Text(
          _getTranslation(titleMap),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              '${topic['completed']}/${topic['total']} ${_getTranslation({
                'it': 'lezioni completate',
                'en': 'lessons completed',
                'es': 'lecciones completadas',
                'fr': 'leçons terminées',
                'de': 'Lektionen abgeschlossen',
                'pt': 'lições concluídas',
                'ru': 'уроков завершено',
                'zh': '课程完成',
              })}',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                    topic['color'] as Color),
              ),
            ),
          ],
        ),
        children: [
          const SizedBox(height: 12),
          ...(topic['lessons'] as List).map((lesson) {
            final nameMap = lesson['name'] as Map<String, String>;
            return _buildLessonItem(
              _getTranslation(nameMap),
              lesson['duration'],
              lesson['completed'],
              topic['color'] as Color,
              lesson['type'],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLessonItem(
    String name,
    String duration,
    bool completed,
    Color color,
    String lessonType,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => GrammarExerciseScreen(
                  lessonName: name,
                  lessonType: lessonType,
                  color: color,
                  language: widget.language,
                  languageCode: widget.languageCode,
                  nativeLanguageCode: widget.nativeLanguageCode,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: color.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: completed ? color : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    completed ? Icons.check : Icons.play_arrow,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            duration,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: color,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }
}

// ============================================================================
// SCREEN ESERCIZI GRAMMATICALI STILE DUOLINGO
// ============================================================================

class GrammarExerciseScreen extends StatefulWidget {
  final String lessonName;
  final String lessonType;
  final Color color;
  final String language;
  final String languageCode;
  final String nativeLanguageCode;

  const GrammarExerciseScreen({
    super.key,
    required this.lessonName,
    required this.lessonType,
    required this.color,
    required this.language,
    required this.languageCode,
    required this.nativeLanguageCode,
  });

  @override
  State<GrammarExerciseScreen> createState() => _GrammarExerciseScreenState();
}

class _GrammarExerciseScreenState extends State<GrammarExerciseScreen>
    with SingleTickerProviderStateMixin {
  int currentExercise = 0;
  int correctAnswers = 0;
  bool showResult = false;
  String? selectedAnswer;
  List<String> draggedWords = [];
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Genera esercizi in base al tipo di lezione
  List<Map<String, dynamic>> get exercises {
    switch (widget.lessonType) {
      case 'present_simple':
        return _getPresentSimpleExercises();
      case 'present_continuous':
        return _getPresentContinuousExercises();
      case 'past_simple':
        return _getPastSimpleExercises();
      case 'future':
        return _getFutureExercises();
      default:
        return _getDefaultExercises();
    }
  }

  List<Map<String, dynamic>> _getPresentSimpleExercises() {
    // Esercizi specifici per presente semplice
    return [
      {
        'type': 'multiple_choice',
        'question': {
          'en': 'I ___ to school every day.',
          'it': 'Io ___ a scuola ogni giorno.',
          'es': 'Yo ___ a la escuela todos los días.',
        },
        'options': ['go', 'goes', 'going', 'went'],
        'correct': 'go',
        'explanation': {
          'en': 'Use "go" with I, you, we, they',
          'it': 'Usa "go" con I, you, we, they',
          'es': 'Usa "go" con I, you, we, they',
        },
      },
      {
        'type': 'fill_blank',
        'sentence': {
          'en': 'She ___ coffee every morning.',
          'it': 'Lei ___ caffè ogni mattina.',
          'es': 'Ella ___ café todas las mañanas.',
        },
        'correct': 'drinks',
        'hint': 'drink',
      },
      {
        'type': 'word_order',
        'words': ['I', 'play', 'football', 'on', 'Sundays'],
        'correct': 'I play football on Sundays',
        'translation': {
          'it': 'Io gioco a calcio la domenica',
          'es': 'Yo juego fútbol los domingos',
        },
      },
      {
        'type': 'translate',
        'sentence': {
          'it': 'Loro parlano inglese',
          'es': 'Ellos hablan inglés',
          'en': 'They speak English',
        },
        'correct': 'They speak English',
      },
      {
        'type': 'multiple_choice',
        'question': {
          'en': 'He ___ his homework after dinner.',
          'it': 'Lui ___ i compiti dopo cena.',
          'es': 'Él ___ su tarea después de cenar.',
        },
        'options': ['do', 'does', 'doing', 'did'],
        'correct': 'does',
        'explanation': {
          'en': 'Use "does" with he, she, it',
          'it': 'Usa "does" con he, she, it',
          'es': 'Usa "does" con he, she, it',
        },
      },
    ];
  }

  List<Map<String, dynamic>> _getPresentContinuousExercises() {
    return [
      {
        'type': 'multiple_choice',
        'question': {
          'en': 'I ___ watching TV right now.',
          'it': 'Io ___ guardando la TV adesso.',
          'es': 'Yo ___ viendo la TV ahora.',
        },
        'options': ['am', 'is', 'are', 'be'],
        'correct': 'am',
        'explanation': {
          'en': 'Use "am" with I for present continuous',
          'it': 'Usa "am" con I per il presente continuo',
          'es': 'Usa "am" con I para el presente continuo',
        },
      },
      {
        'type': 'word_order',
        'words': ['She', 'is', 'reading', 'a', 'book'],
        'correct': 'She is reading a book',
        'translation': {
          'it': 'Lei sta leggendo un libro',
          'es': 'Ella está leyendo un libro',
        },
      },
      {
        'type': 'fill_blank',
        'sentence': {
          'en': 'They ___ playing football now.',
          'it': 'Loro ___ giocando a calcio ora.',
          'es': 'Ellos ___ jugando fútbol ahora.',
        },
        'correct': 'are',
        'hint': 'be',
      },
    ];
  }

  List<Map<String, dynamic>> _getPastSimpleExercises() {
    return [
      {
        'type': 'multiple_choice',
        'question': {
          'en': 'I ___ to the cinema yesterday.',
          'it': 'Io ___ al cinema ieri.',
          'es': 'Yo ___ al cine ayer.',
        },
        'options': ['go', 'went', 'gone', 'going'],
        'correct': 'went',
        'explanation': {
          'en': '"Went" is the past form of "go"',
          'it': '"Went" è la forma passata di "go"',
          'es': '"Went" es la forma pasada de "go"',
        },
      },
      {
        'type': 'fill_blank',
        'sentence': {
          'en': 'She ___ a letter last week.',
          'it': 'Lei ___ una lettera la settimana scorsa.',
          'es': 'Ella ___ una carta la semana pasada.',
        },
        'correct': 'wrote',
        'hint': 'write',
      },
    ];
  }

  List<Map<String, dynamic>> _getFutureExercises() {
    return [
      {
        'type': 'multiple_choice',
        'question': {
          'en': 'I ___ visit my grandparents tomorrow.',
          'it': 'Io ___ visitare i miei nonni domani.',
          'es': 'Yo ___ visitar a mis abuelos mañana.',
        },
        'options': ['will', 'would', 'shall', 'should'],
        'correct': 'will',
        'explanation': {
          'en': 'Use "will" for future actions',
          'it': 'Usa "will" per azioni future',
          'es': 'Usa "will" para acciones futuras',
        },
      },
      {
        'type': 'word_order',
        'words': ['They', 'will', 'travel', 'to', 'Italy'],
        'correct': 'They will travel to Italy',
        'translation': {
          'it': 'Loro viaggeranno in Italia',
          'es': 'Ellos viajarán a Italia',
        },
      },
    ];
  }

  List<Map<String, dynamic>> _getDefaultExercises() {
    return _getPresentSimpleExercises();
  }

  void _checkAnswer(dynamic answer) {
    final exercise = exercises[currentExercise];
    bool isCorrect = false;

    if (exercise['type'] == 'multiple_choice' ||
        exercise['type'] == 'fill_blank') {
      isCorrect = answer.toString().toLowerCase().trim() ==
          exercise['correct'].toString().toLowerCase().trim();
    } else if (exercise['type'] == 'word_order') {
      isCorrect = answer.toString().trim() == exercise['correct'].toString();
    }

    setState(() {
      selectedAnswer = answer.toString();
      showResult = true;
      if (isCorrect) {
        correctAnswers++;
        _animationController.forward().then((_) {
          _animationController.reverse();
        });
      }
    });
  }

  void _nextExercise() {
    if (currentExercise < exercises.length - 1) {
      setState(() {
        currentExercise++;
        showResult = false;
        selectedAnswer = null;
        draggedWords = [];
      });
    } else {
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    final percentage = (correctAnswers / exercises.length * 100).round();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(
              percentage >= 80
                  ? Icons.emoji_events
                  : percentage >= 60
                      ? Icons.sentiment_satisfied
                      : Icons.sentiment_neutral,
              color: widget.color,
              size: 32,
            ),
            const SizedBox(width: 12),
            const Text('Lesson Complete!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$correctAnswers/${exercises.length}',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: widget.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$percentage% Correct',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(widget.color),
              minHeight: 8,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('FINISH'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentExercise = 0;
                correctAnswers = 0;
                showResult = false;
                selectedAnswer = null;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.color,
            ),
            child: const Text('RETRY'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (exercises.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('No exercises available'),
        ),
      );
    }

    final exercise = exercises[currentExercise];
    final progress = (currentExercise + 1) / exercises.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header con progress
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 12,
                            backgroundColor: Colors.grey[200],
                            valueColor:
                                AlwaysStoppedAnimation<Color>(widget.color),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '${currentExercise + 1}/${exercises.length}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.lessonName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Contenuto esercizio
            Expanded(
              child: _buildExerciseContent(exercise),
            ),

            // Pulsante check/next
            if (showResult)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: selectedAnswer == exercise['correct']
                      ? const Color(0xFF6BCF7F).withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  border: Border(
                    top: BorderSide(
                      color: selectedAnswer == exercise['correct']
                          ? const Color(0xFF6BCF7F)
                          : Colors.red,
                      width: 3,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          selectedAnswer == exercise['correct']
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: selectedAnswer == exercise['correct']
                              ? const Color(0xFF6BCF7F)
                              : Colors.red,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            selectedAnswer == exercise['correct']
                                ? 'Correct! 🎉'
                                : 'Not quite. Try again!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: selectedAnswer == exercise['correct']
                                  ? const Color(0xFF6BCF7F)
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (exercise['explanation'] != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.blue.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.lightbulb,
                                color: Colors.blue, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _getTranslation(
                                    exercise['explanation'] as Map<String, String>),
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _nextExercise,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          currentExercise < exercises.length - 1
                              ? 'CONTINUE'
                              : 'FINISH',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseContent(Map<String, dynamic> exercise) {
    switch (exercise['type']) {
      case 'multiple_choice':
        return _buildMultipleChoice(exercise);
      case 'fill_blank':
        return _buildFillBlank(exercise);
      case 'word_order':
        return _buildWordOrder(exercise);
      case 'translate':
        return _buildTranslate(exercise);
      default:
        return _buildMultipleChoice(exercise);
    }
  }

  Widget _buildMultipleChoice(Map<String, dynamic> exercise) {
    final questionMap = exercise['question'] as Map<String, String>;
    final options = exercise['options'] as List;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.chat_bubble_outline, color: widget.color),
                const SizedBox(width: 12),
                const Text(
                  'Choose the correct option',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            _getTranslation(questionMap),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),
          ...options.map((option) {
            final isSelected = selectedAnswer == option;
            final isCorrect = option == exercise['correct'];
            
            Color? bgColor;
            Color? borderColor;
            
            if (showResult) {
              if (isCorrect) {
                bgColor = const Color(0xFF6BCF7F);
                borderColor = const Color(0xFF6BCF7F);
              } else if (isSelected && !isCorrect) {
                bgColor = Colors.red;
                borderColor = Colors.red;
              } else {
                borderColor = Colors.grey[300];
              }
            } else {
              borderColor = isSelected ? widget.color : Colors.grey[300];
            }

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: showResult ? null : () => _checkAnswer(option),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: bgColor ?? Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: borderColor!,
                        width: 2.5,
                      ),
                      boxShadow: showResult && isCorrect
                          ? [
                              BoxShadow(
                                color: const Color(0xFF6BCF7F).withOpacity(0.3),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            option.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: bgColor != null
                                  ? Colors.white
                                  : Colors.grey[800],
                            ),
                          ),
                        ),
                        if (showResult && isCorrect)
                          const Icon(Icons.check_circle,
                              color: Colors.white, size: 28),
                        if (showResult && isSelected && !isCorrect)
                          const Icon(Icons.cancel,
                              color: Colors.white, size: 28),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFillBlank(Map<String, dynamic> exercise) {
    final sentenceMap = exercise['sentence'] as Map<String, String>;
    final TextEditingController controller = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.edit, color: widget.color),
                const SizedBox(width: 12),
                const Text(
                  'Fill in the blank',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            _getTranslation(sentenceMap),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: controller,
            enabled: !showResult,
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: 'Type your answer...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: widget.color, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: widget.color, width: 2.5),
              ),
              prefixIcon: Icon(Icons.create, color: widget.color),
            ),
          ),
          const SizedBox(height: 24),
          if (!showResult)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    _checkAnswer(controller.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'CHECK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWordOrder(Map<String, dynamic> exercise) {
    final words = List<String>.from(exercise['words'] as List);
    final availableWords =
        words.where((w) => !draggedWords.contains(w)).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.reorder, color: widget.color),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Tap the words in the correct order',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          
          // Area risposta 
          Container(
            height: 120,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: widget.color.withOpacity(0.3)),
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: draggedWords.map((word) {
                return GestureDetector(
                  onTap: showResult
                      ? null
                      : () {
                          setState(() {
                            draggedWords.remove(word);
                          });
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      word,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Parole disponibili
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: availableWords.map((word) {
              return GestureDetector(
                onTap: showResult
                    ? null
                    : () {
                        setState(() {
                          draggedWords.add(word);
                        });
                      },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: widget.color.withOpacity(0.5)),
                  ),
                  child: Text(
                    word,
                    style: TextStyle(
                      color: widget.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 24),
          
          if (!showResult && draggedWords.isNotEmpty)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _checkAnswer(draggedWords.join(' '));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'CHECK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTranslate(Map<String, dynamic> exercise) {
    final sentenceMap = exercise['sentence'] as Map<String, String>;
    final nativeSentence = _getTranslation(sentenceMap);
    final TextEditingController controller = TextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.translate, color: widget.color),
                const SizedBox(width: 12),
                Text(
                  'Translate to ${widget.language}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.withOpacity(0.3)),
            ),
            child: Text(
              nativeSentence,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: controller,
            enabled: !showResult,
            maxLines: 3,
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: 'Write your translation...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: widget.color, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: widget.color, width: 2.5),
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (!showResult)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    _checkAnswer(controller.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'CHECK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getTranslation(Map<String, String> translations) {
    return translations[widget.nativeLanguageCode] ??
        translations['en'] ??
        translations.values.first;
  }
}