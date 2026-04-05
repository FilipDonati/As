// data/models/user_model.dart
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String authId;
  
  // Informazioni base
  final String username;
  final String? displayName;
  final String email;
  final String? bio;
  final String? avatarUrl;
  
  // Contatto
  final String? phonePrefix;
  final String? phoneNumber;
  
  // Abbonamento
  final SubscriptionType subscriptionType;
  final SubscriptionStatus subscriptionStatus;
  final DateTime? subscriptionExpiryDate;
  
  // Localizzazione
  final String? nationality;
  final String selectedLanguage;
  
  // Engagement
  final int consecutiveLoginDays;
  final DateTime? lastLoginDate;
  final DateTime? dateOfBirth;
  
  // Timestamp
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.id,
    required this.authId,
    required this.username,
    this.displayName,
    required this.email,
    this.bio,
    this.avatarUrl,
    this.phonePrefix,
    this.phoneNumber,
    this.subscriptionType = SubscriptionType.free,
    this.subscriptionStatus = SubscriptionStatus.active,
    this.subscriptionExpiryDate,
    this.nationality,
    this.selectedLanguage = 'en',
    this.consecutiveLoginDays = 0,
    this.lastLoginDate,
    this.dateOfBirth,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory da JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      authId: json['auth_id'] as String,
      username: json['username'] as String,
      displayName: json['display_name'] as String?,
      email: json['email'] as String,
      bio: json['bio'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      phonePrefix: json['phone_prefix'] as String?,
      phoneNumber: json['phone_number'] as String?,
      subscriptionType: SubscriptionType.fromString(
        json['subscription_type'] as String? ?? 'free',
      ),
      subscriptionStatus: SubscriptionStatus.fromString(
        json['subscription_status'] as String? ?? 'active',
      ),
      subscriptionExpiryDate: json['subscription_expiry_date'] != null
          ? DateTime.parse(json['subscription_expiry_date'] as String)
          : null,
      nationality: json['nationality'] as String?,
      selectedLanguage: json['selected_language'] as String? ?? 'en',
      consecutiveLoginDays: json['consecutive_login_days'] as int? ?? 0,
      lastLoginDate: json['last_login_date'] != null
          ? DateTime.parse(json['last_login_date'] as String)
          : null,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  // Converti a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'auth_id': authId,
      'username': username,
      'display_name': displayName,
      'email': email,
      'bio': bio,
      'avatar_url': avatarUrl,
      'phone_prefix': phonePrefix,
      'phone_number': phoneNumber,
      'subscription_type': subscriptionType.value,
      'subscription_status': subscriptionStatus.value,
      'subscription_expiry_date': subscriptionExpiryDate?.toIso8601String(),
      'nationality': nationality,
      'selected_language': selectedLanguage,
      'consecutive_login_days': consecutiveLoginDays,
      'last_login_date': lastLoginDate?.toIso8601String(),
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Metodi helper
  bool get hasActiveSubscription {
    if (subscriptionStatus != SubscriptionStatus.active) return false;
    if (subscriptionType == SubscriptionType.free) return true;
    if (subscriptionExpiryDate == null) return false;
    return subscriptionExpiryDate!.isAfter(DateTime.now());
  }

  bool get isPremiumUser {
    return hasActiveSubscription && 
           (subscriptionType == SubscriptionType.premium || 
            subscriptionType == SubscriptionType.pro);
  }

  int get age {
    if (dateOfBirth == null) return 0;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  String get fullPhoneNumber {
    if (phonePrefix == null || phoneNumber == null) return '';
    return '$phonePrefix$phoneNumber';
  }

  // CopyWith per immutabilità
  UserModel copyWith({
    String? id,
    String? authId,
    String? username,
    String? displayName,
    String? email,
    String? bio,
    String? avatarUrl,
    String? phonePrefix,
    String? phoneNumber,
    SubscriptionType? subscriptionType,
    SubscriptionStatus? subscriptionStatus,
    DateTime? subscriptionExpiryDate,
    String? nationality,
    String? selectedLanguage,
    int? consecutiveLoginDays,
    DateTime? lastLoginDate,
    DateTime? dateOfBirth,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      authId: authId ?? this.authId,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phonePrefix: phonePrefix ?? this.phonePrefix,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      subscriptionExpiryDate: subscriptionExpiryDate ?? this.subscriptionExpiryDate,
      nationality: nationality ?? this.nationality,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      consecutiveLoginDays: consecutiveLoginDays ?? this.consecutiveLoginDays,
      lastLoginDate: lastLoginDate ?? this.lastLoginDate,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        authId,
        username,
        displayName,
        email,
        bio,
        avatarUrl,
        phonePrefix,
        phoneNumber,
        subscriptionType,
        subscriptionStatus,
        subscriptionExpiryDate,
        nationality,
        selectedLanguage,
        consecutiveLoginDays,
        lastLoginDate,
        dateOfBirth,
        createdAt,
        updatedAt,
      ];
}

// Enums
enum SubscriptionType {
  free('free'),
  basic('basic'),
  premium('premium'),
  pro('pro');

  final String value;
  const SubscriptionType(this.value);

  static SubscriptionType fromString(String value) {
    return SubscriptionType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => SubscriptionType.free,
    );
  }
}

enum SubscriptionStatus {
  active('active'),
  expired('expired'),
  cancelled('cancelled'),
  suspended('suspended');

  final String value;
  const SubscriptionStatus(this.value);

  static SubscriptionStatus fromString(String value) {
    return SubscriptionStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => SubscriptionStatus.active,
    );
  }
}