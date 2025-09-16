import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yeong_mood_tracker/views/a_splash_screen.dart';
import 'package:yeong_mood_tracker/views/b0_sign_up_screen.dart';
import 'package:yeong_mood_tracker/views/c_login_screen.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: SignUpScreen.routeUrl,
    routes: [
      GoRoute(
        name: SplashScreen.routeName,
        path: SplashScreen.routeUrl,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: SignUpScreen.routeName,
        path: SignUpScreen.routeUrl,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routeUrl,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  ),
);
