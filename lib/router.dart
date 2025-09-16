import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yeong_mood_tracker/views/a_splash_screen.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: SplashScreen.routeUrl,
    routes: [
      GoRoute(
        name: SplashScreen.routeName,
        path: SplashScreen.routeUrl,
        builder: (context, state) => const SplashScreen(),
      ),
    ],
  ),
);
