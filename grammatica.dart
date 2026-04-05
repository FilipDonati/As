import 'package:flutter/material.dart';
import 'package:login_ora/presentation/screens/tab_lezioni/multilanguage_grammar_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class GrammaticaScreen extends StatefulWidget {
  final String language;
  final String languageCode;
  final String level;
  final String nativeLanguageCode;

  const GrammaticaScreen({
    super.key,
    required this.language,
    required this.languageCode,
    required this.level,
    this.nativeLanguageCode = 'it',
  });

  @override
  State<GrammaticaScreen> createState() => _GrammaticaScreenState();
}

class _GrammaticaScreenState extends State<GrammaticaScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Map<String, bool> completedLessons = {};
  Map<String, int> lessonScores = {};
  int totalXP = 0;
  int currentStreak = 0;
  bool isLoading = true;

  // TRADUZIONI PER 26 LINGUE
  final Map<String, Map<String, String>> _translations = {
    'it': {
      'title': 'Grammatica',
      'subtitle': 'Impara le regole grammaticali',
      'totalProgress': 'Progresso Totale',
      'streak': 'Streak',
      'days': 'giorni',
      'completed': 'Completate',
      'lessons': 'lezioni completate',
      'grammar2': 'GRAMMATICA 2',
      'exercises': 'Esercizi Multilingua',
    },
    'en': {
      'title': 'Grammar',
      'subtitle': 'Learn grammar rules',
      'totalProgress': 'Total Progress',
      'streak': 'Streak',
      'days': 'days',
      'completed': 'Completed',
      'lessons': 'lessons completed',
      'grammar2': 'GRAMMAR 2',
      'exercises': 'Multilingual Exercises',
    },
    'es': {
      'title': 'Gramática',
      'subtitle': 'Aprende las reglas gramaticales',
      'totalProgress': 'Progreso Total',
      'streak': 'Racha',
      'days': 'días',
      'completed': 'Completadas',
      'lessons': 'lecciones completadas',
      'grammar2': 'GRAMÁTICA 2',
      'exercises': 'Ejercicios Multilingües',
    },
    'fr': {
      'title': 'Grammaire',
      'subtitle': 'Apprendre les règles grammaticales',
      'totalProgress': 'Progrès Total',
      'streak': 'Série',
      'days': 'jours',
      'completed': 'Terminées',
      'lessons': 'leçons terminées',
      'grammar2': 'GRAMMAIRE 2',
      'exercises': 'Exercices Multilingues',
    },
    'de': {
      'title': 'Grammatik',
      'subtitle': 'Grammatikregeln lernen',
      'totalProgress': 'Gesamtfortschritt',
      'streak': 'Serie',
      'days': 'Tage',
      'completed': 'Abgeschlossen',
      'lessons': 'Lektionen abgeschlossen',
      'grammar2': 'GRAMMATIK 2',
      'exercises': 'Mehrsprachige Übungen',
    },
    'ru': {
      'title': 'Грамматика',
      'subtitle': 'Изучайте грамматические правила',
      'totalProgress': 'Общий прогресс',
      'streak': 'Серия',
      'days': 'дней',
      'completed': 'Завершено',
      'lessons': 'уроков завершено',
      'grammar2': 'ГРАММАТИКА 2',
      'exercises': 'Многоязычные упражнения',
    },
    'zh': {
      'title': '语法',
      'subtitle': '学习语法规则',
      'totalProgress': '总进度',
      'streak': '连续',
      'days': '天',
      'completed': '已完成',
      'lessons': '课程已完成',
      'grammar2': '语法 2',
      'exercises': '多语言练习',
    },
    'nl': {
      'title': 'Grammatica',
      'subtitle': 'Leer grammaticaregels',
      'totalProgress': 'Totale Voortgang',
      'streak': 'Reeks',
      'days': 'dagen',
      'completed': 'Voltooid',
      'lessons': 'lessen voltooid',
      'grammar2': 'GRAMMATICA 2',
      'exercises': 'Meertalige Oefeningen',
    },
    'cs': {
      'title': 'Gramatika',
      'subtitle': 'Naučte se gramatická pravidla',
      'totalProgress': 'Celkový Pokrok',
      'streak': 'Série',
      'days': 'dní',
      'completed': 'Dokončeno',
      'lessons': 'lekcí dokončeno',
      'grammar2': 'GRAMATIKA 2',
      'exercises': 'Vícejazyčná Cvičení',
    },
    'bg': {
      'title': 'Граматика',
      'subtitle': 'Научете граматически правила',
      'totalProgress': 'Общ Прогрес',
      'streak': 'Серия',
      'days': 'дни',
      'completed': 'Завършени',
      'lessons': 'урока завършени',
      'grammar2': 'ГРАМАТИКА 2',
      'exercises': 'Многоезични Упражнения',
    },
    'hr': {
      'title': 'Gramatika',
      'subtitle': 'Naučite gramatička pravila',
      'totalProgress': 'Ukupan Napredak',
      'streak': 'Niz',
      'days': 'dana',
      'completed': 'Završeno',
      'lessons': 'lekcija završeno',
      'grammar2': 'GRAMATIKA 2',
      'exercises': 'Višejezične Vježbe',
    },
    'da': {
      'title': 'Grammatik',
      'subtitle': 'Lær grammatikregler',
      'totalProgress': 'Samlet Fremskridt',
      'streak': 'Række',
      'days': 'dage',
      'completed': 'Fuldført',
      'lessons': 'lektioner fuldført',
      'grammar2': 'GRAMMATIK 2',
      'exercises': 'Flersprogede Øvelser',
    },
    'et': {
      'title': 'Grammatika',
      'subtitle': 'Õppige grammatikareegleid',
      'totalProgress': 'Kogu Edenemine',
      'streak': 'Seeria',
      'days': 'päeva',
      'completed': 'Lõpetatud',
      'lessons': 'tundi lõpetatud',
      'grammar2': 'GRAMMATIKA 2',
      'exercises': 'Mitmekeelsed Harjutused',
    },
    'fi': {
      'title': 'Kielioppi',
      'subtitle': 'Opi kielioppisääntöjä',
      'totalProgress': 'Kokonaisedistyminen',
      'streak': 'Sarja',
      'days': 'päivää',
      'completed': 'Valmis',
      'lessons': 'oppituntia valmis',
      'grammar2': 'KIELIOPPI 2',
      'exercises': 'Monikieliset Harjoitukset',
    },
    'el': {
      'title': 'Γραμματική',
      'subtitle': 'Μάθετε γραμματικούς κανόνες',
      'totalProgress': 'Συνολική Πρόοδος',
      'streak': 'Σειρά',
      'days': 'ημέρες',
      'completed': 'Ολοκληρώθηκε',
      'lessons': 'μαθήματα ολοκληρώθηκαν',
      'grammar2': 'ΓΡΑΜΜΑΤΙΚΗ 2',
      'exercises': 'Πολύγλωσσες Ασκήσεις',
    },
    'ga': {
      'title': 'Gramadach',
      'subtitle': 'Foghlaim rialacha gramadaí',
      'totalProgress': 'Dul Chun Cinn Iomlán',
      'streak': 'Sraith',
      'days': 'laethanta',
      'completed': 'Críochnaithe',
      'lessons': 'ceachtanna críochnaithe',
      'grammar2': 'GRAMADACH 2',
      'exercises': 'Cleachtaí Ilteangacha',
    },
    'lv': {
      'title': 'Gramatika',
      'subtitle': 'Mācīties gramatikas noteikumus',
      'totalProgress': 'Kopējais Progress',
      'streak': 'Sērija',
      'days': 'dienas',
      'completed': 'Pabeigtas',
      'lessons': 'nodarbības pabeigtas',
      'grammar2': 'GRAMATIKA 2',
      'exercises': 'Daudzvalodu Vingrinājumi',
    },
    'lt': {
      'title': 'Gramatika',
      'subtitle': 'Mokytis gramatikos taisyklių',
      'totalProgress': 'Bendras Progresas',
      'streak': 'Serija',
      'days': 'dienų',
      'completed': 'Užbaigta',
      'lessons': 'pamokų užbaigta',
      'grammar2': 'GRAMATIKA 2',
      'exercises': 'Daugiakalbiai Pratimai',
    },
    'mt': {
      'title': 'Grammatika',
      'subtitle': 'Itgħallem ir-regoli grammatikali',
      'totalProgress': 'Progress Totali',
      'streak': 'Sensiela',
      'days': 'jiem',
      'completed': 'Komplewt',
      'lessons': 'lezzjonijiet kompluti',
      'grammar2': 'GRAMMATIKA 2',
      'exercises': 'Eżerċizzji Multilingwi',
    },
    'pl': {
      'title': 'Gramatyka',
      'subtitle': 'Naucz się zasad gramatyki',
      'totalProgress': 'Całkowity Postęp',
      'streak': 'Seria',
      'days': 'dni',
      'completed': 'Ukończone',
      'lessons': 'lekcji ukończonych',
      'grammar2': 'GRAMATYKA 2',
      'exercises': 'Wielojęzyczne Ćwiczenia',
    },
    'pt': {
      'title': 'Gramática',
      'subtitle': 'Aprenda as regras gramaticais',
      'totalProgress': 'Progresso Total',
      'streak': 'Sequência',
      'days': 'dias',
      'completed': 'Concluídas',
      'lessons': 'lições concluídas',
      'grammar2': 'GRAMÁTICA 2',
      'exercises': 'Exercícios Multilíngues',
    },
    'ro': {
      'title': 'Gramatică',
      'subtitle': 'Învață regulile gramaticale',
      'totalProgress': 'Progres Total',
      'streak': 'Serie',
      'days': 'zile',
      'completed': 'Completate',
      'lessons': 'lecții completate',
      'grammar2': 'GRAMATICĂ 2',
      'exercises': 'Exerciții Multilingve',
    },
    'sk': {
      'title': 'Gramatika',
      'subtitle': 'Naučte sa gramatické pravidlá',
      'totalProgress': 'Celkový Pokrok',
      'streak': 'Séria',
      'days': 'dní',
      'completed': 'Dokončené',
      'lessons': 'lekcií dokončených',
      'grammar2': 'GRAMATIKA 2',
      'exercises': 'Viacjazyčné Cvičenia',
    },
    'sl': {
      'title': 'Slovnica',
      'subtitle': 'Naučite se slovnična pravila',
      'totalProgress': 'Skupni Napredek',
      'streak': 'Zaporedje',
      'days': 'dni',
      'completed': 'Dokončano',
      'lessons': 'lekcij dokončanih',
      'grammar2': 'SLOVNICA 2',
      'exercises': 'Večjezične Vaje',
    },
    'sv': {
      'title': 'Grammatik',
      'subtitle': 'Lär dig grammatikregler',
      'totalProgress': 'Total Framsteg',
      'streak': 'Serie',
      'days': 'dagar',
      'completed': 'Slutförda',
      'lessons': 'lektioner slutförda',
      'grammar2': 'GRAMMATIK 2',
      'exercises': 'Flerspråkiga Övningar',
    },
    'hu': {
      'title': 'Nyelvtan',
      'subtitle': 'Tanulj nyelvtani szabályokat',
      'totalProgress': 'Teljes Előrehaladás',
      'streak': 'Sorozat',
      'days': 'nap',
      'completed': 'Befejezett',
      'lessons': 'lecke befejezett',
      'grammar2': 'NYELVTAN 2',
      'exercises': 'Többnyelvű Gyakorlatok',
    },
  };

  String _t(String key) {
    return _translations[widget.nativeLanguageCode]?[key] ?? 
           _translations['en']?[key] ?? 
           key;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _loadProgress();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'grammar_progress_${widget.languageCode}_${widget.level}';
    final progressJson = prefs.getString(key);

    if (progressJson != null) {
      final data = json.decode(progressJson);
      setState(() {
        completedLessons = Map<String, bool>.from(data['completed'] ?? {});
        lessonScores = Map<String, int>.from(data['scores'] ?? {});
        totalXP = data['totalXP'] ?? 0;
        currentStreak = data['streak'] ?? 0;
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'grammar_progress_${widget.languageCode}_${widget.level}';
    final data = {
      'completed': completedLessons,
      'scores': lessonScores,
      'totalXP': totalXP,
      'streak': currentStreak,
      'lastUpdate': DateTime.now().toIso8601String(),
    };
    await prefs.setString(key, json.encode(data));
  }

  void _completeLesson(String lessonId, int score, int xp) {
    setState(() {
      completedLessons[lessonId] = true;
      lessonScores[lessonId] = score;
      totalXP += xp;
      currentStreak++;
    });
    _saveProgress();
  }

  double _calculateTotalProgress() {
    final topics = _getTopics();
    int totalLessons = 0;
    int completedCount = 0;

    for (var topic in topics) {
      final lessons = topic['lessons'] as List;
      totalLessons += lessons.length;
      for (var lesson in lessons) {
        if (completedLessons[lesson['id']] == true) {
          completedCount++;
        }
      }
    }

    return totalLessons > 0 ? completedCount / totalLessons : 0.0;
  }

  // Naviga a MultilingualGrammarScreen
  void _navigateToGrammar2() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultilingualGrammarScreen(
          language: widget.language,
          languageCode: widget.languageCode,
          level: widget.level,
          nativeLanguageCode: widget.nativeLanguageCode,
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getTopics() {
    // Traduzioni topic per tutte le lingue
    final topicTranslations = {
      'verb_tenses': {
        'it': 'Tempi Verbali',
        'en': 'Verb Tenses',
        'es': 'Tiempos Verbales',
        'fr': 'Temps Verbaux',
        'de': 'Zeitformen',
        'ru': 'Времена глаголов',
        'zh': '动词时态',
        'nl': 'Werkwoordstijden',
        'cs': 'Slovesné časy',
        'bg': 'Глаголни времена',
        'hr': 'Glagolska vremena',
        'da': 'Verbaltider',
        'et': 'Verbiajad',
        'fi': 'Verbiajat',
        'el': 'Χρόνοι ρημάτων',
        'ga': 'Aimsirí Briathartha',
        'lv': 'Darbības vārdu laiki',
        'lt': 'Veiksmažodžių laikai',
        'mt': 'Żminijiet tal-Verb',
        'pl': 'Czasy Czasowników',
        'pt': 'Tempos Verbais',
        'ro': 'Timpuri Verbale',
        'sk': 'Slovesné časy',
        'sl': 'Glagolski časi',
        'sv': 'Verbtider',
        'hu': 'Igeidők',
      },
      'articles': {
        'it': 'Articoli',
        'en': 'Articles',
        'es': 'Artículos',
        'fr': 'Articles',
        'de': 'Artikel',
        'ru': 'Артикли',
        'zh': '冠词',
        'nl': 'Lidwoorden',
        'cs': 'Členy',
        'bg': 'Членове',
        'hr': 'Članovi',
        'da': 'Artikler',
        'et': 'Artiklid',
        'fi': 'Artikkelit',
        'el': 'Άρθρα',
        'ga': 'Airteagail',
        'lv': 'Artikuli',
        'lt': 'Artikeliai',
        'mt': 'Artikli',
        'pl': 'Rodzajniki',
        'pt': 'Artigos',
        'ro': 'Articole',
        'sk': 'Členy',
        'sl': 'Členi',
        'sv': 'Artiklar',
        'hu': 'Névelők',
      },
    };

    return [
      {
        'title': topicTranslations['verb_tenses']![widget.nativeLanguageCode] ?? 
                 topicTranslations['verb_tenses']!['en']!,
        'icon': Icons.schedule,
        'color': const Color(0xFFFFA06B),
        'lessons': [
          {
            'id': 'present_simple',
            'name': 'Present Simple',
            'duration': '15 min',
            'xp': 50,
            'type': 'present_simple',
          },
          {
            'id': 'present_continuous',
            'name': 'Present Continuous',
            'duration': '12 min',
            'xp': 50,
            'type': 'present_continuous',
          },
          {
            'id': 'past_simple',
            'name': 'Past Simple',
            'duration': '18 min',
            'xp': 75,
            'type': 'past_simple',
          },
          {
            'id': 'future_simple',
            'name': 'Future Simple',
            'duration': '20 min',
            'xp': 100,
            'type': 'future_simple',
          },
        ],
      },
      {
        'title': topicTranslations['articles']![widget.nativeLanguageCode] ?? 
                 topicTranslations['articles']!['en']!,
        'icon': Icons.article,
        'color': const Color(0xFF7C3AED),
        'lessons': [
          {
            'id': 'definite_articles',
            'name': 'Definite Articles',
            'duration': '10 min',
            'xp': 40,
            'type': 'definite_articles',
          },
          {
            'id': 'indefinite_articles',
            'name': 'Indefinite Articles',
            'duration': '10 min',
            'xp': 40,
            'type': 'indefinite_articles',
          },
        ],
      },
    ];
  }

  void _startLesson(Map<String, dynamic> lesson, Color topicColor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GrammarExerciseScreen(
          lessonId: lesson['id'],
          lessonName: lesson['name'],
          lessonType: lesson['type'],
          xpReward: lesson['xp'],
          color: topicColor,
          language: widget.language,
          languageCode: widget.languageCode,
          onComplete: (score, xp) {
            _completeLesson(lesson['id'], score, xp);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
                                _t('title'),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '${widget.language} - ${widget.level}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // XP Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.stars, color: Colors.amber, size: 20),
                              const SizedBox(width: 6),
                              Text(
                                '$totalXP XP',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Stats Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            _t('streak'),
                            '$currentStreak ${_t('days')}',
                            Icons.local_fire_department,
                            Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            _t('completed'),
                            '${completedLessons.length}',
                            Icons.check_circle,
                            Colors.green,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Progress Bar
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
                                  _t('totalProgress'),
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
                                    backgroundColor: Colors.white.withOpacity(0.3),
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

                    const SizedBox(height: 16),

                    // PULSANTE GRAMMATICA 2
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 1.0 + (_animationController.value * 0.05),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(
                                      0.3 * _animationController.value),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: _navigateToGrammar2,
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 24),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Color(0xFFF0F0F0),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.5),
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF7C3AED),
                                              Color(0xFF3B82F6)
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Icon(
                                          Icons.school,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            _t('grammar2'),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF7C3AED),
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            _t('exercises'),
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey[700],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xFF7C3AED),
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Lista Topic
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _getTopics().length,
                  itemBuilder: (context, index) {
                    return _buildTopicCard(_getTopics()[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicCard(Map<String, dynamic> topic) {
    final lessons = topic['lessons'] as List;
    int completedCount = 0;

    for (var lesson in lessons) {
      if (completedLessons[lesson['id']] == true) {
        completedCount++;
      }
    }

    final progress =
        lessons.isNotEmpty ? completedCount / lessons.length : 0.0;

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
          topic['title'],
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
              '$completedCount/${lessons.length} ${_t('lessons')}',
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
                valueColor:
                    AlwaysStoppedAnimation<Color>(topic['color'] as Color),
              ),
            ),
          ],
        ),
        children: [
          const SizedBox(height: 12),
          ...lessons.map((lesson) {
            return _buildLessonItem(lesson, topic['color'] as Color);
          }),
        ],
      ),
    );
  }

  Widget _buildLessonItem(Map<String, dynamic> lesson, Color color) {
    final isCompleted = completedLessons[lesson['id']] == true;
    final score = lessonScores[lesson['id']] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _startLesson(lesson, color),
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
                    color: isCompleted ? color : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCompleted ? Icons.check : Icons.play_arrow,
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
                        lesson['name'],
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
                            lesson['duration'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.stars,
                              size: 14, color: Colors.amber[700]),
                          const SizedBox(width: 4),
                          Text(
                            '+${lesson['xp']} XP',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber[700],
                            ),
                          ),
                          if (isCompleted) ...[
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6BCF7F).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '$score%',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6BCF7F),
                                ),
                              ),
                            ),
                          ],
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
}

// Placeholder per GrammarExerciseScreen
class GrammarExerciseScreen extends StatelessWidget {
  final String lessonId;
  final String lessonName;
  final String lessonType;
  final int xpReward;
  final Color color;
  final String language;
  final String languageCode;
  final Function(int score, int xp) onComplete;

  const GrammarExerciseScreen({
    super.key,
    required this.lessonId,
    required this.lessonName,
    required this.lessonType,
    required this.xpReward,
    required this.color,
    required this.language,
    required this.languageCode,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lessonName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Exercise: $lessonName',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Language: $language'),
            Text('Type: $lessonType'),
            Text('XP Reward: $xpReward'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                onComplete(85, xpReward);
                Navigator.pop(context);
              },
              child: const Text('Complete Lesson'),
            ),
          ],
        ),
      ),
    );
  }
}