// lib/data/models/comment_model.dart
import 'package:equatable/equatable.dart';
import 'user_model.dart';

class CommentModel extends Equatable {
  final String id;
  final String userId;
  final String reelId;
  final String content;
  final DateTime createdAt;
  final UserModel? user;

  const CommentModel({
    required this.id,
    required this.userId,
    required this.reelId,
    required this.content,
    required this.createdAt,
    this.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      reelId: json['reel_id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'reel_id': reelId,
      'content': content,
      'created_at': createdAt.toIso8601String(),
    };
  }

  CommentModel copyWith({
    String? id,
    String? userId,
    String? reelId,
    String? content,
    DateTime? createdAt,
    UserModel? user,
  }) {
    return CommentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      reelId: reelId ?? this.reelId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [id, userId, reelId, content, createdAt, user];
}