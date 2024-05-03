import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';
import 'package:flutter_pokedex/features/pokemon/domain/pokemon_types_enum.dart';

class LabelType extends StatelessWidget {
  final PokemonTypes? pokemonType;

  const LabelType({
    required this.pokemonType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(
              color: pokemonType != null ? pokemonType!.color : Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Text(
        pokemonType != null ? pokemonType!.name : 'Show All',
        style: AppTextStyle.normalWhite.copyWith(
            color: pokemonType != null ? pokemonType!.color : Colors.white),
      ),
    );
  }
}
