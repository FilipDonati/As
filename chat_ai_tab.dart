
import 'package:flutter/material.dart';

class ChatAITab extends StatefulWidget {
  final String lingua;

  const ChatAITab({super.key, required this.lingua});

  @override
  _ChatAITabState createState() => _ChatAITabState();
}

class _ChatAITabState extends State<ChatAITab> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messaggi = [];
  int _messaggiRimasti = 5;

  void _inviaMessaggio() {
    if (_controller.text.trim().isEmpty) return;

    if (_messaggiRimasti <= 0) {
      _mostraDialogUpgrade();
      return;
    }

    setState(() {
      _messaggi.add({
        'sender': 'user',
        'text': _controller.text,
      });
      _messaggiRimasti--;
    });

    final messaggioUtente = _controller.text;
    _controller.clear();

    // Simula risposta AI
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messaggi.add({
            'sender': 'ai',
            'text': _generaRispostaAI(messaggioUtente),
          });
        });
      }
    });
  }

  String _generaRispostaAI(String messaggio) {
    // Simula risposta AI in base alla lingua
    final risposte = {
      'en': 'That\'s interesting! Let me help you practice English. 📚',
      'es': '¡Muy bien! Te ayudaré a practicar español. 🇪🇸',
      'fr': 'Très bien! Je vais vous aider à pratiquer le français. 🇫🇷',
    };
    return risposte[widget.lingua] ?? 'Great! Let me help you practice. 😊';
  }

  void _mostraDialogUpgrade() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: Color(0xFF6C63FF)),
            SizedBox(width: 10),
            Text('Trial Terminato'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Hai utilizzato tutti i 5 messaggi gratuiti della versione trial.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Text(
              '✨ Effettua l\'upgrade per messaggi illimitati!',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Chiudi'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Naviga a schermata upgrade
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C63FF),
            ),
            child: const Text('Upgrade Premium', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat AI'),
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        actions: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Trial: $_messaggiRimasti/5',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_messaggi.isEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 80,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Inizia a chattare con l\'AI!',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Hai $_messaggiRimasti messaggi gratuiti',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messaggi.length,
                itemBuilder: (context, index) {
                  final msg = _messaggi[index];
                  final isUser = msg['sender'] == 'user';

                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      decoration: BoxDecoration(
                        gradient: isUser
                            ? const LinearGradient(
                                colors: [Color(0xFF6C63FF), Color(0xFF4CAF50)],
                              )
                            : null,
                        color: isUser ? null : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        msg['text']!,
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Scrivi un messaggio...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onSubmitted: (_) => _inviaMessaggio(),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFF4CAF50)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _inviaMessaggio,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

