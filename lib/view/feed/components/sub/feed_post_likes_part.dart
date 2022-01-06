import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/style.dart';
import 'package:insta_clone/view/comments/screens/comments_screen.dart';

class FeedPostLikesPart extends StatelessWidget {
  final Post post;
  final User postUser;

  const FeedPostLikesPart(
      {Key? key, required this.post, required this.postUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: null,
                icon: FaIcon(FontAwesomeIcons.solidHeart),
              ),
              IconButton(
                onPressed: () => _openCommentsScreen(context, post),
                icon: FaIcon(FontAwesomeIcons.comment),
              ),
            ],
          ),
          Text(
            "0 ${S.of(context).likes}",
            style: numberOfLikesTextStyle,
          )
        ],
      ),
    );
  }

  _openCommentsScreen(BuildContext context, Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentsScreen(
          post: post,
          postUser: postUser,
        ),
      ),
    );
  }
}
