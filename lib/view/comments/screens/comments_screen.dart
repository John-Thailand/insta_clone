import 'package:flutter/material.dart';
import 'package:insta_clone/data_models/post.dart';
import 'package:insta_clone/data_models/user.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/view/comments/components/comment_display_part.dart';
import 'package:insta_clone/view/comments/components/comments_input_part.dart';
import 'package:insta_clone/view/common/dialog/confirm_dialog.dart';
import 'package:insta_clone/view_models/comments_view_model.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatelessWidget {
  final Post post;
  final User postUser;

  const CommentsScreen({Key? key, required this.post, required this.postUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final commentsViewModel = context.read<CommentsViewModel>();

    Future(() => commentsViewModel.getComments(post.postId));

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).comments),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CommentDisplayPart(
                postUserPhotoUrl: postUser.photoUrl,
                name: postUser.inAppUserName,
                text: post.caption,
                postDateTime: post.postDateTime,
              ),
              Consumer<CommentsViewModel>(
                builder: (context, model, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final comment = model.comments[index];
                      final commentUserId = comment.commentUserId;
                      return FutureBuilder(
                          future: model.getCommentUserInfo(commentUserId),
                          builder: (context, AsyncSnapshot<User> snapshot) {
                            final commentUser = snapshot.data!;
                            if (snapshot.hasData && snapshot.data != null) {
                              return CommentDisplayPart(
                                postUserPhotoUrl: commentUser.photoUrl,
                                name: commentUser.inAppUserName,
                                text: comment.comment,
                                postDateTime: comment.commentDateTime,
                                onLongPressed: () => showConfirmDialog(
                                  context: context,
                                  title: S.of(context).deleteComment,
                                  content: S.of(context).deleteCommentConfirm,
                                  onConfirmed: (isConfirmed) {
                                    if (isConfirmed) {
                                      _deleteComment(context, index);
                                    }
                                  },
                                ),
                              );
                            } else {
                              return Container();
                            }
                          });
                    },
                  );
                },
              ),
              CommentInputPart(post: post),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteComment(BuildContext context, int index) async {
    final commentsViewModel = context.read<CommentsViewModel>();
    await commentsViewModel.deleteComment(post, index);
  }
}
