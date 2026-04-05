import 'package:flutter/material.dart';
import 'package:login_ora/presentation/screens/tab_language/quiz_entry_screen.dart';

class LevelSelectionPage extends StatelessWidget {
  final String language;
  final String languageCode;
  final String flag;
  final dynamic localeProvider;

  const LevelSelectionPage({
    super.key,
    required this.language,
    required this.languageCode,
    required this.flag,
    this.localeProvider,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    // Livelli con colori ORA specifici
    final levels = [
      {
        'name': 'Principiante',
        'description': 'Basi fondamentali della lingua',
        'details': 'Saluti, numeri, colori, frasi base',
        'icon': Icons.looks_one,
        'color': const Color(0xFF6BCF7F), // Verde
        'gradient': [const Color(0xFF6BCF7F), const Color(0xFF4CAF50)],
      },
      {
        'name': 'Elementare',
        'description': 'Conversazioni semplici quotidiane',
        'details': 'Verbi base, tempi semplici, domande',
        'icon': Icons.looks_two,
        'color': const Color(0xFF3B82F6), // Blu
        'gradient': [const Color(0xFF3B82F6), const Color(0xFF2563EB)],
      },
      {
        'name': 'Intermedio',
        'description': 'Conversazioni complesse avanzate',
        'details': 'Condizionale, passivo, preposizioni',
        'icon': Icons.looks_3,
        'color': const Color(0xFFFFA06B), // Arancione
        'gradient': [const Color(0xFFFFA06B), const Color(0xFFFF8A50)],
      },
      {
        'name': 'Avanzato',
        'description': 'Padronanza completa della lingua',
        'details': 'Strutture complesse, sottigliezze',
        'icon': Icons.looks_4,
        'color': const Color(0xFFFF6B9D), // Rosa
        'gradient': [const Color(0xFFFF6B9D), const Color(0xFFE91E63)],
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF7C3AED), // Viola ORA
              Color(0xFFA855F7),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header con back button e logo
              Padding(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
                child: Row(
                  children: [
                    // Back button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const Spacer(),
                    // Logo ORA mini
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.3),
                            Colors.white.withOpacity(0.1),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.4),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'O',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Header info lingua
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 24 : 32,
                ),
                child: Column(
                  children: [
                    // Flag grande
                    Text(
                      flag,
                      style: TextStyle(fontSize: isSmallScreen ? 64 : 80),
                    ),
                    SizedBox(height: isSmallScreen ? 16 : 20),

                    // Nome lingua
                    Text(
                      language,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 32 : 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Sottotitolo
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.stars, color: Colors.white, size: 20),
                          SizedBox(width: 10),
                          Text(
                            'Seleziona il tuo livello',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: isSmallScreen ? 24 : 32),

              // Lista livelli
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.all(isSmallScreen ? 20 : 28),
                      itemCount: levels.length,
                      itemBuilder: (context, index) {
                        final level = levels[index];
                        return _buildLevelCard(context, level, isSmallScreen);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelCard(
    BuildContext context,
    Map<String, dynamic> level,
    bool isSmall,
  ) {
    final color = level['color'] as Color;
    final gradient = level['gradient'] as List<Color>;

    return Container(
      margin: EdgeInsets.only(bottom: isSmall ? 16 : 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.25),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => QuizPage(
                  language: language,
                  languageCode: languageCode,
                  level: level['name'] as String,
                  flag: flag,
                  localeProvider: localeProvider,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: color.withOpacity(0.3), width: 2.5),
            ),
            padding: EdgeInsets.all(isSmall ? 20 : 24),
            child: Row(
              children: [
                // Icona livello con gradient
                Container(
                  width: isSmall ? 70 : 80,
                  height: isSmall ? 70 : 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradient),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    level['icon'] as IconData,
                    size: isSmall ? 38 : 44,
                    color: Colors.white,
                  ),
                ),

                SizedBox(width: isSmall ? 18 : 22),

                // Info livello
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nome livello
                      Text(
                        level['name'] as String,
                        style: TextStyle(
                          fontSize: isSmall ? 22 : 24,
                          fontWeight: FontWeight.bold,
                          color: color,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Descrizione
                      Text(
                        level['description'] as String,
                        style: TextStyle(
                          fontSize: isSmall ? 14 : 15,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Dettagli
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          level['details'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Freccia
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_forward_ios, color: color, size: 22),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
