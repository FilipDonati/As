
class LezioneModel {
  final String id;
  final String titolo;
  final String descrizione;
  final String categoria;
  final String lingua;
  final String livello;
  final List<String> contenuti;
  final int durata;
  final bool completata;

  LezioneModel({
    required this.id,
    required this.titolo,
    required this.descrizione,
    required this.categoria,
    required this.lingua,
    required this.livello,
    required this.contenuti,
    required this.durata,
    this.completata = false,
  });
}