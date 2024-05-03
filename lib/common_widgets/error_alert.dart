import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';
import 'package:go_router/go_router.dart';

errorAlert(BuildContext context, String error) async {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Pokedex not able to open',
            style: AppTextStyle.titleBlack,
          ),
          content: Text(
            error,
            style: AppTextStyle.normalBlack,
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  context.pop(true);
                },
                child: const Text('Try again'))
          ],
        );
      });
}
