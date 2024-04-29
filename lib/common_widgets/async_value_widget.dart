import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/import_theme.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({super.key, required this.value, required this.data});
  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) {
        // print('Here $e');
        // print('Here $st');
        return const Center(
            child: Text(
          'Error',
          style: AppTextStyle.textRed,
        ));
      },
      loading: () {
        return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()));
      },
    );
  }
}
