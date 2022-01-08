import 'dart:convert';

class LikeResult {
  final List<Like> likes;
  final bool isLikedToThisPost;

  LikeResult({required this.likes, required this.isLikedToThisPost});
}

class Like {
  String likeId;
  String postId;
  String likeUserId;
  DateTime likeDateTime;

  Like({
    required this.likeId,
    required this.postId,
    required this.likeUserId,
    required this.likeDateTime,
  });

  Like copyWith({
    String? likeId,
    String? postId,
    String? likeUserId,
    DateTime? likeDateTime,
  }) {
    return Like(
      likeId: likeId ?? this.likeId,
      postId: postId ?? this.postId,
      likeUserId: likeUserId ?? this.likeUserId,
      likeDateTime: likeDateTime ?? this.likeDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'likeId': likeId,
      'postId': postId,
      'likeUserId': likeUserId,
      'likeDateTime': likeDateTime.toIso8601String(),
    };
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      likeId: map['likeId'] ?? '',
      postId: map['postId'] ?? '',
      likeUserId: map['likeUserId'] ?? '',
      likeDateTime: DateTime.parse(map['likeDateTime'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Like.fromJson(String source) => Like.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Like(likeId: $likeId, postId: $postId, likeUserId: $likeUserId, likeDateTime: $likeDateTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Like &&
        other.likeId == likeId &&
        other.postId == postId &&
        other.likeUserId == likeUserId &&
        other.likeDateTime == likeDateTime;
  }

  @override
  int get hashCode {
    return likeId.hashCode ^
        postId.hashCode ^
        likeUserId.hashCode ^
        likeDateTime.hashCode;
  }
}
