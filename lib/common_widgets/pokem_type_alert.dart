import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common_widgets/button_type.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';
import 'package:flutter_pokedex/features/pokemon/domain/pokemon_types_enum.dart';
import 'package:go_router/go_router.dart';

Future<PokemonTypes?> pokemonTypeAlert(BuildContext context) async {
  return showDialog<PokemonTypes?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.black,
            title: const Text(
              textAlign: TextAlign.center,
              'Select a pokemon type',
              style: AppTextStyle.titleWhite,
            ),
            content: SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop(null);
                    },
                    child: const LabelType(
                      pokemonType: null,
                    ),
                  ),
                  ...PokemonTypes.values.map(
                    (e) => GestureDetector(
                      onTap: () {
                        context.pop(e);
                      },
                      child: LabelType(pokemonType: e),
                    ),
                  )
                ],
              ),
            ));
      });
}
