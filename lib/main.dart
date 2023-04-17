import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yarmy_shrine/router/app_router.dart';
import 'package:yarmy_shrine/services/app_service.dart';
import 'package:yarmy_shrine/services/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'supplemental/cut_corners_border.dart';
import 'theme/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  AppService appService = AppService(sharedPreferences);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppService>(create: (_) => appService),
        Provider<AppRouter>(create: (_) => AppRouter(appService)),
        Provider<AuthService>(create: (_) => AuthService()),
      ],
      child: MyNewApp(sharedPreferences: sharedPreferences),
    ),
  );
}

class MyNewApp extends StatefulWidget {
  final SharedPreferences sharedPreferences;
  const MyNewApp({
    super.key,
    required this.sharedPreferences,
  });

  @override
  State<MyNewApp> createState() => _MyNewAppState();
}

class _MyNewAppState extends State<MyNewApp> {
  late StreamSubscription<bool> authSubscription;

  @override
  void initState() {
    authSubscription = context
        .read<AuthService>()
        .onAuthStateChanged
        .listen(_onAuthStateChanged);
    super.initState();
  }

  void _onAuthStateChanged(bool login) {
    context.read<AppService>().loginState = login;
  }

  @override
  void dispose() {
    authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GoRouter goRouter = context.read<AppRouter>().router;
    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'Yarmy Shrine',
      // routeInformationParser: goRouter.routeInformationParser,
      // routeInformationProvider: goRouter.routeInformationProvider,
      // routerDelegate: goRouter.routerDelegate,
      theme: _kShrineTheme,

    );
  }
}
final ThemeData _kShrineTheme = _buildShrineTheme();

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
          headlineSmall: base.headlineSmall!.copyWith(
            fontWeight: FontWeight.w500,
          ),
          titleLarge: base.titleLarge!.copyWith(
            fontSize: 18.0,
          ),
          bodySmall: base.bodySmall!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
          bodyLarge: base.bodyLarge!.copyWith(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ))
      .apply(
        fontFamily: 'Rubik',
        displayColor: kShrineBrown900,
        bodyColor: kShrineBrown900,
      );
}


ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light(useMaterial3: false);
  return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: kShrinePink100,
        onPrimary: kShrineBrown900,
        secondary: kShrineBrown900,
        error: kShrineErrorRed,
      ),
      textTheme: _buildShrineTextTheme(base.textTheme),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: kShrinePink100,
        // cursorColor: kShrineBrown900,
      ),
      inputDecorationTheme: const InputDecorationTheme(
          border: CutCornersBorder(),
          focusedBorder: CutCornersBorder(
            borderSide: BorderSide(
              width: 2.0,
              color: kShrineBrown900,
            ),
          ),
          floatingLabelStyle: TextStyle(
            color: kShrineBrown900,
          )));
}