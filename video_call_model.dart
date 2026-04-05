// lib/data/models/video_call_model.dart
import 'package:equatable/equatable.dart';
import 'user_model.dart';

enum CallStatus {
  pending,
  accepted,
  rejected,
  ended;

  static CallStatus fromString(String value) {
    return CallStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => CallStatus.pending,
    );
  }
}

class VideoCallModel extends Equatable {
  final String id;
  final String callerId;
  final String calleeId;
  final CallStatus status;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;
  final UserModel? caller;
  final UserModel? callee;

  const VideoCallModel({
    required this.id,
    required this.callerId,
    required this.calleeId,
    required this.status,
    this.startedAt,
    this.endedAt,
    required this.createdAt,
    this.caller,
    this.callee,
  });

  factory VideoCallModel.fromJson(Map<String, dynamic> json) {
    return VideoCallModel(
      id: json['id'] as String,
      callerId: json['caller_id'] as String,
      calleeId: json['callee_id'] as String,
      status: CallStatus.fromString(json['status'] as String),
      startedAt: json['started_at'] != null
          ? DateTime.parse(json['started_at'] as String)
          : null,
      endedAt: json['ended_at'] != null
          ? DateTime.parse(json['ended_at'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      caller: json['caller'] != null
          ? UserModel.fromJson(json['caller'] as Map<String, dynamic>)
          : null,
      callee: json['callee'] != null
          ? UserModel.fromJson(json['callee'] as Map<String, dynamic>)
          : null,
    );
  }

  Duration? get duration {
    if (startedAt == null || endedAt == null) return null;
    return endedAt!.difference(startedAt!);
  }

  @override
  List<Object?> get props => [
        id,
        callerId,
        calleeId,
        status,
        startedAt,
        endedAt,
        createdAt,
        caller,
        callee,
      ];
}