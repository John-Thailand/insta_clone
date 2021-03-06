import 'package:flutter/material.dart';
import 'package:insta_clone/data_models/user.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/style.dart';
import 'package:insta_clone/utils/constants.dart';
import 'package:insta_clone/view/profile/screens/edit_profile_screen.dart';
import 'package:insta_clone/view_models/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfileBio extends StatelessWidget {
  final ProfileMode mode;

  const ProfileBio({Key? key, required this.mode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    final profileUser = profileViewModel.profileUser;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(profileUser.inAppUserName),
          Text(
            profileUser.bio,
            style: profileBioTextStyle,
          ),
          SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: _button(context, profileUser),
          )
        ],
      ),
    );
  }

  _button(BuildContext context, User profileUser) {
    final profileViewModel = context.read<ProfileViewModel>();
    final isFollowing = profileViewModel.isFollowingProfileUser;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      onPressed: () {
        mode == ProfileMode.MYSELF
            ? _openEditProfileScreen(context)
            : isFollowing
                ? _unFollow(context)
                : _follow(context);
      },
      child: mode == ProfileMode.MYSELF
          ? Text(S.of(context).editProfile)
          : isFollowing
              ? Text(S.of(context).unFollow)
              : Text(S.of(context).follow),
    );
  }

  _openEditProfileScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(),
      ),
    );
  }

  _follow(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    profileViewModel.follow();
  }

  _unFollow(BuildContext context) {
    final profileViewModel = context.read<ProfileViewModel>();
    profileViewModel.unFollow();
  }
}
