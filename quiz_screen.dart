import 'package:flutter/material.dart';
import 'package:login_ora/presentation/screens/tab_account/profile_setup_screen.dart';

class QuizScreen extends StatefulWidget {
  final String lingua;
  final String livello;
  final dynamic localeProvider;

  const QuizScreen({
    super.key,
    required this.lingua,
    required this.livello,
    required this.localeProvider,
  });

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int domandaCorrente = 0;
  int risposteCorrette = 0;
  int? rispostaSelezionata;
  bool mostraRisultato = false;

  late List<Map<String, dynamic>> domande;

  @override
  void initState() {
    super.initState();
    domande = _generaDomande();
  }

  List<Map<String, dynamic>> _generaDomande() {
    // Quiz personalizzato per livello
    if (widget.livello == 'A1') {
      return [
        {
          'domanda': 'Come si dice "Ciao" in ${widget.lingua}?',
          'opzioni': ['Hello', 'Goodbye', 'Please', 'Thank you'],
          'corretta': 0,
        },
        {
          'domanda': 'Quale è il numero "1"?',
          'opzioni': ['Two', 'Three', 'One', 'Four'],
          'corretta': 2,
        },
        {
          'domanda': 'Colore rosso in inglese?',
          'opzioni': ['Blue', 'Red', 'Green', 'Yellow'],
          'corretta': 1,
        },
      ];
    }
    return [
      {
        'domanda': 'Domanda livello ${widget.livello}',
        'opzioni': ['Opzione A', 'Opzione B', 'Opzione C', 'Opzione D'],
        'corretta': 1,
      },
    ];
  }

  void _verificaRisposta() {
    if (rispostaSelezionata == domande[domandaCorrente]['corretta']) {
      risposteCorrette++;
    }

    setState(() => mostraRisultato = true);

    Future.delayed(const Duration(seconds: 1), () {
      if (domandaCorrente < domande.length - 1) {
        setState(() {
          domandaCorrente++;
          rispostaSelezionata = null;
          mostraRisultato = false;
        });
      } else {
        _completaQuiz();
      }
    });
  }

  void _completaQuiz() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileSetupScreen(
          lingua: widget.lingua,
          livello: widget.livello,
          punteggioQuiz: risposteCorrette,
          localeProvider: widget.localeProvider,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final domanda = domande[domandaCorrente];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Valutazione'),
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: (domandaCorrente + 1) / domande.length,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF6C63FF),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Domanda ${domandaCorrente + 1}/${domande.length}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 10),
            Text(
              domanda['domanda'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ...List.generate((domanda['opzioni'] as List).length, (index) {
              final isCorretta = index == domanda['corretta'];
              final isSelezionata = rispostaSelezionata == index;
              Color? colore;

              if (mostraRisultato) {
                if (isCorretta) {
                  colore = Colors.green;
                } else if (isSelezionata && !isCorretta) {
                  colore = Colors.red;
                }
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: mostraRisultato
                      ? null
                      : () => setState(() => rispostaSelezionata = index),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color:
                          colore ??
                          (isSelezionata
                              ? const Color(0xFF6C63FF).withOpacity(0.1)
                              : Colors.grey[100]),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            colore ??
                            (isSelezionata
                                ? const Color(0xFF6C63FF)
                                : Colors.grey[300]!),
                        width: 2,
                      ),
                    ),
                    child: Text(
                      domanda['opzioni'][index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelezionata
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: rispostaSelezionata != null && !mostraRisultato
                    ? _verificaRisposta
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Conferma',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
