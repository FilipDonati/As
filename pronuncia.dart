import 'package:flutter/material.dart';

class PronunciaScreen extends StatefulWidget {
  final String language;

  const PronunciaScreen({
    super.key,
    required this.language,
  });

  @override
  State<PronunciaScreen> createState() => _PronunciaScreenState();
}

class _PronunciaScreenState extends State<PronunciaScreen> {
  bool isRecording = false;
  int recordingSeconds = 0;
  String? selectedExercise;

  final List<Map<String, dynamic>> exercises = [
    {
      'title': 'Suoni Base',
      'icon': Icons.hearing,
      'color': const Color(0xFF7C3AED),
      'count': 15,
      'phrases': [
        {'text': 'Hello, how are you?', 'phonetic': 'he-ˈlō, ˈhau̇ är ˈyü'},
        {'text': 'Thank you very much', 'phonetic': 'θæŋk juː ˈverē ˈməCH'},
        {'text': 'Good morning!', 'phonetic': 'ɡo͝od ˈmôrniNG'},
      ],
    },
    {
      'title': 'Vocali Difficili',
      'icon': Icons.record_voice_over,
      'color': const Color(0xFFFF6B9D),
      'count': 12,
      'phrases': [
        {'text': 'I eat apples', 'phonetic': 'ī ēt ˈapəlz'},
        {'text': 'The book is on the table', 'phonetic': 'T͟Hə bo͝ok iz än T͟Hə ˈtābəl'},
      ],
    },
    {
      'title': 'Consonanti',
      'icon': Icons.keyboard_voice,
      'color': const Color(0xFF3B82F6),
      'count': 18,
      'phrases': [
        {'text': 'This is a test', 'phonetic': 'T͟His iz ə test'},
        {'text': 'She sells seashells', 'phonetic': 'SHē selz ˈsēˌSHelz'},
      ],
    },
    {
      'title': 'Intonazione',
      'icon': Icons.graphic_eq,
      'color': const Color(0xFFFFA06B),
      'count': 10,
      'phrases': [
        {'text': 'Is this your book?', 'phonetic': 'iz T͟His yər bo͝ok?'},
        {'text': 'What a beautiful day!', 'phonetic': 'wät ə ˈbyo͞odəfəl dā!'},
      ],
    },
    {
      'title': 'Frasi Complete',
      'icon': Icons.chat_bubble,
      'color': const Color(0xFF6BCF7F),
      'count': 25,
      'phrases': [
        {'text': 'I would like to order a coffee', 'phonetic': 'ī ˈwo͝od līk tə ˈôrdər ə ˈkôfē'},
        {'text': 'Where is the nearest station?', 'phonetic': 'wer iz T͟Hə ˈnirəst ˈstāSH(ə)n?'},
      ],
    },
    {
      'title': 'Scioglilingua',
      'icon': Icons.psychology,
      'color': const Color(0xFFFFD93D),
      'count': 8,
      'phrases': [
        {'text': 'Peter Piper picked peppers', 'phonetic': 'ˈpētər ˈpīpər pikt ˈpepərz'},
        {'text': 'Red lorry, yellow lorry', 'phonetic': 'red ˈlôrē, ˈyelō ˈlôrē'},
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
              const Color(0xFF7C3AED).withOpacity(0.1),
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
                    colors: [Color(0xFF7C3AED), Color(0xFFA855F7)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF7C3AED).withOpacity(0.3),
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
                                'Pronuncia',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Migliora la tua pronuncia',
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
                          child: const Icon(Icons.record_voice_over, color: Colors.white, size: 28),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Info Box
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
                      child: const Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.white, size: 20),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Ascolta e ripeti per migliorare la pronuncia',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Lista Esercizi
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return _buildExerciseCard(exercises[index]);
                  },
                ),
              ),
            ],
          ),
        ),
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
            const SizedBox(height: 4),
            Text(
              '${exercise['count']} esercizi disponibili',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        children: [
          const SizedBox(height: 12),
          ...(exercise['phrases'] as List).map((phrase) {
            return _buildPhraseItem(
              phrase['text'],
              phrase['phonetic'],
              exercise['color'] as Color,
            );
          }),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('🎯 Inizia esercizi "${exercise['title']}"'),
                    backgroundColor: exercise['color'] as Color,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: exercise['color'] as Color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'INIZIA ESERCIZI',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhraseItem(String text, String phonetic, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
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
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.volume_up, color: color),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('🔊 Riproduzione audio...'),
                      duration: const Duration(seconds: 1),
                      backgroundColor: color,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.hearing, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  phonetic,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                Icons.mic,
                'Registra',
                color,
                () {
                  setState(() {
                    isRecording = !isRecording;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isRecording ? '🎤 Registrazione...' : '⏹️ Registrazione fermata'),
                      duration: const Duration(seconds: 1),
                      backgroundColor: color,
                    ),
                  );
                },
              ),
              _buildActionButton(
                Icons.play_arrow,
                'Riascolta',
                color,
                () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('▶️ Riproduzione...'),
                      duration: const Duration(seconds: 1),
                      backgroundColor: color,
                    ),
                  );
                },
              ),
              _buildActionButton(
                Icons.check,
                'Valuta',
                color,
                () {
                  _showRatingDialog(color);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
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

  void _showRatingDialog(Color color) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.star, color: color, size: 24),
            ),
            const SizedBox(width: 12),
            const Text('Valutazione', style: TextStyle(fontSize: 20)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF6BCF7F).withOpacity(0.2),
                    const Color(0xFF3B82F6).withOpacity(0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(Icons.emoji_events, color: Color(0xFFFFD93D), size: 60),
                  const SizedBox(height: 16),
                  const Text(
                    'Eccellente!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6BCF7F),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pronuncia: 95%',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Icon(
                        index < 5 ? Icons.star : Icons.star_border,
                        color: const Color(0xFFFFD93D),
                        size: 28,
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Ottimo lavoro! Continua così!',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}