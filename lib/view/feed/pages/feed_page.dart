import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/style.dart';
import 'package:insta_clone/utils/constants.dart';
import 'package:insta_clone/view/feed/pages/sub/feed_sub_page.dart';
import 'package:insta_clone/view/post/screens/post_upload_screen.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () => _launchCamera(context),
            icon: FaIcon(FontAwesomeIcons.cameraRetro),
          ),
          title: Text(
            S.of(context).appTitle,
            style: TextStyle(fontFamily: TitleFont),
          )),
      body: FeedSubPage(
        feedMode: FeedMode.FROM_FEED,
        index: 0,
      ),
    );
  }

  _launchCamera(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PostUploadScreen(
          uploadType: UploadType.CAMERA,
        ),
      ),
    );
  }
}
