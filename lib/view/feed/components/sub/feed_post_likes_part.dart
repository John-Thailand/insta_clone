import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/style.dart';
import 'package:insta_clone/view/comments/screens/comments_screen.dart';
import 'package:insta_clone/view_models/feed_view_model.dart';
import 'package:provider/provider.dart';

class FeedPostLikesPart extends StatelessWidget {
  final Post post;
  final User postUser;

  const FeedPostLikesPart(
      {Key? key, required this.post, required this.postUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.read<FeedViewModel>();

    return Padding(
      padding: EdgeInsets.only(left: 8.0),
      child: FutureBuilder(
        future: feedViewModel.getLikeResult(post.postId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final likeResult = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    likeResult.isLikedToThisPost
                        ? IconButton(
                            onPressed: () => _unLikesIt(context),
                            icon: FaIcon(FontAwesomeIcons.solidHeart),
                          )
                        : IconButton(
                            onPressed: () => _likesIt(context),
                            icon: FaIcon(FontAwesomeIcons.heart),
                          ),
                    IconButton(
                      onPressed: () =>
                          _openCommentsScreen(context, post, postUser),
                      icon: FaIcon(FontAwesomeIcons.comment),
                    ),
                  ],
                ),
                Text(
                  likeResult.likes.length.toString() +
                      " " +
                      S.of(context).likes,
                  style: numberOfLikesTextStyle,
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  _openCommentsScreen(BuildContext context, Post post, User postUser) {
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

  _likesIt(BuildContext context) async {
    final feedViewModel = context.read<FeedViewModel>();
    await feedViewModel.likeIt(post);
  }

  _unLikesIt(BuildContext context) async {
    final feedViewModel = context.read<FeedViewModel>();
    await feedViewModel.unLikeIt(post);
  }
}
