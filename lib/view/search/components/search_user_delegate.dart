import 'package:flutter/material.dart';
import 'package:insta_clone/data_models/user.dart';
import 'package:insta_clone/view/common/components/user_card.dart';
import 'package:insta_clone/view_models/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchUserDelegate extends SearchDelegate<User?> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      brightness: Brightness.dark,
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        print("no result");
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchViewModel = context.read<SearchViewModel>();
    searchViewModel.searchUsers(query);
    return _buildResults(context);
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchViewModel = context.read<SearchViewModel>();
    searchViewModel.searchUsers(query);
    return _buildResults(context);
  }

  // TODO ユーザー検索処理
  Widget _buildResults(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, model, child) => ListView.builder(
        itemCount: model.soughtUsers.length,
        itemBuilder: (context, int index) {
          final user = model.soughtUsers[index];
          return UserCard(
            photoUrl: user.photoUrl,
            title: user.inAppUserName,
            subTitle: user.bio,
            onTap: () {
              close(context, user);
            },
          );
        },
      ),
    );
  }
}
