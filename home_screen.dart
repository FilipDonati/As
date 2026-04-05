// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:login_ora/core/config/language_service.dart';
import 'package:login_ora/presentation/screens/account_screen.dart';
import 'package:login_ora/presentation/screens/chat_ai_screen.dart';
import 'package:login_ora/presentation/screens/multilanguages_exercise_screen.dart';
import 'package:login_ora/presentation/screens/tab_lezioni/lezioni_screen.dart';
import 'package:login_ora/presentation/screens/tab_reel_screen/reels_screen.dart';
import 'package:login_ora/presentation/screens/tab_task_home/ascolto.dart';
import 'package:login_ora/presentation/screens/tab_task_home/conversazione.dart';
import 'package:login_ora/presentation/screens/tab_task_home/pronuncia.dart';
import 'package:login_ora/presentation/screens/videocall_screen.dart';
import 'package:login_ora/services/providers/local_provider.dart';

class HomePage extends StatefulWidget {
  final String language;
  final String languageCode;
  final String level;
  final String flag;

  const HomePage({
    super.key,
    required this.language,
    required this.languageCode,
    required this.level,
    required this.flag,
    required localeProvider,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int _selectedIndex = 0;
  String _selectedLanguage = 'en';
  final LanguageService _languageService = LanguageService();

  // Mappa traduzioni complete per 26 lingue
  final Map<String, Map<String, String>> _translations = {
    'en': {
      'lessons': 'Lessons',
      'chatAI': 'Chat AI',
      'video': 'Video',
      'reels': 'Reels',
      'profile': 'Profile',
      'exercise': 'EXERCISE',
      'practicalQuiz': 'Practical Quiz',
      'vocabulary': 'Vocabulary',
      'grammar': 'Grammar',
      'pronounce': 'Pronounce',
      'listening': 'Listening',
      'conversation': 'Conversation',
    },
    'it': {
      'lessons': 'Lezioni',
      'chatAI': 'Chat AI',
      'video': 'Video',
      'reels': 'Reels',
      'profile': 'Profilo',
      'exercise': 'ESERCIZI',
      'practicalQuiz': 'Quiz Pratico',
      'vocabulary': 'Vocabolario',
      'grammar': 'Grammatica',
      'pronounce': 'Pronuncia',
      'listening': 'Ascolto',
      'conversation': 'Conversazione',
    },
    'de': {
      'lessons': 'Lektionen',
      'chatAI': 'Chat AI',
      'video': 'Video',
      'reels': 'Reels',
      'profile': 'Profil',
      'exercise': 'ÜBUNGEN',
      'practicalQuiz': 'Praktisches Quiz',
      'vocabulary': 'Wortschatz',
      'grammar': 'Grammatik',
      'pronounce': 'Aussprache',
      'listening': 'Hören',
      'conversation': 'Konversation',
    },
    'es': {
      'lessons': 'Lecciones',
      'chatAI': 'Chat AI',
      'video': 'Video',
      'reels': 'Reels',
      'profile': 'Perfil',
      'exercise': 'EJERCICIOS',
      'practicalQuiz': 'Quiz Práctico',
      'vocabulary': 'Vocabulario',
      'grammar': 'Gramática',
      'pronounce': 'Pronunciación',
      'listening': 'Escuchar',
      'conversation': 'Conversación',
    },
    'fr': {
      'lessons': 'Leçons',
      'chatAI': 'Chat AI',
      'video': 'Vidéo',
      'reels': 'Reels',
      'profile': 'Profil',
      'exercise': 'EXERCICES',
      'practicalQuiz': 'Quiz Pratique',
      'vocabulary': 'Vocabulaire',
      'grammar': 'Grammaire',
      'pronounce': 'Prononciation',
      'listening': 'Écoute',
      'conversation': 'Conversation',
    },
    'ru': {
      'lessons': 'Уроки',
      'chatAI': 'Чат AI',
      'video': 'Видео',
      'reels': 'Reels',
      'profile': 'Профиль',
      'exercise': 'УПРАЖНЕНИЯ',
      'practicalQuiz': 'Практический тест',
      'vocabulary': 'Словарь',
      'grammar': 'Грамматика',
      'pronounce': 'Произношение',
      'listening': 'Аудирование',
      'conversation': 'Разговор',
    },
    'zh': {
      'lessons': '课程',
      'chatAI': 'AI聊天',
      'video': '视频',
      'reels': 'Reels',
      'profile': '个人资料',
      'exercise': '练习',
      'practicalQuiz': '实用测验',
      'vocabulary': '词汇',
      'grammar': '语法',
      'pronounce': '发音',
      'listening': '听力',
      'conversation': '对话',
    },
    'bg': {
      'lessons': 'Уроци',
      'chatAI': 'Чат AI',
      'video': 'Видео',
      'reels': 'Reels',
      'profile': 'Профил',
      'exercise': 'УПРАЖНЕНИЯ',
      'practicalQuiz': 'Практически тест',
      'vocabulary': 'Речник',
      'grammar': 'Граматика',
      'pronounce': 'Произношение',
      'listening': 'Слушане',
      'conversation': 'Разговор',
    },
    'cs': {
      'lessons': 'Lekce',
      'chatAI': 'Chat AI',
      'video': 'Video',
      'reels': 'Reels',
      'profile': 'Profil',
      'exercise': 'CVIČENÍ',
      'practicalQuiz': 'Praktický kvíz',
      'vocabulary': 'Slovní zásoba',
      'grammar': 'Gramatika',
      'pronounce': 'Výslovnost',
      'listening': 'Poslech',
      'conversation': 'Konverzace',
    },
    'da': {
      'lessons': 'Lektioner',
      'chatAI': 'Chat AI',
      'video': 'Video',
      'reels': 'Reels',
      'profile': 'Profil',
      'exercise': 'ØVELSER',
      'practicalQuiz': 'Praktisk quiz',
      'vocabulary': 'Ordforråd',
      'grammar': 'Grammatik',
      'pronounce': 'Udtale',
      'listening': 'Lytning',
      'conversation': 'Samtale',
    },
    'et': {
      'lessons': 'Tunnid',
      'chatAI': 'Chat AI',
      'video': 'Video',
      'reels': 'Reels',
      'profile': 'Profiil',
      'exercise': 'HARJUTUSED',
      'practicalQuiz': 'Praktiline viktoriintest',
      'vocabulary': 'Sõnavara',
      'grammar': 'Grammatika',
      'pronounce': 'Hääldus',
      'listening': 'Kuulamine',
      'conversation': 'Vestlus',
    },
    'fi': {
      'lessons': 'Oppitunnit',
      'chatAI': 'Chat AI',
      'video': 'Video',
      'reels': 'Reels',
      'profile': 'Profiili',
      'exercise': 'HARJOITUKSET',
      'practicalQuiz': 'Käytännön tietokilpailu',
      'vocabulary': 'Sanasto',
      'grammar': 'Kielioppi',
      'pronounce': 'Ääntäminen',
      'listening': 'Kuuntelu',
      'conversation': 'Keskustelu',
    },
    'el': {
      'lessons': 'Μαθήματα',
      'chatAI': 'Chat AI',
      'video': 'Βίντεο',
      'reels': 'Reels',
      'profile': 'Προφίλ',
      'exercise': 'ΑΣΚΗΣΕΙΣ',
      'practicalQuiz': 'Πρακτικό κουίζ',
      'vocabulary': 'Λεξιλόγιο',
      'grammar': 'Γραμματική',
      'pronounce': 'Προφορά',
      'listening': 'Ακρόαση',
      'conversation': 'Συνομιλία',
    },
    'ga': {
      'lessons': 'Ceachtanna',
      'chatAI': 'Chat AI',
      'video': 'Físeán',
      'reels': 'Reels',
      'profile': 'Próifíl',
      'exercise': 'CLEACHTAÍ',
      'practicalQuiz': 'Tráth na gCeist Praiticiúil',
      'vocabulary': 'Stór Focal',
      'grammar': 'Gramadach',
      'pronounce': 'Fuaimniú',
      'listening': 'Éisteacht',
      'conversation': 'Comhrá',
    },
    'lv': {
      'lessons': 'Nodarbības',
      'chatAI': 'Chat AI',
      'video': 'Video',
      'reels': 'Reels',
      'profile': 'Profils',
      'exercise': 'UZDEVUMI',
      'practicalQuiz': 'Praktiskais tests',
      'vocabulary': 'Vārdkrājums',
      'grammar': 'Gramatika',
      'pronounce': 'Izruna',
      'listening': 'Klausīšanās',
      'conversation': 'Saruna',
    },
    'lt': {
      'lessons': 'Pamokos',
      'chatAI': 'Chat AI',
      'video': 'Vaizdo įrašas',
      'reels': 'Reels',
      'profile': 'Profilis',
      'exercise': 'PRATIMAI',
      'practicalQuiz': 'Praktinis testas',
      'vocabulary': 'Žodynas',
      'grammar': 'Gramatika',
      'pronounce': 'Tarimas',
      'listening': 'Klausymas',
      'conversation': 'Pokalbis',
    },
    'mt': {
      'lessons': 'Lezzjonijiet',
      'chatAI': 'Chat AI',
      'video': 'Vidjo',
      'reels': 'Reels',
      'profile': 'Profil',
      'exercise': 'EŻERĊIZZJI',
      'practicalQuiz': 'Kwiżż Prattiku',
      'vocabulary': 'Vokabularju',
      'grammar': 'Grammatika',
      'pronounce': 'Pronunzja',
      'listening': 'Tisma\'',
      'conversation': 'Konversazzjoni',
    },
    'pl': {
      'lessons': 'Lekcje',
      'chatAI': 'Chat AI',
      'video': 'Wideo',
      'reels': 'Reels',
      'profile': 'Profil',
      'exercise': 'ĆWICZENIA',
      'practicalQuiz': 'Quiz praktyczny',
      'vocabulary': 'Słownictwo',
      'grammar': 'Gramatyka',
      'pronounce': 'Wymowa',
      'listening': 'Słuchanie',
      'conversation': 'Konwersacja',
    },
    'pt': {
      'lessons': 'Lições',
      'chatAI': 'Chat AI',
      'video': 'Vídeo',
      'reels': 'Reels',
      'profile': 'Perfil',
      'exercise': 'EXERCÍCIOS',
      'practicalQuiz': 'Quiz Prático',
      'vocabulary': 'Vocabulário',
      'grammar': 'Gramática',
      'pronounce': 'Pronúncia',
      'listening': 'Audição',
      'conversation': 'Conversação',
    },
    'ro': {
      'lessons': 'Lecții',
      'chatAI': 'Chat AI',
      'video': 'Video',
      'reels': 'Reels',
      'profile': 'Profil',
      'exercise': 'EXERCIȚII',
      'practicalQuiz': 'Test Practic',
      'vocabulary': 'Vocabular',
      'grammar': 'Gramatică',
      'pronounce': 'Pronunție',
      'listening': 'Ascultare',
      'conversation': 'Conversație',
    },
    'sk': {
      'lessons': 'Lekcie',
      'chatAI': 'Chat AI',
      'video': 'Video',
      'reels': 'Reels',
      'profile': 'Profil',
      'exercise': 'CVIČENIA',
      'practicalQuiz': 'Praktický kvíz',
      'vocabulary': 'Slovná zásoba',
      'grammar': 'Gramatika',
      'pronounce': 'Výslovnosť',
      'listening': 'Počúvanie',
      'conversation': 'Konverzácia',
    },
    'sl': {
      'lessons': 'Lekcije',
      'chatAI': 'Chat AI',
      'video': 'Video',
      'reels': 'Reels',
      'profile': 'Profil',
      'exercise': 'VAJE',
      'practicalQuiz': 'Praktični kviz',
      'vocabulary': 'Besedišče',
      'grammar': 'Slovnica',
      'pronounce': 'Izgovorjava',
      'listening': 'Poslušanje',
      'conversation': 'Pogovor',
    },
    'sv': {
      'lessons': 'Lektioner',
      'chatAI': 'Chat AI',
      'video': 'Video',
      'reels': 'Reels',
      'profile': 'Profil',
      'exercise': 'ÖVNINGAR',
      'practicalQuiz': 'Praktiskt quiz',
      'vocabulary': 'Ordförråd',
      'grammar': 'Grammatik',
      'pronounce': 'Uttal',
      'listening': 'Lyssning',
      'conversation': 'Konversation',
    },
    'hu': {
      'lessons': 'Leckék',
      'chatAI': 'Chat AI',
      'video': 'Videó',
      'reels': 'Reels',
      'profile': 'Profil',
      'exercise': 'GYAKORLATOK',
      'practicalQuiz': 'Gyakorlati kvíz',
      'vocabulary': 'Szókincs',
      'grammar': 'Nyelvtan',
      'pronounce': 'Kiejtés',
      'listening': 'Hallgatás',
      'conversation': 'Beszélgetés',
    },
    'hr': {
      'lessons': 'Lekcije',
      'chatAI': 'Chat AI',
      'video': 'Video',
      'reels': 'Reels',
      'profile': 'Profil',
      'exercise': 'VJEŽBE',
      'practicalQuiz': 'Praktični kviz',
      'vocabulary': 'Rječnik',
      'grammar': 'Gramatika',
      'pronounce': 'Izgovor',
      'listening': 'Slušanje',
      'conversation': 'Razgovor',
    },
    'nl': {
      'lessons': 'Lessen',
      'chatAI': 'Chat AI',
      'video': 'Video',
      'reels': 'Reels',
      'profile': 'Profiel',
      'exercise': 'OEFENINGEN',
      'practicalQuiz': 'Praktische quiz',
      'vocabulary': 'Woordenschat',
      'grammar': 'Grammatica',
      'pronounce': 'Uitspraak',
      'listening': 'Luisteren',
      'conversation': 'Gesprek',
    },
  };

  String _t(String key) {
    return _translations[_selectedLanguage]?[key] ??
        _translations['en']?[key] ??
        key;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _loadUserLanguage();
    _languageService.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _languageService.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    if (mounted) {
      setState(() {
        _selectedLanguage = _languageService.currentLanguage;
      });
    }
  }

  Future<void> _loadUserLanguage() async {
    await _languageService.loadUserLanguage();
    if (mounted) {
      setState(() {
        _selectedLanguage = _languageService.currentLanguage;
      });
    }
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      _animationController.forward(from: 0);
    }
  }

  // ignore: unused_element
  Color _getTabColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFF7C3AED);
      case 1:
        return const Color(0xFF3B82F6);
      case 2:
        return const Color(0xFFFF6B9D);
      case 3:
        return const Color(0xFFFFA06B);
      case 4:
        return const Color(0xFF6BCF7F);
      default:
        return const Color(0xFF7C3AED);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      LessonsPage(
        language: widget.language,
        languageCode: widget.languageCode,
        flag: widget.flag,
        level: '',
      ),
      const ScreenChatAI(),
      const ScreenVideoCall(),
      const ScreenReels(),
      const ScreenAccount(),
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, const Color(0xFF7C3AED).withOpacity(0.02)],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: _selectedIndex == 0
                  ? _buildHomeContent()
                  : screens[_selectedIndex],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onItemTapped,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  height: 70,
                  indicatorColor: const Color(0xFF7C3AED).withOpacity(0.15),
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                  destinations: [
                    NavigationDestination(
                      icon: Icon(
                        Icons.school_outlined,
                        color: const Color(0xFF7C3AED).withOpacity(0.6),
                      ),
                      selectedIcon: const Icon(
                        Icons.school,
                        color: Color(0xFF7C3AED),
                      ),
                      label: _t('lessons'),
                    ),
                    NavigationDestination(
                      icon: Icon(
                        Icons.chat_outlined,
                        color: const Color(0xFF3B82F6).withOpacity(0.6),
                      ),
                      selectedIcon: const Icon(
                        Icons.chat,
                        color: Color(0xFF3B82F6),
                      ),
                      label: _t('chatAI'),
                    ),
                    NavigationDestination(
                      icon: Icon(
                        Icons.video_call_outlined,
                        color: const Color(0xFFFF6B9D).withOpacity(0.6),
                      ),
                      selectedIcon: const Icon(
                        Icons.video_call,
                        color: Color(0xFFFF6B9D),
                      ),
                      label: _t('video'),
                    ),
                    NavigationDestination(
                      icon: Icon(
                        Icons.movie_outlined,
                        color: const Color(0xFFFFA06B).withOpacity(0.6),
                      ),
                      selectedIcon: const Icon(
                        Icons.movie,
                        color: Color(0xFFFFA06B),
                      ),
                      label: _t('reels'),
                    ),
                    NavigationDestination(
                      icon: Icon(
                        Icons.person_outline,
                        color: const Color(0xFF6BCF7F).withOpacity(0.6),
                      ),
                      selectedIcon: const Icon(
                        Icons.person,
                        color: Color(0xFF6BCF7F),
                      ),
                      label: _t('profile'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          floating: false,
          pinned: true,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF7C3AED),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade400, Colors.blue.shade700],
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Text(widget.flag, style: const TextStyle(fontSize: 60)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        widget.language,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Text(
                _t('exercise'),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
                children: [
                  _buildLessonCard(
                    context,
                    _t('practicalQuiz'),
                    Icons.quiz,
                    const Color(0xFFFF6B9D),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MultilingualExerciseScreen(
                            language: widget.language,
                            languageCode: widget.languageCode,
                            level: widget.level,
                            nativeLanguageCode: 'en',
                          ),
                        ),
                      );
                    },
                  ),
                  _buildLessonCard(
                    context,
                    _t('vocabulary'),
                    Icons.book,
                    const Color(0xFF6BCF7F),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MultilingualExerciseScreen(
                            language: widget.language,
                            languageCode: widget.languageCode,
                            level: widget.level,
                            nativeLanguageCode: 'en',
                          ),
                        ),
                      );
                    },
                  ),
                  _buildLessonCard(
                    context,
                    _t('grammar'),
                    Icons.text_fields,
                    const Color(0xFFFFA06B),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MultilingualExerciseScreen(
                            language: widget.language,
                            languageCode: widget.languageCode,
                            level: widget.level,
                            nativeLanguageCode: 'en',
                          ),
                        ),
                      );
                    },
                  ),
                  _buildLessonCard(
                    context,
                    _t('pronounce'),
                    Icons.record_voice_over,
                    const Color(0xFF7C3AED),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PronunciaScreen(language: widget.language),
                        ),
                      );
                    },
                  ),
                  _buildLessonCard(
                    context,
                    _t('listening'),
                    Icons.headphones,
                    const Color(0xFF3B82F6),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AscoltoScreen(language: widget.language),
                        ),
                      );
                    },
                  ),
                  _buildLessonCard(
                    context,
                    _t('conversation'),
                    Icons.forum,
                    const Color(0xFFFFD93D),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ConversazioneScreen(language: widget.language),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildLessonCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color, color.withOpacity(0.8)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
