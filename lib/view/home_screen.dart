import 'package:flutter/material.dart';
import 'package:insta_clone/generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(S.of(context).appTitle),
    );
  }
}
