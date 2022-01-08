import 'package:flutter/material.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/style.dart';
import 'package:insta_clone/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfileRecords extends StatelessWidget {
  const ProfileRecords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();

    return Row(
      children: [
        FutureBuilder(
          future: profileViewModel.getNumberOfPosts(),
          builder: (context, AsyncSnapshot<int> snapshot) {
            return _userRecordWidget(
              context: context,
              score: snapshot.hasData ? snapshot.data! : 0,
              title: S.of(context).post,
            );
          },
        ),
        FutureBuilder(
          future: profileViewModel.getNumberOfFollowers(),
          builder: (context, AsyncSnapshot<int> snapshot) {
            return _userRecordWidget(
              context: context,
              score: snapshot.hasData ? snapshot.data! : 0,
              title: S.of(context).followers,
            );
          },
        ),
        FutureBuilder(
          future: profileViewModel.getNumberOfFollowings(),
          builder: (context, AsyncSnapshot<int> snapshot) {
            return _userRecordWidget(
              context: context,
              score: snapshot.hasData ? snapshot.data! : 0,
              title: S.of(context).followings,
            );
          },
        ),
      ],
    );
  }

  _userRecordWidget(
      {required BuildContext context,
      required int score,
      required String title}) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Text(
            score.toString(),
            style: profileRecordScoreTextStyle,
          ),
          Text(
            title.toString(),
            style: profileRecordTitleTextStyle,
          ),
        ],
      ),
    );
  }
}
