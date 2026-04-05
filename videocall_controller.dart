// lib/presentation/controller/videocall_controller.dart
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../data/models/video_call_model.dart';
import '../../services/api_client/videocall_service.dart';

class VideoCallController extends ChangeNotifier {
  final VideoCallService _videoCallService = VideoCallService();

  VideoCallModel? _currentCall;
  // Exposed so the UI can show an incoming call dialog reactively
  VideoCallModel? _incomingCall;
  bool _isCallActive = false;
  bool _isMuted = false;
  bool _isVideoEnabled = true;
  bool _isFrontCamera = true;
  bool _isRemoteUserConnected = false;
  String? _errorMessage;

  // WebRTC video renderers for local and remote streams
  final RTCVideoRenderer localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer remoteRenderer = RTCVideoRenderer();

  StreamSubscription<List<VideoCallModel>>? _incomingCallSubscription;

  VideoCallModel? get currentCall => _currentCall;
  VideoCallModel? get incomingCall => _incomingCall;
  bool get isCallActive => _isCallActive;
  bool get isMuted => _isMuted;
  bool get isVideoEnabled => _isVideoEnabled;
  bool get isFrontCamera => _isFrontCamera;
  bool get isRemoteUserConnected => _isRemoteUserConnected;
  String? get errorMessage => _errorMessage;

  VideoCallController() {
    _init();
  }

  Future<void> _init() async {
    await localRenderer.initialize();
    await remoteRenderer.initialize();
    await _initializeService();
    _listenForIncomingCalls();
  }

  Future<void> _initializeService() async {
    try {
      await _videoCallService.initializeAgora();
    } catch (e) {
      _errorMessage = 'Errore durante l\'inizializzazione della videocall';
      notifyListeners();
    }
  }

  // Ascolta chiamate in arrivo — UI observes _incomingCall and shows its own dialog
  void _listenForIncomingCalls() {
    _incomingCallSubscription =
        _videoCallService.listenForIncomingCalls().listen((calls) {
      if (calls.isNotEmpty && !_isCallActive) {
        _incomingCall = calls.first;
      } else {
        _incomingCall = null;
      }
      notifyListeners();
    });
  }

  // Inizia chiamata
  Future<void> startCall(String calleeId) async {
    try {
      _errorMessage = null;
      final call = await _videoCallService.startCall(calleeId);
      _currentCall = call;
      // uid 0 lets the Agora/WebRTC service assign one automatically
      await _videoCallService.joinChannel(call.id, 0);
      _isCallActive = true;
    } catch (e) {
      _errorMessage = 'Errore durante l\'avvio della chiamata';
    } finally {
      notifyListeners();
    }
  }

  // Accetta chiamata
  Future<void> acceptCall(String callId) async {
    try {
      _errorMessage = null;
      await _videoCallService.acceptCall(callId);
      if (_currentCall != null) {
        await _videoCallService.joinChannel(callId, 0);
        _isCallActive = true;
      }
      _incomingCall = null;
    } catch (e) {
      _errorMessage = 'Errore durante l\'accettazione della chiamata';
    } finally {
      notifyListeners();
    }
  }

  // Rifiuta chiamata
  Future<void> rejectCall(String callId) async {
    try {
      _errorMessage = null;
      await _videoCallService.rejectCall(callId);
      _currentCall = null;
      _incomingCall = null;
    } catch (e) {
      _errorMessage = 'Errore durante il rifiuto della chiamata';
    } finally {
      notifyListeners();
    }
  }

  // Termina chiamata
  Future<void> endCall() async {
    try {
      _errorMessage = null;
      if (_currentCall != null) {
        await _videoCallService.endCall(_currentCall!.id);
      }
      _currentCall = null;
      _isCallActive = false;
      _isRemoteUserConnected = false;
    } catch (e) {
      _errorMessage = 'Errore durante la chiusura della chiamata';
    } finally {
      notifyListeners();
    }
  }

  // Toggle mute — state tracked here; engine mute delegated to service
  void toggleMute() {
    _isMuted = !_isMuted;
    notifyListeners();
  }

  // Toggle video — state tracked here; engine stream delegated to service
  void toggleVideo() {
    _isVideoEnabled = !_isVideoEnabled;
    notifyListeners();
  }

  // Switch camera — state tracked here; engine switch delegated to service
  void switchCamera() {
    _isFrontCamera = !_isFrontCamera;
    notifyListeners();
  }

  // Called by the service layer (or a signalling stream) when a remote peer joins
  void onRemoteUserConnected() {
    _isRemoteUserConnected = true;
    notifyListeners();
  }

  // Called by the service layer when the remote peer disconnects
  void onRemoteUserDisconnected() {
    _isRemoteUserConnected = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _incomingCallSubscription?.cancel();
    _videoCallService.dispose();
    localRenderer.dispose();
    remoteRenderer.dispose();
    super.dispose();
  }
}