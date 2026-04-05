import 'package:login_ora/data/models/video_call_model.dart';
import 'package:login_ora/services/db_client/supabase_service.dart';
import 'package:login_ora/services/api_client/webrtc_service.dart';

/// Orchestrates a video call:
/// - Manages the call record in Supabase (status, timestamps)
/// - Delegates WebRTC peer connection to [WebRTCService]
/// - Delegates WebRTC signaling to [SignalingService] (used inside WebRTCService)
class VideoCallService {
  final WebRTCService _webRTCService = WebRTCService();

  WebRTCService get webRTCService => _webRTCService;

  // ── Call lifecycle (Supabase DB) ─────────────────────────────────────────

  /// Create a pending call record and initialise the WebRTC stack.
  Future<VideoCallModel> startCall(String calleeId) async {
    final response = await SupabaseService.client
        .from('video_calls')
        .insert({
          'caller_id': SupabaseService.currentUserId,
          'callee_id': calleeId,
          'status': 'pending',
        })
        .select('*, caller:users!caller_id(*), callee:users!callee_id(*)')
        .single();

    final call = VideoCallModel.fromJson(response);

    final granted = await _webRTCService.requestPermissions();
    if (granted == true) {
      await _webRTCService.initialize(call.id);
      await _webRTCService.createAndSendOffer();
    }

    return call;
  }

  /// Accept an incoming call and initialise WebRTC as the callee.
  Future<void> acceptCall(String callId) async {
    await SupabaseService.client.from('video_calls').update({
      'status': 'accepted',
      'started_at': DateTime.now().toIso8601String(),
    }).eq('id', callId);

    final granted = await _webRTCService.requestPermissions();
    if (granted == true) {
      await _webRTCService.initialize(callId);
      // The callee waits for the offer; _handleRemoteOffer in WebRTCService
      // sends the answer automatically once the offer arrives.
    }
  }

  /// Reject an incoming call (no WebRTC setup needed).
  Future<void> rejectCall(String callId) async {
    await SupabaseService.client.from('video_calls').update({
      'status': 'rejected',
      'ended_at': DateTime.now().toIso8601String(),
    }).eq('id', callId);
  }

  /// End an active call and tear down WebRTC.
  Future<void> endCall(String callId) async {
    await SupabaseService.client.from('video_calls').update({
      'status': 'ended',
      'ended_at': DateTime.now().toIso8601String(),
    }).eq('id', callId);

    await _webRTCService.hangUp();
  }

  // ── Realtime stream ──────────────────────────────────────────────────────

  /// Stream of pending incoming calls for the current user.
  ///
  /// Note: SupabaseStreamBuilder supports only one server-side .eq() filter.
  /// The 'status == pending' check is therefore applied client-side inside .map().
  Stream<List<VideoCallModel>> listenForIncomingCalls() {
    return SupabaseService.client
        .from('video_calls')
        .stream(primaryKey: ['id'])
        .eq('callee_id', SupabaseService.currentUserId!)
        .map((rows) => rows
            .where((json) => json['status'] == 'pending')
            .map((json) => VideoCallModel.fromJson(json))
            .toList());
  }

  // ── Media controls (delegates to WebRTCService) ──────────────────────────

  void toggleAudio(bool enabled) => _webRTCService.toggleAudio(enabled);
  void toggleVideo(bool enabled) => _webRTCService.toggleVideo(enabled);
  Future<void> switchCamera() => _webRTCService.switchCamera();

  // ── Cleanup ───────────────────────────────────────────────────────────────

  Future<void> dispose() async {
    await _webRTCService.hangUp();
  }

  Future<void> initializeAgora() async {
    await _webRTCService.initialize('agora_channel_id');

  }

  Future<void> joinChannel(String id, int i) async {
    await _webRTCService.initialize(id);

  }
}