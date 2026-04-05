
import 'package:flutter/material.dart';
import 'package:login_ora/presentation/screens/videocall_screen.dart';

class VideoCallTab extends StatefulWidget {
  const VideoCallTab({super.key});

  @override
  _VideoCallTabState createState() => _VideoCallTabState();
}

class _VideoCallTabState extends State<VideoCallTab> {
  bool micEnabled = false;
  bool cameraEnabled = false;
  bool isSearching = false;

  void _startSearch() async {
    setState(() => isSearching = true);

    // Simula ricerca partner
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    setState(() => isSearching = false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Partner Trovato! 🎉'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '🇬🇧',
              style: TextStyle(fontSize: 60),
            ),
            SizedBox(height: 10),
            Text('Connesso con un madrelingua inglese'),
            Text('dalla regione: Londra', style: TextStyle(color: Colors.grey)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annulla'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenVideoCall(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C63FF),
            ),
            child: const Text('Inizia Chat', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Call'),
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF4CAF50)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.videocam,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Trova un partner linguistico',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Pratica la lingua con madrelingua reali',
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text('Microfono'),
                        secondary: const Icon(Icons.mic),
                        value: micEnabled,
                        onChanged: (val) => setState(() => micEnabled = val),
                        activeThumbColor: const Color(0xFF6C63FF),
                      ),
                      const Divider(),
                      SwitchListTile(
                        title: const Text('Fotocamera'),
                        secondary: const Icon(Icons.camera_alt),
                        value: cameraEnabled,
                        onChanged: (val) => setState(() => cameraEnabled = val),
                        activeThumbColor: const Color(0xFF6C63FF),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              isSearching
                  ? const Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Cercando un partner...',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _startSearch,
                        icon: const Icon(Icons.search),
                        label: const Text('Trova Partner'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
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
}
