import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_pokedex/constants/custom_theme.dart';
import 'package:flutter_pokedex/routing/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  runApp(const ProviderScope(child: Pokedex()));
}

class Pokedex extends ConsumerWidget {
  const Pokedex({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final customTheme = ref.watch(customThemeProvider);
    return MaterialApp.router(
      restorationScopeId: 'app',
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      theme: customTheme,
    );
  }
}
