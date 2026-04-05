import 'package:flutter/material.dart';
import 'dart:async';

class ScreenVideoCall extends StatefulWidget {
  const ScreenVideoCall({super.key});

  @override
  State<ScreenVideoCall> createState() => _ScreenVideoCallState();
}

class _ScreenVideoCallState extends State<ScreenVideoCall> with TickerProviderStateMixin {
  bool _isSearching = false;
  bool _isConnected = false;
  bool _isMicEnabled = true;
  bool _isCameraEnabled = true;
  final bool _isVideoCallAvailable = false; // Trial limitation
  int _connectionTime = 0;
  Timer? _connectionTimer;
  late AnimationController _pulseController;
  
  // Statistiche utente simulato
  String _currentUserName = 'Marco';
  String _currentUserLanguage = 'Inglese';
  String _currentUserFlag = '🇬🇧';
  String _currentUserLevel = 'Intermedio';
  List<String> _userInterests = ['Viaggi', 'Cinema', 'Sport'];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _connectionTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _startSearching() {
    // Mostra dialog per trial
    _showTrialDialog();
  }

  void _simulateConnection() {
    setState(() => _isSearching = true);
    
    // Simula ricerca con diversi utenti
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isSearching = false;
          _isConnected = true;
          _connectionTime = 0;
          _generateRandomUser();
        });
        
        // Avvia timer connessione
        _connectionTimer?.cancel();
        _connectionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (mounted) {
            setState(() => _connectionTime++);
          }
        });
      }
    });
  }

  void _generateRandomUser() {
    final names = ['Marco', 'Sophie', 'Hans', 'Maria', 'Pierre', 'Anna'];
    final languages = [
      {'name': 'Inglese', 'flag': '🇬🇧'},
      {'name': 'Francese', 'flag': '🇫🇷'},
      {'name': 'Tedesco', 'flag': '🇩🇪'},
      {'name': 'Spagnolo', 'flag': '🇪🇸'},
      {'name': 'Italiano', 'flag': '🇮🇹'},
    ];
    final levels = ['Principiante', 'Intermedio', 'Avanzato'];
    final interests = [
      ['Viaggi', 'Cinema', 'Sport'],
      ['Musica', 'Arte', 'Cucina'],
      ['Tecnologia', 'Libri', 'Fotografia'],
      ['Natura', 'Fitness', 'Gaming'],
    ];
    
    final random = DateTime.now().millisecondsSinceEpoch;
    final lang = languages[random % languages.length];
    
    setState(() {
      _currentUserName = names[random % names.length];
      _currentUserLanguage = lang['name']!;
      _currentUserFlag = lang['flag']!;
      _currentUserLevel = levels[random % levels.length];
      _userInterests = interests[random % interests.length];
    });
  }

  void _disconnect() {
    _connectionTimer?.cancel();
    setState(() {
      _isConnected = false;
      _isSearching = false;
      _connectionTime = 0;
    });
  }

  void _nextUser() {
    setState(() => _isConnected = false);
    _connectionTimer?.cancel();
    _simulateConnection();
  }

  void _showTrialDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF7C3AED), Color(0xFFA855F7)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.video_call, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text('Video Call', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Le videochiamate sono disponibili solo nella versione Premium! 🎥',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 16),
            const Text(
              'Con Premium ottieni:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            _buildFeature('📹', 'Videochiamate illimitate'),
            _buildFeature('🌍', 'Match con 26 lingue'),
            _buildFeature('🎯', 'Filtri per livello e interessi'),
            _buildFeature('💬', 'Chat integrata'),
            _buildFeature('⭐', 'Profili verificati'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF7C3AED).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF7C3AED).withOpacity(0.3),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Color(0xFF7C3AED), size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Puoi provare una demo simulata!',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF7C3AED),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _simulateConnection(); // Avvia demo
            },
            child: Text('Prova Demo', style: TextStyle(color: Colors.grey[600])),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7C3AED), Color(0xFFA855F7)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Funzionalità Premium in arrivo! 🚀'),
                    backgroundColor: Color(0xFF7C3AED),
                  ),
                );
              },
              child: const Text(
                'UPGRADE ORA',
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

  Widget _buildFeature(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1E1B4B),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B9D), Color(0xFFFFA06B)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF6B9D).withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const Icon(Icons.video_call, size: 22, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Video Call Roulette',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (_isConnected)
                    Text(
                      'In chiamata • ${_formatTime(_connectionTime)}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF6BCF7F),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFA06B), Color(0xFFFFD93D)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFA06B).withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.workspace_premium, size: 14, color: Colors.white),
                SizedBox(width: 4),
                Text(
                  'DEMO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Area Video
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1E1B4B),
                    Color(0xFF312E81),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Video Remoto
                  Center(
                    child: SingleChildScrollView(
                      child: _isConnected
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 40),
                                // Avatar utente
                                Container(
                                  width: 140,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFFF6B9D),
                                        Color(0xFFFFA06B),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFFFF6B9D).withOpacity(0.5),
                                        blurRadius: 30,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(Icons.person, size: 70, color: Colors.white),
                                ),
                                
                                const SizedBox(height: 20),
                                
                                // Nome utente
                                Text(
                                  _currentUserName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                
                                const SizedBox(height: 12),
                                
                                // Badge lingua
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF6BCF7F),
                                        Color(0xFF4CAF50),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF6BCF7F).withOpacity(0.3),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(_currentUserFlag, style: const TextStyle(fontSize: 18)),
                                      const SizedBox(width: 8),
                                      Text(
                                        _currentUserLanguage,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                const SizedBox(height: 16),
                                
                                // Info aggiuntive
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 40),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.2),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.school, color: Colors.white70, size: 16),
                                          const SizedBox(width: 6),
                                          Text(
                                            'Livello: $_currentUserLevel',
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 6,
                                        runSpacing: 6,
                                        alignment: WrapAlignment.center,
                                        children: _userInterests.map((interest) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF7C3AED).withOpacity(0.3),
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(
                                                color: const Color(0xFF7C3AED).withOpacity(0.5),
                                              ),
                                            ),
                                            child: Text(
                                              interest,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                const SizedBox(height: 20),
                              ],
                            )
                          : _isSearching
                              ? const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 6,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xFFA855F7),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 32),
                                    Text(
                                      'Cercando un partner...',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Connessione in corso',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnimatedBuilder(
                                      animation: _pulseController,
                                      builder: (context, child) {
                                        return Transform.scale(
                                          scale: 1.0 + (_pulseController.value * 0.1),
                                          child: Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  const Color(0xFF7C3AED).withOpacity(0.3),
                                                  const Color(0xFFA855F7).withOpacity(0.3),
                                                ],
                                              ),
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF7C3AED).withOpacity(
                                                    0.3 * _pulseController.value,
                                                  ),
                                                  blurRadius: 20,
                                                  spreadRadius: 10,
                                                ),
                                              ],
                                            ),
                                            child: const Icon(
                                              Icons.video_call,
                                              size: 60,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    const Text(
                                      'Pratica con madrelingua',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 40),
                                      child: Text(
                                        'Connettiti con persone da tutto il mondo',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                    ),
                  ),
                  
                  // Video Locale (PiP)
                  if (_isConnected || _isSearching)
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        width: 100,
                        height: 140,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF312E81),
                              Color(0xFF4C1D95),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFA855F7),
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF7C3AED).withOpacity(0.5),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                _isCameraEnabled
                                    ? Icons.person
                                    : Icons.videocam_off,
                                size: 40,
                                color: Colors.white70,
                              ),
                            ),
                            Positioned(
                              bottom: 6,
                              left: 6,
                              right: 6,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Tu',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          // Controlli - FIXED per evitare overflow
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 20,
              bottom: 20 + MediaQuery.of(context).viewPadding.bottom,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1B4B),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: _isConnected
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildControlButton(
                          icon: _isMicEnabled ? Icons.mic : Icons.mic_off,
                          label: 'Mic',
                          color: _isMicEnabled ? const Color(0xFF6BCF7F) : const Color(0xFFFF6B9D),
                          onTap: () => setState(() => _isMicEnabled = !_isMicEnabled),
                        ),
                        _buildControlButton(
                          icon: _isCameraEnabled ? Icons.videocam : Icons.videocam_off,
                          label: 'Camera',
                          color: _isCameraEnabled ? const Color(0xFF3B82F6) : const Color(0xFFFF6B9D),
                          onTap: () => setState(() => _isCameraEnabled = !_isCameraEnabled),
                        ),
                        _buildControlButton(
                          icon: Icons.call_end,
                          label: 'Termina',
                          color: const Color(0xFFFF6B9D),
                          onTap: _disconnect,
                        ),
                        _buildControlButton(
                          icon: Icons.skip_next,
                          label: 'Prossimo',
                          color: const Color(0xFFFFD93D),
                          onTap: _nextUser,
                        ),
                      ],
                    )
                  : Center(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF7C3AED), Color(0xFFA855F7)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF7C3AED).withOpacity(0.5),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ElevatedButton.icon(
                          onPressed: _isSearching ? null : _startSearching,
                          icon: const Icon(Icons.play_arrow, size: 26, color: Colors.white),
                          label: const Text(
                            'Inizia',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(icon, color: color),
            iconSize: 24,
            onPressed: onTap,
            padding: const EdgeInsets.all(10),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}