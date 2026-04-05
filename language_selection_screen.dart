import 'package:flutter/material.dart';
import 'package:login_ora/presentation/log_register/login_screen.dart';
import 'package:login_ora/presentation/screens/tab_language/level_selection_screen.dart';
import 'package:login_ora/services/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  // Lista completa delle 26 lingue europee supportate da ORA
  final List<Map<String, String>> languages = [
    {'name': 'Italiano', 'flag': '🇮🇹', 'code': 'it'},
    {'name': 'Inglese', 'flag': '🇬🇧', 'code': 'en'},
    {'name': 'Spagnolo', 'flag': '🇪🇸', 'code': 'es'},
    {'name': 'Francese', 'flag': '🇫🇷', 'code': 'fr'},
    {'name': 'Tedesco', 'flag': '🇩🇪', 'code': 'de'},
    {'name': 'Russo', 'flag': '🇷🇺', 'code': 'ru'},
    {'name': 'Cinese', 'flag': '🇨🇳', 'code': 'zh'},
    {'name': 'Olandese', 'flag': '🇳🇱', 'code': 'nl'},
    {'name': 'Ceco', 'flag': '🇨🇿', 'code': 'cs'},
    {'name': 'Bulgaro', 'flag': '🇧🇬', 'code': 'bg'},
    {'name': 'Croato', 'flag': '🇭🇷', 'code': 'hr'},
    {'name': 'Danese', 'flag': '🇩🇰', 'code': 'da'},
    {'name': 'Estone', 'flag': '🇪🇪', 'code': 'et'},
    {'name': 'Finlandese', 'flag': '🇫🇮', 'code': 'fi'},
    {'name': 'Greco', 'flag': '🇬🇷', 'code': 'el'},
    {'name': 'Irlandese', 'flag': '🇮🇪', 'code': 'ga'},
    {'name': 'Lettone', 'flag': '🇱🇻', 'code': 'lv'},
    {'name': 'Lituano', 'flag': '🇱🇹', 'code': 'lt'},
    {'name': 'Maltese', 'flag': '🇲🇹', 'code': 'mt'},
    {'name': 'Polacco', 'flag': '🇵🇱', 'code': 'pl'},
    {'name': 'Portoghese', 'flag': '🇵🇹', 'code': 'pt'},
    {'name': 'Rumeno', 'flag': '🇷🇴', 'code': 'ro'},
    {'name': 'Slovacco', 'flag': '🇸🇰', 'code': 'sk'},
    {'name': 'Sloveno', 'flag': '🇸🇮', 'code': 'sl'},
    {'name': 'Svedese', 'flag': '🇸🇪', 'code': 'sv'},
    {'name': 'Ungherese', 'flag': '🇭🇺', 'code': 'hu'},
  ];

  // Colori ORA ciclici per le card
  final List<Color> _cardColors = [
    const Color(0xFFFF6B9D), // Rosa
    const Color(0xFFFFA06B), // Arancione
    const Color(0xFFFFD93D), // Giallo
    const Color(0xFF6BCF7F), // Verde
    const Color(0xFF7C3AED), // Viola
    const Color(0xFF3B82F6), // Blu
  ];

  Color _getCardColor(int index) {
    return _cardColors[index % _cardColors.length];
  }

  Future<void> _signOut() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.signOut();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF7C3AED), // Viola ORA
              Color(0xFFA855F7),
              Colors.white,
            ],
            stops: [0.0, 0.35, 0.75],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header con logo e titolo
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: isSmallScreen ? 20 : 32,
                ),
                child: Column(
                  children: [
                    // Row con logout e logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Bottone logout
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.logout, color: Colors.white),
                            onPressed: _signOut,
                            tooltip: 'Logout',
                          ),
                        ),
                        // Logo ORA
                        Hero(
                          tag: 'ora_logo',
                          child: Container(
                            width: isSmallScreen ? 80 : 100,
                            height: isSmallScreen ? 80 : 100,
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
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'ORA',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 24 : 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Spacer per bilanciare
                        const SizedBox(width: 48),
                      ],
                    ),

                    SizedBox(height: isSmallScreen ? 24 : 32),

                    // Titolo principale
                    Text(
                      'Quale lingua vuoi imparare?',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 24 : 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    // Sottotitolo
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.language,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '26 lingue europee disponibili',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white.withOpacity(0.95),
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

              // Grid lingue
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
                    child: GridView.builder(
                      padding: EdgeInsets.all(isSmallScreen ? 16 : 24),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isSmallScreen ? 2 : 3,
                        childAspectRatio: 1.4,
                        crossAxisSpacing: isSmallScreen ? 14 : 18,
                        mainAxisSpacing: isSmallScreen ? 14 : 18,
                      ),
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        final lang = languages[index];
                        final cardColor = _getCardColor(index);

                        return _buildLanguageCard(
                          context,
                          lang,
                          cardColor,
                          isSmallScreen,
                        );
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

  Widget _buildLanguageCard(
    BuildContext context,
    Map<String, String> lang,
    Color color,
    bool isSmall,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          // Feedback aptico
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LevelSelectionPage(
                language: lang['name']!,
                languageCode: lang['code']!,
                flag: lang['flag']!,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
            ),
            border: Border.all(color: color.withOpacity(0.3), width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Flag emoji
              Text(
                lang['flag']!,
                style: TextStyle(fontSize: isSmall ? 44 : 52),
              ),

              SizedBox(height: isSmall ? 8 : 10),

              // Nome lingua
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  lang['name']!,
                  style: TextStyle(
                    fontSize: isSmall ? 15 : 17,
                    fontWeight: FontWeight.bold,
                    color: color,
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 4),

              // Indicatore "Tap"
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.touch_app, size: 12, color: color),
                    const SizedBox(width: 4),
                    Text(
                      'Inizia',
                      style: TextStyle(
                        fontSize: 11,
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
