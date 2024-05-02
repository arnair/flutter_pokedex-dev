import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../constants/sizes.dart';
import '../routing/app_router.dart';

class EmptyPlaceholderWidget extends StatelessWidget {
  const EmptyPlaceholderWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            gapH32,
            ElevatedButton(
              onPressed: () => context.goNamed(AppRoute.seach.name),
              child: const Text('Go Home'),
            )
          ],
        ),
      ),
    );
  }
}
