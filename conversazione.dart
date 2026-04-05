import 'package:flutter/material.dart';

class ConversazioneScreen extends StatefulWidget {
  final String language;

  const ConversazioneScreen({
    super.key,
    required this.language,
  });

  @override
  State<ConversazioneScreen> createState() => _ConversazioneScreenState();
}

class _ConversazioneScreenState extends State<ConversazioneScreen> {
  final List<Map<String, dynamic>> scenarios = [
    {
      'title': 'Al Ristorante',
      'icon': Icons.restaurant,
      'color': const Color(0xFFFFD93D),
      'difficulty': 'Facile',
      'participants': 2,
      'duration': '10 min',
      'description': 'Ordina cibo e bevande in un ristorante',
      'dialogues': [
        {'speaker': 'Cameriere', 'text': 'Buonasera! Posso prendere l\'ordine?'},
        {'speaker': 'Tu', 'text': 'Sì, vorrei...'},
      ],
    },
    {
      'title': 'Shopping',
      'icon': Icons.shopping_bag,
      'color': const Color(0xFFFF6B9D),
      'difficulty': 'Facile',
      'participants': 2,
      'duration': '8 min',
      'description': 'Compra vestiti e chiedi informazioni',
      'dialogues': [
        {'speaker': 'Commesso', 'text': 'Posso aiutarla?'},
        {'speaker': 'Tu', 'text': 'Sto cercando...'},
      ],
    },
    {
      'title': 'Stazione/Aeroporto',
      'icon': Icons.flight,
      'color': const Color(0xFF3B82F6),
      'difficulty': 'Medio',
      'participants': 2,
      'duration': '12 min',
      'description': 'Compra biglietti e chiedi informazioni',
      'dialogues': [
        {'speaker': 'Addetto', 'text': 'Buongiorno, dove deve andare?'},
        {'speaker': 'Tu', 'text': 'Vorrei un biglietto per...'},
      ],
    },
    {
      'title': 'Dal Medico',
      'icon': Icons.local_hospital,
      'color': const Color(0xFF6BCF7F),
      'difficulty': 'Medio',
      'participants': 2,
      'duration': '15 min',
      'description': 'Descrivi sintomi e ricevi consigli',
      'dialogues': [
        {'speaker': 'Dottore', 'text': 'Come si sente oggi?'},
        {'speaker': 'Tu', 'text': 'Non mi sento bene...'},
      ],
    },
    {
      'title': 'Colloquio di Lavoro',
      'icon': Icons.work,
      'color': const Color(0xFF7C3AED),
      'difficulty': 'Difficile',
      'participants': 2,
      'duration': '20 min',
      'description': 'Partecipa a un colloquio professionale',
      'dialogues': [
        {'speaker': 'Recruiter', 'text': 'Mi parli di lei'},
        {'speaker': 'Tu', 'text': 'Sono...'},
      ],
    },
    {
      'title': 'Hotel Check-in',
      'icon': Icons.hotel,
      'color': const Color(0xFFFFA06B),
      'difficulty': 'Facile',
      'participants': 2,
      'duration': '10 min',
      'description': 'Effettua il check-in in hotel',
      'dialogues': [
        {'speaker': 'Receptionist', 'text': 'Ha una prenotazione?'},
        {'speaker': 'Tu', 'text': 'Sì, a nome...'},
      ],
    },
    {
      'title': 'Chiedere Indicazioni',
      'icon': Icons.map,
      'color': const Color(0xFF3B82F6),
      'difficulty': 'Facile',
      'participants': 2,
      'duration': '5 min',
      'description': 'Chiedi e ricevi indicazioni stradali',
      'dialogues': [
        {'speaker': 'Passante', 'text': 'Mi dica!'},
        {'speaker': 'Tu', 'text': 'Scusi, dove si trova...'},
      ],
    },
    {
      'title': 'Presentazioni',
      'icon': Icons.people,
      'color': const Color(0xFFFF6B9D),
      'difficulty': 'Facile',
      'participants': 3,
      'duration': '8 min',
      'description': 'Presentati e conosci nuove persone',
      'dialogues': [
        {'speaker': 'Persona', 'text': 'Piacere, mi chiamo...'},
        {'speaker': 'Tu', 'text': 'Piacere mio, io sono...'},
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
              const Color(0xFFFFD93D).withOpacity(0.1),
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
                    colors: [Color(0xFFFFD93D), Color(0xFFFFA06B)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFD93D).withOpacity(0.3),
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
                                'Conversazione',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Pratica dialoghi reali',
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
                          child: const Icon(Icons.forum, color: Colors.white, size: 28),
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
                          Icon(Icons.lightbulb_outline, color: Colors.white, size: 20),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Scegli uno scenario e pratica la conversazione',
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

              // Lista Scenari
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: scenarios.length,
                  itemBuilder: (context, index) {
                    return _buildScenarioCard(scenarios[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showCustomScenarioDialog();
        },
        icon: const Icon(Icons.add),
        label: const Text('Personalizza'),
        backgroundColor: const Color(0xFFFFD93D),
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildScenarioCard(Map<String, dynamic> scenario) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (scenario['color'] as Color).withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _showDialoguePreview(scenario),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            (scenario['color'] as Color).withOpacity(0.3),
                            (scenario['color'] as Color).withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: (scenario['color'] as Color).withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        scenario['icon'] as IconData,
                        color: scenario['color'] as Color,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            scenario['title'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            scenario['description'],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: scenario['color'] as Color,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildInfoChip(
                      Icons.signal_cellular_alt,
                      scenario['difficulty'],
                      _getDifficultyColor(scenario['difficulty']),
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      Icons.people,
                      '${scenario['participants']} persone',
                      Colors.grey[600]!,
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      Icons.access_time,
                      scenario['duration'],
                      Colors.grey[600]!,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.bold,
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

  void _showDialoguePreview(Map<String, dynamic> scenario) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    scenario['color'] as Color,
                    (scenario['color'] as Color).withOpacity(0.7),
                  ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      scenario['icon'] as IconData,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scenario['title'],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          scenario['description'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Dialoghi
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: (scenario['dialogues'] as List).length,
                itemBuilder: (context, index) {
                  final dialogue = scenario['dialogues'][index];
                  final isUser = dialogue['speaker'] == 'Tu';
                  
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      decoration: BoxDecoration(
                        gradient: isUser
                            ? LinearGradient(
                                colors: [
                                  scenario['color'] as Color,
                                  (scenario['color'] as Color).withOpacity(0.8),
                                ],
                              )
                            : null,
                        color: isUser ? null : Colors.grey[100],
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(isUser ? 16 : 4),
                          bottomRight: Radius.circular(isUser ? 4 : 16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dialogue['speaker'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isUser ? Colors.white.withOpacity(0.8) : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            dialogue['text'],
                            style: TextStyle(
                              fontSize: 15,
                              color: isUser ? Colors.white : Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Buttons
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: scenario['color'] as Color),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'CHIUDI',
                        style: TextStyle(
                          color: scenario['color'] as Color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('🎭 Avvio conversazione "${scenario['title']}"...'),
                            backgroundColor: scenario['color'] as Color,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: scenario['color'] as Color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'INIZIA CONVERSAZIONE',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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

  void _showCustomScenarioDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD93D).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.edit, color: Color(0xFFFFD93D), size: 24),
            ),
            const SizedBox(width: 12),
            const Text('Scenario Personalizzato', style: TextStyle(fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Crea uno scenario di conversazione personalizzato in base alle tue esigenze!',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Titolo scenario',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.title, color: Color(0xFFFFD93D)),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: 'Descrizione',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.description, color: Color(0xFFFFD93D)),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annulla', style: TextStyle(color: Colors.grey[600])),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFD93D), Color(0xFFFFA06B)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Scenario personalizzato creato!'),
                    backgroundColor: Color(0xFF6BCF7F),
                  ),
                );
              },
              child: const Text(
                'CREA',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}