import 'package:flutter/material.dart';

class AscoltoScreen extends StatefulWidget {
  final String language;

  const AscoltoScreen({
    super.key,
    required this.language,
  });

  @override
  State<AscoltoScreen> createState() => _AscoltoScreenState();
}

class _AscoltoScreenState extends State<AscoltoScreen> {
  bool isPlaying = false;
  double currentPosition = 0.0;

  final List<Map<String, dynamic>> listeningExercises = [
    {
      'title': 'Dialoghi Quotidiani',
      'icon': Icons.chat_bubble_outline,
      'color': const Color(0xFF3B82F6),
      'level': 'Principiante',
      'duration': '3-5 min',
      'count': 12,
      'lessons': [
        {
          'title': 'Al Ristorante',
          'duration': '3:24',
          'difficulty': 'Facile',
          'completed': true,
        },
        {
          'title': 'In Negozio',
          'duration': '4:12',
          'difficulty': 'Facile',
          'completed': false,
        },
        {
          'title': 'Chiedere Indicazioni',
          'duration': '3:45',
          'difficulty': 'Medio',
          'completed': false,
        },
      ],
    },
    {
      'title': 'Podcast Brevi',
      'icon': Icons.podcasts,
      'color': const Color(0xFFFF6B9D),
      'level': 'Intermedio',
      'duration': '5-10 min',
      'count': 20,
      'lessons': [
        {
          'title': 'Cultura e Tradizioni',
          'duration': '7:30',
          'difficulty': 'Medio',
          'completed': false,
        },
        {
          'title': 'Tecnologia Moderna',
          'duration': '8:15',
          'difficulty': 'Medio',
          'completed': false,
        },
      ],
    },
    {
      'title': 'Notizie',
      'icon': Icons.newspaper,
      'color': const Color(0xFFFFA06B),
      'level': 'Avanzato',
      'duration': '10-15 min',
      'count': 15,
      'lessons': [
        {
          'title': 'Notizie del Giorno',
          'duration': '12:00',
          'difficulty': 'Difficile',
          'completed': false,
        },
      ],
    },
    {
      'title': 'Storie Brevi',
      'icon': Icons.auto_stories,
      'color': const Color(0xFF7C3AED),
      'level': 'Intermedio',
      'duration': '5-8 min',
      'count': 18,
      'lessons': [
        {
          'title': 'La Volpe e l\'Uva',
          'duration': '5:20',
          'difficulty': 'Medio',
          'completed': false,
        },
      ],
    },
    {
      'title': 'Interviste',
      'icon': Icons.mic,
      'color': const Color(0xFFFFD93D),
      'level': 'Avanzato',
      'duration': '15-20 min',
      'count': 10,
      'lessons': [
        {
          'title': 'Intervista con un Chef',
          'duration': '18:45',
          'difficulty': 'Difficile',
          'completed': false,
        },
      ],
    },
    {
      'title': 'Canzoni',
      'icon': Icons.music_note,
      'color': const Color(0xFF6BCF7F),
      'level': 'Tutti i livelli',
      'duration': '3-5 min',
      'count': 25,
      'lessons': [
        {
          'title': 'Pop Hits',
          'duration': '4:00',
          'difficulty': 'Vario',
          'completed': false,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF3B82F6).withOpacity(0.1),
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
                    colors: [Color(0xFF3B82F6), Color(0xFF7C3AED)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withOpacity(0.3),
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
                              const Text(
                                'Ascolto',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Esercizi di comprensione',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.headphones, color: Colors.white, size: 28),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Stats
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatBox(
                            '45m',
                            'Oggi',
                            Icons.access_time,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatBox(
                            '127',
                            'Completati',
                            Icons.check_circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatBox(
                            '8',
                            'Giorni',
                            Icons.local_fire_department,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Lista Esercizi
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: listeningExercises.length,
                  itemBuilder: (context, index) {
                    return _buildExerciseCard(listeningExercises[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBox(String value, String label, IconData icon) {
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
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(Map<String, dynamic> exercise) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (exercise['color'] as Color).withOpacity(0.15),
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
                (exercise['color'] as Color).withOpacity(0.3),
                (exercise['color'] as Color).withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: (exercise['color'] as Color).withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Icon(
            exercise['icon'] as IconData,
            color: exercise['color'] as Color,
            size: 30,
          ),
        ),
        title: Text(
          exercise['title'],
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (exercise['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    exercise['level'],
                    style: TextStyle(
                      fontSize: 11,
                      color: exercise['color'] as Color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  exercise['duration'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${exercise['count']} lezioni disponibili',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        children: [
          const SizedBox(height: 12),
          ...(exercise['lessons'] as List).map((lesson) {
            return _buildLessonItem(
              lesson['title'],
              lesson['duration'],
              lesson['difficulty'],
              lesson['completed'],
              exercise['color'] as Color,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLessonItem(
    String title,
    String duration,
    String difficulty,
    bool completed,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: completed ? color : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  completed ? Icons.check : Icons.play_arrow,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          duration,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(difficulty).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            difficulty,
                            style: TextStyle(
                              fontSize: 10,
                              color: _getDifficultyColor(difficulty),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Player Mini
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                SliderTheme(
                  data: const SliderThemeData(
                    trackHeight: 4,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                  ),
                  child: Slider(
                    value: currentPosition,
                    min: 0,
                    max: 100,
                    activeColor: color,
                    inactiveColor: Colors.grey[300],
                    onChanged: (value) {
                      setState(() => currentPosition = value);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '0:00',
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.replay_10, size: 20),
                          color: color,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                            size: 36,
                          ),
                          color: color,
                          onPressed: () {
                            setState(() => isPlaying = !isPlaying);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.forward_10, size: 20),
                          color: color,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Text(
                      duration,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuizButton('Quiz', Icons.quiz, color),
              _buildQuizButton('Trascrizione', Icons.description, color),
              _buildQuizButton('Scarica', Icons.download, color),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuizButton(String label, IconData icon, Color color) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$label - Funzionalità in arrivo!'),
            backgroundColor: color,
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Facile':
        return const Color(0xFF6BCF7F);
      case 'Medio':
        return const Color(0xFFFFA06B);
      case 'Difficile':
        return const Color(0xFFFF6B9D);
      default:
        return Colors.grey;
    }
  }
}