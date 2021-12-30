import 'dart:convert';

class Post {
  String postId;
  String userId;
  String imageUrl;
  String imageStoragePath;
  String caption;
  String locationString;
  double latitude;
  double longitude;
  DateTime postDateTime;
  Post({
    required this.postId,
    required this.userId,
    required this.imageUrl,
    required this.imageStoragePath,
    required this.caption,
    required this.locationString,
    required this.latitude,
    required this.longitude,
    required this.postDateTime,
  });

  Post copyWith({
    String? postId,
    String? userId,
    String? imageUrl,
    String? imageStoragePath,
    String? caption,
    String? locationString,
    double? latitude,
    double? longitude,
    DateTime? postDateTime,
  }) {
    return Post(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      imageStoragePath: imageStoragePath ?? this.imageStoragePath,
      caption: caption ?? this.caption,
      locationString: locationString ?? this.locationString,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      postDateTime: postDateTime ?? this.postDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'userId': userId,
      'imageUrl': imageUrl,
      'imageStoragePath': imageStoragePath,
      'caption': caption,
      'locationString': locationString,
      'latitude': latitude,
      'longitude': longitude,
      'postDateTime': postDateTime.millisecondsSinceEpoch,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map['postId'] ?? '',
      userId: map['userId'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      imageStoragePath: map['imageStoragePath'] ?? '',
      caption: map['caption'] ?? '',
      locationString: map['locationString'] ?? '',
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      postDateTime: DateTime.fromMillisecondsSinceEpoch(map['postDateTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(postId: $postId, userId: $userId, imageUrl: $imageUrl, imageStoragePath: $imageStoragePath, caption: $caption, locationString: $locationString, latitude: $latitude, longitude: $longitude, postDateTime: $postDateTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Post &&
        other.postId == postId &&
        other.userId == userId &&
        other.imageUrl == imageUrl &&
        other.imageStoragePath == imageStoragePath &&
        other.caption == caption &&
        other.locationString == locationString &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.postDateTime == postDateTime;
  }

  @override
  int get hashCode {
    return postId.hashCode ^
        userId.hashCode ^
        imageUrl.hashCode ^
        imageStoragePath.hashCode ^
        caption.hashCode ^
        locationString.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        postDateTime.hashCode;
  }
}
