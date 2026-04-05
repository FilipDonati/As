// lib/presentation/controller/reel_controller.dart
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../data/models/reel_model.dart';
import '../../data/remote/reel_repository.dart';

class ReelController extends ChangeNotifier {
  final ReelRepository _reelRepository = ReelRepository();

  List<ReelModel> _reels = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  int _currentPage = 0;
  bool _hasMore = true;
  String? _errorMessage;
  String? _successMessage;

  List<ReelModel> get reels => List.unmodifiable(_reels);
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  int get currentPage => _currentPage;
  bool get hasMore => _hasMore;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  ReelController() {
    loadReels();
  }

  void _clearMessages() {
    _errorMessage = null;
    _successMessage = null;
  }

  // Carica reels
  Future<void> loadReels({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 0;
      _hasMore = true;
      _reels = [];
    }

    if (!_hasMore) return;

    try {
      _clearMessages();
      if (_currentPage == 0) {
        _isLoading = true;
      } else {
        _isLoadingMore = true;
      }
      notifyListeners();

      final newReels = await _reelRepository.getReelsFeed(
        page: _currentPage,
      );

      if (newReels.isEmpty) {
        _hasMore = false;
      } else {
        _reels = [..._reels, ...newReels];
        _currentPage++;
      }
    } catch (e) {
      _errorMessage = 'Errore durante il caricamento dei reels';
    } finally {
      _isLoading = false;
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  // Crea nuovo reel
  Future<void> createReel({
    required File videoFile,
    File? thumbnailFile,
    String? title,
    String? description,
    required int duration,
  }) async {
    try {
      _clearMessages();
      _isLoading = true;
      notifyListeners();

      final reel = await _reelRepository.createReel(
        videoFile: videoFile,
        thumbnailFile: thumbnailFile,
        title: title,
        description: description,
        duration: duration,
      );

      _reels = [reel, ..._reels];
      _successMessage = 'Reel pubblicato con successo!';
    } catch (e) {
      _errorMessage = 'Errore durante la pubblicazione del reel';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Incrementa visualizzazioni
  Future<void> incrementViews(String reelId) async {
    try {
      await _reelRepository.incrementViews(reelId);

      final index = _reels.indexWhere((r) => r.id == reelId);
      if (index != -1) {
        _reels = List.of(_reels);
        _reels[index] = _reels[index].copyWith(
          viewsCount: _reels[index].viewsCount + 1,
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Errore incremento views: $e');
    }
  }

  // Like/Unlike reel
  Future<void> toggleLike(String reelId) async {
    try {
      final index = _reels.indexWhere((r) => r.id == reelId);
      if (index == -1) return;

      final hasLiked = await _reelRepository.hasLiked(reelId);

      _reels = List.of(_reels);
      if (hasLiked) {
        await _reelRepository.unlikeReel(reelId);
        _reels[index] = _reels[index].copyWith(
          likesCount: _reels[index].likesCount - 1,
        );
      } else {
        await _reelRepository.likeReel(reelId);
        _reels[index] = _reels[index].copyWith(
          likesCount: _reels[index].likesCount + 1,
        );
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Errore durante l\'operazione';
      notifyListeners();
    }
  }

  // Aggiungi commento
  Future<void> addComment(String reelId, String content) async {
    try {
      _clearMessages();
      await _reelRepository.addComment(reelId, content);

      final index = _reels.indexWhere((r) => r.id == reelId);
      if (index != -1) {
        _reels = List.of(_reels);
        _reels[index] = _reels[index].copyWith(
          commentsCount: _reels[index].commentsCount + 1,
        );
      }

      _successMessage = 'Commento aggiunto';
    } catch (e) {
      _errorMessage = 'Errore durante l\'aggiunta del commento';
    } finally {
      notifyListeners();
    }
  }

  // Elimina reel
  Future<void> deleteReel(String reelId) async {
    try {
      _clearMessages();
      await _reelRepository.deleteReel(reelId);
      _reels = _reels.where((r) => r.id != reelId).toList();
      _successMessage = 'Reel eliminato';
    } catch (e) {
      _errorMessage = 'Errore durante l\'eliminazione';
    } finally {
      notifyListeners();
    }
  }
}