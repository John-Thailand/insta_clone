import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_clone/data_models/location.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/style.dart';
import 'package:insta_clone/view_models/post_view_model.dart';
import 'package:provider/provider.dart';

class PostLocationPart extends StatelessWidget {
  const PostLocationPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.read<PostViewModel>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          postViewModel.locationString,
          style: postLocationTextStyle,
        ),
        subtitle: _latLngPart(postViewModel.location, context),
        trailing: IconButton(
          onPressed: null,
          icon: FaIcon(FontAwesomeIcons.mapMarkerAlt),
        ),
      ),
    );
  }

  _latLngPart(Location? location, BuildContext context) {
    const spaceWidth = 8.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Chip(
          label: Text(S.of(context).latitude),
        ),
        SizedBox(width: spaceWidth),
        Text(
            (location != null) ? location.latitude.toStringAsFixed(2) : "0.00"),
        SizedBox(width: spaceWidth),
        Chip(
          label: Text(S.of(context).longitude),
        ),
        SizedBox(width: spaceWidth),
        Text((location != null)
            ? location.longitude.toStringAsFixed(2)
            : "0.00"),
      ],
    );
  }
}
