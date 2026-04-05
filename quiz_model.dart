
class QuizQuestion {
  final String id;
  final String domanda;
  final List<String> opzioni;
  final int rispostaCorretta;
  final String livello;
  final String lingua;

  QuizQuestion({
    required this.id,
    required this.domanda,
    required this.opzioni,
    required this.rispostaCorretta,
    required this.livello,
    required this.lingua,
  });
}
