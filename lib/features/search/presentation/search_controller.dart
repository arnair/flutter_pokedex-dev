import 'package:flutter_pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:flutter_pokedex/features/pokemon/domain/pokemon_types_enum.dart';

List<Pokemon> filterPokemonList({
  required List<Pokemon> pokemonList,
  required String searchText,
  required bool showCaptured,
  required bool orderABC,
  required PokemonTypes? typeSelected,
}) {
  List<Pokemon> filteredList = pokemonList;

  if (searchText.isNotEmpty) {
    filteredList = filteredList
        .where((element) =>
            element.name.toLowerCase().startsWith(searchText.toLowerCase()))
        .toList();
  }

  if (showCaptured) {
    filteredList = filteredList.where((element) => element.captured).toList();
  }

  if (typeSelected != null) {
    filteredList = filteredList
        .where((element) => element.type.contains(typeSelected))
        .toList();
  }

  if (orderABC) {
    filteredList.sort((a, b) => a.name.compareTo(b.name));
  }

  return filteredList;
}
