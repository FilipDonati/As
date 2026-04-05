
class AIService {
  // Integrazione con API AI (OpenAI, Claude, etc.)
  Future<String> inviaMessaggio(String messaggio, String lingua) async {
    // Chiamata API
    await Future.delayed(const Duration(seconds: 1));
    return "Risposta AI simulata in $lingua";
  }
}