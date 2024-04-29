import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingAnimation extends ConsumerStatefulWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  ConsumerState<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends ConsumerState<LoadingAnimation>
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
    startAll();
  }

  bool isSmaller(String version1, String version2) {
    List<int> v1 = version1.split('.').map(int.parse).toList();
    List<int> v2 = version2.split('.').map(int.parse).toList();

    // Compare major versions
    if (v1[0] < v2[0]) {
      return true;
    } else if (v1[0] > v2[0]) {
      return false;
    }

    // Compare minor versions
    if (v1[1] < v2[1]) {
      return true;
    } else if (v1[1] > v2[1]) {
      return false;
    }

    // Compare patch versions
    if (v1[2] < v2[2]) {
      return true;
    }

    return false; // Equal or version1 is greater
  }

  startAll() async {}

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
            colors: [
              Color(0xFFD8FAAE),
              Color(0xFF86E2BF),
            ],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation.value,
                child: Image.asset(
                  'assets/launcher/android12splash.png', // Replace this with your image path
                  width: 200, // Adjust the width as needed
                  height: 200, // Adjust the height as needed
                ),
              );
            },
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      // backgroundColor: const Color(0xFFDDFCAC),
    );
  }
}
