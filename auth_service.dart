
class AuthService {
  // Implementa autenticazione Firebase o custom
  Future<bool> login(String email, String password) async {
    // Logica login
    return true;
  }

  Future<bool> register(String email, String password, String nome) async {
    // Logica registrazione
    return true;
  }

  Future<void> logout() async {
    // Logica logout
  }
}