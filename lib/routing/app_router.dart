import 'package:flutter_pokedex/features/home/home_flow.dart';
import 'package:flutter_pokedex/features/home/loading_animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'not_found_screen.dart';

enum AppRoute { home, loading }

final goRouterProvider = Provider<GoRouter>((ref) {
  // final userCreated = ref.watch(authStateChangesProvider);
  // final authRepository = ref.watch(authRepositoryProvider);
  // User? user = FirebaseAuth.instance.currentUser;
  String verificationState = '';
  int userRead = 0;

  // userCreated.whenData((value) {
  //   if (value == null) {
  //     return;
  //   } else {
  //     ref.read(authRepositoryProvider).updateUserRoute(user: value);
  //     verificationState = value.verificationState;
  //   }
  // });
  return GoRouter(
    initialLocation: "/login",
    debugLogDiagnostics: false,
    redirect: (context, state) async {
      if (userRead < 2) {
        userRead++;
        return '/loading';
      }
      return null;
    },
    // refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    // refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/loading',
        name: AppRoute.loading.name,
        builder: (context, state) => const LoadingAnimation(),
        routes: const [],
      ),
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const HomeFlow(),
        routes: const [],
      )
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
