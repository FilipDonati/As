import 'package:supabase_flutter/supabase_flutter.dart';
import '../db_client/supabase_service.dart' as supabase_service;

/// Handles WebRTC signaling (offer / answer / ICE candidates) via
/// Supabase Realtime broadcast channels so peers can exchange SDP
/// without a dedicated signaling server.
class SignalingService {
  static const String _channelPrefix = 'webrtc_signal';

  RealtimeChannel? _channel;
  final String _callId;

  SignalingService(this._callId);

  // ── Subscribe ────────────────────────────────────────────────────────────

  /// Subscribe to signaling events for [_callId].
  /// [onOffer], [onAnswer], [onIceCandidate] are invoked when the
  /// remote peer sends the corresponding payload.
  void subscribe({
    required void Function(Map<String, dynamic> sdp) onOffer,
    required void Function(Map<String, dynamic> sdp) onAnswer,
    required void Function(Map<String, dynamic> candidate) onIceCandidate,
  }) {
    _channel = supabase_service.SupabaseService.client
        .channel('$_channelPrefix:$_callId')
        .onBroadcast(
          event: 'offer',
          callback: (payload) => onOffer(Map<String, dynamic>.from(payload)),
        )
        .onBroadcast(
          event: 'answer',
          callback: (payload) => onAnswer(Map<String, dynamic>.from(payload)),
        )
        .onBroadcast(
          event: 'ice_candidate',
          callback: (payload) =>
              onIceCandidate(Map<String, dynamic>.from(payload)),
        )
        .subscribe();
  }

  // ── Send ─────────────────────────────────────────────────────────────────

  Future<void> sendOffer(Map<String, dynamic> sdp) async {
    await _channel?.sendBroadcastMessage(event: 'offer', payload: sdp);
  }

  Future<void> sendAnswer(Map<String, dynamic> sdp) async {
    await _channel?.sendBroadcastMessage(event: 'answer', payload: sdp);
  }

  Future<void> sendIceCandidate(Map<String, dynamic> candidate) async {
    await _channel?.sendBroadcastMessage(
        event: 'ice_candidate', payload: candidate);
  }

  // ── Cleanup ───────────────────────────────────────────────────────────────

  Future<void> dispose() async {
    await _channel?.unsubscribe();
    _channel = null;
  }
}