
import 'package:flutter/material.dart';
import 'package:login_ora/data/models/language_model.dart';
import 'package:login_ora/presentation/screens/esercizi_screen.dart';
import 'package:uuid/uuid.dart';

class LezioniTab extends StatelessWidget {
  final String lingua;
  
  const LezioniTab({super.key, required this.lingua});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lezioni'),
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildLezioneCard(
            context,
            'Vocabolario Base',
            'Impara le 100 parole più comuni',
            Icons.book,
            Colors.blue,
            50,
          ),
          _buildLezioneCard(
            context,
            'Grammatica Essenziale',
            'Verbi, tempi e strutture base',
            Icons.edit,
            Colors.green,
            30,
          ),
          _buildLezioneCard(
            context,
            'Conversazione',
            'Dialoghi e frasi pratiche',
            Icons.chat,
            Colors.orange,
            70,
          ),
          _buildLezioneCard(
            context,
            'Ascolto e Pronuncia',
            'Comprensione audio',
            Icons.headphones,
            Colors.purple,
            20,
          ),
          _buildLezioneCard(
            context,
            'Lettura',
            'Testi e comprensione scritta',
            Icons.menu_book,
            Colors.red,
            40,
          ),
          _buildLezioneCard(
            context,
            'Scrittura',
            'Esercizi di composizione',
            Icons.create,
            Colors.teal,
            10,
          ),
        ],
      ),
    );
  }

  Widget _buildLezioneCard(
    BuildContext context,
    String titolo,
    String sottotitolo,
    IconData icon,
    Color colore,
    int progresso,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EserciziScreen(
                  titolo: titolo,
                  lingua: lingua, 
                  lesson: Lesson(
                    id: const Uuid().v4(),
                    title: titolo,
                    description: sottotitolo,
                    level: 1,
                    vocabulary: [],
                    grammar: [],
                    exercises: [],
                    category: lingua,
                  ),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: colore.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: colore, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titolo,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      sottotitolo,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: progresso / 100,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(colore),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '$progresso%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colore,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}