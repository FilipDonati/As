
class ReelService {
  Future<List<Map<String, dynamic>>> caricaReels(
    String regioneUtente,
    String linguaEstera,
  ) async {
    // Carica reels da Firebase Storage
    // 6 dalla regione + 4 dalla lingua estera
    return [];
  }

  Future<void> uploadReel(
    String videoPath,
    String didascalia,
    String lingua,
    String regione,
  ) async {
    // Upload video a Firebase Storage
  }

  Future<void> likeReel(String reelId) async {
    // Aggiungi like
  }
}
