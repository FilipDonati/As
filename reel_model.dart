// lib/data/models/reel_model.dart
import 'package:equatable/equatable.dart';
import 'user_model.dart';

class ReelModel extends Equatable {
  final String id;
  final String userId;
  final String videoUrl;
  final String? thumbnailUrl;
  final String? title;
  final String? description;
  final int duration;
  final int viewsCount;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;
  final bool isActive;
  final UserModel? user; // Populated con join

  const ReelModel({
    required this.id,
    required this.userId,
    required this.videoUrl,
    this.thumbnailUrl,
    this.title,
    this.description,
    required this.duration,
    this.viewsCount = 0,
    this.likesCount = 0,
    this.commentsCount = 0,
    required this.createdAt,
    this.isActive = true,
    this.user,
  });

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    return ReelModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      videoUrl: json['video_url'] as String,
      thumbnailUrl: json['thumbnail_url'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      duration: json['duration'] as int,
      viewsCount: json['views_count'] as int? ?? 0,
      likesCount: json['likes_count'] as int? ?? 0,
      commentsCount: json['comments_count'] as int? ?? 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      isActive: json['is_active'] as bool? ?? true,
      user: json['users'] != null 
          ? UserModel.fromJson(json['users'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'video_url': videoUrl,
      'thumbnail_url': thumbnailUrl,
      'title': title,
      'description': description,
      'duration': duration,
      'views_count': viewsCount,
      'likes_count': likesCount,
      'comments_count': commentsCount,
      'created_at': createdAt.toIso8601String(),
      'is_active': isActive,
    };
  }

  ReelModel copyWith({
    String? id,
    String? userId,
    String? videoUrl,
    String? thumbnailUrl,
    String? title,
    String? description,
    int? duration,
    int? viewsCount,
    int? likesCount,
    int? commentsCount,
    DateTime? createdAt,
    bool? isActive,
    UserModel? user,
  }) {
    return ReelModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      viewsCount: viewsCount ?? this.viewsCount,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        videoUrl,
        thumbnailUrl,
        title,
        description,
        duration,
        viewsCount,
        likesCount,
        commentsCount,
        createdAt,
        isActive,
        user,
      ];
}