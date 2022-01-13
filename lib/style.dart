import 'package:flutter/material.dart';

const TitleFont = "Billabong";
const RegularFont = "NotoSansJP-Medium";
const BoldFont = "NotoSansJP-Bold";

// テーマ
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    primary: Colors.white30,
  )),
  primaryIconTheme: IconThemeData(
    color: Colors.white,
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  fontFamily: RegularFont,
);

final lightTheme = ThemeData(
  primaryColor: Colors.white,
  brightness: Brightness.light,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    primary: Colors.white,
  )),
  primaryIconTheme: IconThemeData(
    color: Colors.black,
  ),
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
  fontFamily: RegularFont,
);

//Login
const loginTitleTextStyle = TextStyle(fontFamily: TitleFont, fontSize: 48);

//Post
const postCationTextStyle = TextStyle(fontFamily: RegularFont, fontSize: 14.0);
const postLocationTextStyle =
    TextStyle(fontFamily: RegularFont, fontSize: 16.0);

//Feed
const userCardTitleTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 12.0,
);
const userCardSubTitleTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 12.0,
);
const numberOfLikesTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 14.0,
);
const numberOfCommentsTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 13.0,
  color: Colors.grey,
);
const timeAgoTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 13.0,
  color: Colors.grey,
);
const commentNameTextStyle = TextStyle(
  fontFamily: BoldFont,
  fontSize: 13.0,
);
const commentContentTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 13.0,
);
const commentInputTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 14.0,
);
// Profile
const profileRecordScoreTextStyle = TextStyle(
  fontFamily: BoldFont,
  fontSize: 20.0,
);
const profileRecordTitleTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 20.0,
);

const changeProfilePhotoTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 18.0,
  color: Colors.blueAccent,
);

const editProfileTitleTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 14.0,
);

const profileBioTextStyle = TextStyle(
  fontFamily: RegularFont,
  fontSize: 13.0,
);

// Search
const searchPageAppBarTitleTextStyle = TextStyle(
  fontFamily: RegularFont,
  color: Colors.grey,
);
