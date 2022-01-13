import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:insta_clone/generated/l10n.dart';
import 'package:insta_clone/models/repositories/theme_change_repository.dart';
import 'package:insta_clone/style.dart';
import 'package:insta_clone/view/home_screen.dart';
import 'package:insta_clone/view/login/screens/login_screen.dart';
import 'package:insta_clone/view_models/login_view_model.dart';
import 'package:insta_clone/di/providers.dart';
import 'package:insta_clone/view_models/theme_change_view_model.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  timeago.setLocaleMessages("ja", timeago.JaMessages());
  WidgetsFlutterBinding.ensureInitialized();
  final themeChangeRepository = ThemeChangeRepository();
  await themeChangeRepository.getIsDarkOn();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: globalProviders,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.read<LoginViewModel>();
    final themeChangeViewModel = Provider.of<ThemeChangeViewModel>(context);

    return MaterialApp(
      title: "DaitaInstagram",
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: themeChangeViewModel.selectedTheme,
      home: FutureBuilder(
          future: loginViewModel.isSignIn(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          }),
    );
  }
}
