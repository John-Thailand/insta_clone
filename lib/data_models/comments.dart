import 'dart:convert';

class Comment {
  String commentId;
  String postId;
  String commentUserId;
  String comment;
  DateTime commentDateTime;

  Comment({
    required this.commentId,
    required this.postId,
    required this.commentUserId,
    required this.comment,
    required this.commentDateTime,
  });

  Comment copyWith({
    String? commentId,
    String? postId,
    String? commentUserId,
    String? comment,
    DateTime? commentDateTime,
  }) {
    return Comment(
      commentId: commentId ?? this.commentId,
      postId: postId ?? this.postId,
      commentUserId: commentUserId ?? this.commentUserId,
      comment: comment ?? this.comment,
      commentDateTime: commentDateTime ?? this.commentDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'commentId': commentId,
      'postId': postId,
      'commentUserId': commentUserId,
      'comment': comment,
      'commentDateTime': commentDateTime.toIso8601String(),
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      commentId: map['commentId'] ?? '',
      postId: map['postId'] ?? '',
      commentUserId: map['commentUserId'] ?? '',
      comment: map['comment'] ?? '',
      commentDateTime: DateTime.parse(map['commentDateTime'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(commentId: $commentId, postId: $postId, commentUserId: $commentUserId, comment: $comment, commentDateTime: $commentDateTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.commentId == commentId &&
        other.postId == postId &&
        other.commentUserId == commentUserId &&
        other.comment == comment &&
        other.commentDateTime == commentDateTime;
  }

  @override
  int get hashCode {
    return commentId.hashCode ^
        postId.hashCode ^
        commentUserId.hashCode ^
        comment.hashCode ^
        commentDateTime.hashCode;
  }
}
