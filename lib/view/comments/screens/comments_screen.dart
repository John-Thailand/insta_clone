import 'package:flutter/material.dart';
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/view/comments/components/comment_display_part.dart';
import 'package:insta_clone/view/comments/components/comments_input_part.dart';

class CommentsScreen extends StatelessWidget {
  final Post post;
  final User postUser;

  const CommentsScreen({Key? key, required this.post, required this.postUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).comments),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CommentDisplayPart(
              postUserPhotoUrl: postUser.photoUrl,
              name: postUser.inAppUserName,
              text: post.caption,
              postDateTime: post.postDateTime,
            ),
            CommentInputPart(post: post),
          ],
        ),
      ),
    );
  }
}