// lib/presentation/controller/auth_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/user_model.dart';
import '../../data/remote/auth_repository.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  UserModel? _currentUser;
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _errorMessage;
  String? _successMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  AuthController() {
    _initAuth();
  }

  void _initAuth() {
    // Ascolta cambiamenti auth state (Firebase User?)
    _authRepository.authStateChanges.listen((User? user) {
      if (user != null) {
        _loadCurrentUser();
      } else {
        _currentUser = null;
        _isAuthenticated = false;
        notifyListeners();
      }
    });

    // Carica utente corrente se già loggato
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        _currentUser = user;
        _isAuthenticated = true;
      } else {
        _currentUser = null;
        _isAuthenticated = false;
      }
    } catch (e) {
      debugPrint('Errore caricamento utente: $e');
    } finally {
      notifyListeners();
    }
  }

  void _clearMessages() {
    _errorMessage = null;
    _successMessage = null;
  }

  // Registrazione
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    String? displayName,
    String? phonePrefix,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? nationality,
    String? selectedLanguage,
  }) async {
    try {
      _clearMessages();
      _isLoading = true;
      notifyListeners();

      final user = await _authRepository.signUp(
        email: email,
        password: password,
        username: username,
        displayName: displayName,
        phonePrefix: phonePrefix,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        nationality: nationality,
        selectedLanguage: selectedLanguage,
      );

      _currentUser = user;
      _isAuthenticated = true;
      _successMessage = 'Account creato con successo!';
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _clearMessages();
      _isLoading = true;
      notifyListeners();

      final user = await _authRepository.signIn(
        email: email,
        password: password,
      );

      _currentUser = user;
      _isAuthenticated = true;
    } catch (e) {
      _errorMessage = 'Credenziali non valide';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout
  Future<void> signOut() async {
    try {
      _clearMessages();
      await _authRepository.signOut();
      _currentUser = null;
      _isAuthenticated = false;
    } catch (e) {
      _errorMessage = 'Errore durante il logout';
    } finally {
      notifyListeners();
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      _clearMessages();
      _isLoading = true;
      notifyListeners();

      await _authRepository.resetPassword(email);
      _successMessage = 'Email di reset password inviata';
    } catch (e) {
      _errorMessage = 'Errore durante il reset password';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Verifica disponibilità username
  Future<bool> isUsernameAvailable(String username) async {
    return _authRepository.isUsernameAvailable(username);
  }
}