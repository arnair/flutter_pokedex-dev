import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_pokedex/common_widgets/error_alert.dart';
import 'package:flutter_pokedex/features/pokemon/application/pokemon_service.dart';
import 'package:flutter_pokedex/routing/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({super.key});

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends ConsumerState<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadData();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  loadData() async {
    try {
      await ref.read(pokemonServiceProvider.notifier).setPokemonList();
    } on Exception catch (e) {
      if (mounted) {
        bool tryAgain = await errorAlert(
                context, e.toString().replaceAll('Exception:', '')) ??
            false;
        if (tryAgain) {
          loadData();
        }
      }
      return;
    }
    if (mounted) {
      context.pushReplacementNamed(AppRoute.seach.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Image.asset(
                'assets/launcher/android12splash.png',
                width: 200,
                height: 200,
              ),
            );
          },
        ),
      ),
    );
  }
}
