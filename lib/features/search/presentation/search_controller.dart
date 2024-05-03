import 'package:flutter_pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:flutter_pokedex/features/pokemon/domain/pokemon_types_enum.dart';

List<Pokemon> filterPokemonList({
  required List<Pokemon> pokemonList,
  required String searchText,
  required bool showCaptured,
  required bool orderABC,
  required PokemonTypes? typeSelected,
}) {
  if (!showCaptured && searchText.isEmpty && typeSelected == null) {
    return pokemonList;
  }

  List<Pokemon> filteredList = pokemonList;

  if (!showCaptured) {
    if (searchText.isNotEmpty) {
      filteredList = filteredList
          .where((pokemon) =>
              pokemon.name.toLowerCase().startsWith(searchText.toLowerCase()))
          .toList();
    }
  } else {
    filteredList = filteredList.where((pokemon) => pokemon.captured).toList();

    if (typeSelected != null) {
      filteredList = filteredList
          .where((pokemon) => pokemon.type.contains(typeSelected))
          .toList();
    }
    if (orderABC) {
      filteredList.sort((a, b) => a.name.compareTo(b.name));
    } else {
      filteredList.sort((a, b) => a.id.compareTo(b.id));
    }
  }

  return filteredList;
}

changeColor() {}
