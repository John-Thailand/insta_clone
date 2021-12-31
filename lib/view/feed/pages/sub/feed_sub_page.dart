import 'package:flutter/material.dart';
import 'package:insta_clone/utils/constants.dart';
import 'package:insta_clone/view_models/feed_view_model.dart';
import 'package:provider/provider.dart';

class FeedSubPage extends StatelessWidget {
  final FeedMode feedMode;

  const FeedSubPage({Key? key, required this.feedMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.read<FeedViewModel>();
    //TODO プロフィール画面から来た場合はUserの設定が必要
    feedViewModel.setFeedUser(feedMode, null);

    Future(() => feedViewModel.getPosts(feedMode));

    return Scaffold(
      body: Center(
        child: Text("FeedSubPage"),
      ),
    );
  }
}
