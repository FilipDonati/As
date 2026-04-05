import 'package:flutter/material.dart';

class ObiettiviScreen extends StatefulWidget {
  const ObiettiviScreen({super.key});

  @override
  State<ObiettiviScreen> createState() => _ObiettiviScreenState();
}

class _ObiettiviScreenState extends State<ObiettiviScreen> {
  final List<Obiettivo> obiettivi = [
    const Obiettivo(
      titolo: 'Master delle Lingue',
      descrizione: 'Raggiungi 1000 punti totali',
      progresso: 156,
      target: 1000,
      icona: Icons.star,
      colore: Color(0xFFFF6B9D),
    ),
    const Obiettivo(
      titolo: 'Conversazioni Perfette',
      descrizione: 'Completa 50 conversazioni AI',
      progresso: 23,
      target: 50,
      icona: Icons.chat_bubble,
      colore: Color(0xFF7C3AED),
    ),
    const Obiettivo(
      titolo: 'Poliglotta Esperto',
      descrizione: 'Studia 5 lingue diverse',
      progresso: 2,
      target: 5,
      icona: Icons.language,
      colore: Color(0xFF3B82F6),
    ),
    const Obiettivo(
      titolo: 'Video Maestro',
      descrizione: 'Guarda 30 video educativi',
      progresso: 18,
      target: 30,
      icona: Icons.play_circle,
      colore: Color(0xFF6BCF7F),
    ),
    const Obiettivo(
      titolo: 'Studente Dedicato',
      descrizione: 'Studia per 100 ore totali',
      progresso: 34,
      target: 100,
      icona: Icons.access_time,
      colore: Color(0xFFFFA06B),
    ),
    const Obiettivo(
      titolo: 'Pratica Giornaliera',
      descrizione: 'Completa 7 lezioni consecutive',
      progresso: 5,
      target: 7,
      icona: Icons.calendar_today,
      colore: Color(0xFFFFD93D),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFFFFD93D),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'I Miei Obiettivi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFD93D),
                      Color(0xFFFFA06B),
                      Color(0xFFFF6B9D),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.emoji_events,
                    size: 80,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Statistiche generali
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF7C3AED),
                          Color(0xFFA855F7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7C3AED).withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatColumn(
                          '${_obiettiviCompletati()}',
                          'Completati',
                          Icons.check_circle,
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildStatColumn(
                          '${obiettivi.length}',
                          'Totali',
                          Icons.flag,
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildStatColumn(
                          '${_percentualeCompletamento()}%',
                          'Progresso',
                          Icons.trending_up,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Lista obiettivi
                  Text(
                    'OBIETTIVI ATTIVI',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  ...obiettivi.map((obj) => _buildObiettivoCard(obj)),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('🎯 Funzionalità in arrivo!'),
              backgroundColor: Color(0xFFFFD93D),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Nuovo Obiettivo'),
        backgroundColor: const Color(0xFFFFD93D),
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildStatColumn(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildObiettivoCard(Obiettivo obj) {
    final percentuale = (obj.progresso / obj.target * 100).clamp(0, 100);
    final isCompletato = obj.progresso >= obj.target;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: obj.colore.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    obj.icona,
                    color: obj.colore,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              obj.titolo,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                          if (isCompletato)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6BCF7F),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Completato',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        obj.descrizione,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${obj.progresso} / ${obj.target}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: obj.colore,
                            ),
                          ),
                          Text(
                            '${percentuale.toInt()}%',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Progress Bar
          Container(
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: percentuale / 100,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(obj.colore),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  int _obiettiviCompletati() {
    return obiettivi.where((obj) => obj.progresso >= obj.target).length;
  }

  int _percentualeCompletamento() {
    if (obiettivi.isEmpty) return 0;
    final sommaProgressi = obiettivi
        .map((obj) => (obj.progresso / obj.target * 100).clamp(0, 100))
        .reduce((a, b) => a + b);
    return (sommaProgressi / obiettivi.length).round();
  }
}

class Obiettivo {
  final String titolo;
  final String descrizione;
  final int progresso;
  final int target;
  final IconData icona;
  final Color colore;

  const Obiettivo({
    required this.titolo,
    required this.descrizione,
    required this.progresso,
    required this.target,
    required this.icona,
    required this.colore,
  });
}