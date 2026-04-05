// lib/presentation/controller/user_controller.dart
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../data/models/user_model.dart';
import '../../data/local/user_repository.dart';

class UserController extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  UserModel? _profileUser;
  List<UserModel> _followers = [];
  List<UserModel> _following = [];
  int _followersCount = 0;
  int _followingCount = 0;
  bool _isFollowing = false;
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  UserModel? get profileUser => _profileUser;
  List<UserModel> get followers => List.unmodifiable(_followers);
  List<UserModel> get following => List.unmodifiable(_following);
  int get followersCount => _followersCount;
  int get followingCount => _followingCount;
  bool get isFollowing => _isFollowing;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  void _clearMessages() {
    _errorMessage = null;
    _successMessage = null;
  }

  // Carica profilo utente
  Future<void> loadUserProfile(String userId) async {
    try {
      _clearMessages();
      _isLoading = true;
      notifyListeners();

      _profileUser = await _userRepository.getUserById(userId);

      await Future.wait([
        _loadFollowersCount(userId),
        _loadFollowingCount(userId),
        _checkIfFollowing(userId),
      ]);
    } catch (e) {
      _errorMessage = 'Errore durante il caricamento del profilo';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Carica followers count
  Future<void> _loadFollowersCount(String userId) async {
    _followersCount = await _userRepository.getFollowersCount(userId);
  }

  // Carica following count
  Future<void> _loadFollowingCount(String userId) async {
    _followingCount = await _userRepository.getFollowingCount(userId);
  }

  // Verifica se segui l'utente
  Future<void> _checkIfFollowing(String userId) async {
    _isFollowing = await _userRepository.isFollowing(userId);
  }

  // Toggle follow/unfollow
  Future<void> toggleFollow(String userId) async {
    try {
      _clearMessages();
      if (_isFollowing) {
        await _userRepository.unfollowUser(userId);
        _isFollowing = false;
        _followersCount--;
      } else {
        await _userRepository.followUser(userId);
        _isFollowing = true;
        _followersCount++;
      }
    } catch (e) {
      _errorMessage = 'Errore durante l\'operazione';
    } finally {
      notifyListeners();
    }
  }

  // Carica followers
  Future<void> loadFollowers(String userId) async {
    try {
      _clearMessages();
      _isLoading = true;
      notifyListeners();

      _followers = await _userRepository.getFollowers(userId);
    } catch (e) {
      _errorMessage = 'Errore durante il caricamento dei followers';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Carica following
  Future<void> loadFollowing(String userId) async {
    try {
      _clearMessages();
      _isLoading = true;
      notifyListeners();

      _following = await _userRepository.getFollowing(userId);
    } catch (e) {
      _errorMessage = 'Errore durante il caricamento dei following';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Aggiorna profilo
  Future<void> updateProfile({
    String? displayName,
    String? bio,
    String? phonePrefix,
    String? phoneNumber,
    String? nationality,
    String? selectedLanguage,
    DateTime? dateOfBirth,
  }) async {
    try {
      _clearMessages();
      _isLoading = true;
      notifyListeners();

      final updatedUser = await _userRepository.updateProfile(
        displayName: displayName,
        bio: bio,
        phonePrefix: phonePrefix,
        phoneNumber: phoneNumber,
        nationality: nationality,
        selectedLanguage: selectedLanguage,
        dateOfBirth: dateOfBirth,
      );

      _profileUser = updatedUser;
      _successMessage = 'Profilo aggiornato con successo!';
    } catch (e) {
      _errorMessage = 'Errore durante l\'aggiornamento del profilo';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Aggiorna avatar
  Future<void> updateAvatar(File avatarFile) async {
    try {
      _clearMessages();
      _isLoading = true;
      notifyListeners();

      final avatarUrl = await _userRepository.updateAvatar(avatarFile);

      if (_profileUser != null) {
        _profileUser = _profileUser!.copyWith(avatarUrl: avatarUrl);
      }

      _successMessage = 'Avatar aggiornato con successo!';
    } catch (e) {
      _errorMessage = 'Errore durante l\'aggiornamento dell\'avatar';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Cerca utenti
  Future<List<UserModel>> searchUsers(String query) async {
    try {
      return await _userRepository.searchUsers(query);
    } catch (e) {
      _errorMessage = 'Errore durante la ricerca';
      notifyListeners();
      return [];
    }
  }

  // Aggiorna abbonamento
  Future<void> updateSubscription({
    required SubscriptionType type,
    required SubscriptionStatus status,
    DateTime? expiryDate,
  }) async {
    try {
      _clearMessages();
      await _userRepository.updateSubscription(
        type: type,
        status: status,
        expiryDate: expiryDate,
      );

      if (_profileUser != null) {
        _profileUser = _profileUser!.copyWith(
          subscriptionType: type,
          subscriptionStatus: status,
          subscriptionExpiryDate: expiryDate,
        );
      }

      _successMessage = 'Abbonamento aggiornato!';
    } catch (e) {
      _errorMessage = 'Errore durante l\'aggiornamento dell\'abbonamento';
    } finally {
      notifyListeners();
    }
  }
}