import 'dart:developer';
import 'package:yarmy_shrine/app.dart';
import 'package:yarmy_shrine/views/login.dart';
import 'package:yarmy_shrine/router/route_utils.dart';
import 'package:yarmy_shrine/services/app_service.dart';
import 'package:yarmy_shrine/views/error_page.dart';
import 'package:yarmy_shrine/views/onboarding_page.dart';
import 'package:yarmy_shrine/views/splash_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final AppService appService;
  GoRouter get router => _goRouter;

  AppRouter(this.appService);

  late final GoRouter _goRouter = GoRouter(
    refreshListenable: appService,
    initialLocation: AppPage.home.toPath,
    routes: <GoRoute>[
      GoRoute(
          path: AppPage.home.toPath,
          name: AppPage.home.toName,
          builder: (context, state) => const ShrineApp()),
      GoRoute(
        path: AppPage.login.toPath,
        name: AppPage.login.toName,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppPage.onBoarding.toPath,
        name: AppPage.onBoarding.toName,
        builder: (context, state) =>
            OnBoardingPage(title: AppPage.onBoarding.toTitle),
      ),
      GoRoute(
        path: AppPage.splash.toPath,
        name: AppPage.splash.toName,
        builder: (context, state) => SplashPage(title: AppPage.splash.toTitle),
      ),
      GoRoute(
        path: AppPage.error.toPath,
        name: AppPage.error.toName,
        builder: (context, state) => ErrorPage(error: AppPage.error.toTitle),
      ),
    ],
    errorBuilder: (context, state) {
      log(state.error.toString());
      return ErrorPage(error: state.error.toString());
    },
    redirect: (context, state) {
      log(state.subloc);
      final String loginLocation = AppPage.login.toPath;
      final String homeLocation = AppPage.home.toPath;
      final String splashLocation = AppPage.splash.toPath;
      final String onBoardingLocation = AppPage.onBoarding.toPath;

      final bool isLoggedIn = appService.loginState;
      final bool isInitialized = appService.initialized;
      final bool isOnboarded = appService.onboarding;

      final bool isGoingToLogin = state.subloc == loginLocation;
      final bool isGoingToInit = state.subloc == splashLocation;
      final bool isGoingToOnBoard = state.subloc == onBoardingLocation;

      // If not initialized and not going to the splash screen
      if (!isInitialized && !isGoingToInit) {
        return splashLocation;
      }
      // If not onboarded and not going to the onboarding screen
      else if (isInitialized && !isOnboarded && !isGoingToOnBoard) {
        return onBoardingLocation;
      }
      // If not authenticated and not going to the login screen
      else if (isInitialized && isOnboarded && !isLoggedIn && !isGoingToLogin) {
        return loginLocation;
      }
      // If All conditions have been met
      else if (isInitialized && isGoingToInit ||
          isOnboarded && isGoingToOnBoard ||
          isLoggedIn && isGoingToLogin) {
        return homeLocation;
      } else {
        return null;
      }
    },
  );
}
