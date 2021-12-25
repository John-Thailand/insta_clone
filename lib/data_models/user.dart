import 'dart:convert';

class User {
  final String userId;
  final String displayName;
  final String inAppUserName;
  final String photoUrl;
  final String email;
  final String bio;
  User({
    required this.userId,
    required this.displayName,
    required this.inAppUserName,
    required this.photoUrl,
    required this.email,
    required this.bio,
  });

  User copyWith({
    String? userId,
    String? displayName,
    String? inAppUserName,
    String? photoUrl,
    String? email,
    String? bio,
  }) {
    return User(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      inAppUserName: inAppUserName ?? this.inAppUserName,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'displayName': displayName,
      'inAppUserName': inAppUserName,
      'photoUrl': photoUrl,
      'email': email,
      'bio': bio,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] ?? '',
      displayName: map['displayName'] ?? '',
      inAppUserName: map['inAppUserName'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(userId: $userId, displayName: $displayName, inAppUserName: $inAppUserName, photoUrl: $photoUrl, email: $email, bio: $bio)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.userId == userId &&
        other.displayName == displayName &&
        other.inAppUserName == inAppUserName &&
        other.photoUrl == photoUrl &&
        other.email == email &&
        other.bio == bio;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        displayName.hashCode ^
        inAppUserName.hashCode ^
        photoUrl.hashCode ^
        email.hashCode ^
        bio.hashCode;
  }
}
