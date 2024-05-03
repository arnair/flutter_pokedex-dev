import 'package:flutter_pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:flutter_pokedex/features/pokemon/presentation/pokemon_screen.dart';
import 'package:flutter_pokedex/features/search/presentation/search_screen.dart';
import 'package:flutter_pokedex/features/initialization/presentation/loading_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'not_found_screen.dart';

enum AppRoute { loading, seach, pokemon }

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.loading.name,
        builder: (context, state) => const LoadingScreen(),
        routes: const [],
      ),
      GoRoute(
        path: '/search',
        name: AppRoute.seach.name,
        builder: (context, state) => const SearchScreen(),
        routes: const [],
      ),
      GoRoute(
        path: '/pokemon/:name',
        name: AppRoute.pokemon.name,
        builder: (context, state) {
          return PokemonScreen(
            pokemon: state.extra as Pokemon,
          );
        },
      )
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
