import 'dart:collection';

import 'package:flutter_pokedex/constants/custom_theme.dart';
import 'package:flutter_pokedex/constants/palette.dart';
import 'package:flutter_pokedex/constants/paths.dart';
import 'package:flutter_pokedex/features/pokemon/data/pokemons_repository.dart';
import 'package:flutter_pokedex/features/pokemon/data/pokemons_repository_local.dart';
import 'package:flutter_pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:flutter_pokedex/features/pokemon/domain/pokemon_types_enum.dart';
import 'package:flutter_pokedex/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemon_service.g.dart';

@Riverpod(keepAlive: true)
class PokemonService extends _$PokemonService {
  @override
  Stream<List<Pokemon>> build() {
    return _globalPokemonList.stream;
  }

  final _globalPokemonList = InMemoryStore<List<Pokemon>>([]);

  updateGlobalPokemonList({required List<Pokemon> newGlobalPokemonList}) {
    _globalPokemonList.value = newGlobalPokemonList;
    List<Pokemon> capturedList = newGlobalPokemonList
        .where(
          (element) => element.captured == true,
        )
        .toList();
    if (capturedList.isNotEmpty) {
      mostCommonType(pokemonList: capturedList);
    } else {
      ref
          .read(customThemeProvider.notifier)
          .changeColor(color: Palette.primary);
    }
  }

  Future<List<Pokemon>> setPokemonList() async {
    List<String> pokemonNames = [];
    try {
      pokemonNames = await ref
          .read(pokemonsRepositoryProvider)
          .fetchPokemonSpeciesNames(regionName: Paths.regionName);
    } on Exception catch (e) {
      throw Exception(e);
    }

    List<Pokemon> pokemonList = await ref
        .read(pokemonsRepositoryProvider)
        .fetchPokemons(pokemonNames: pokemonNames);

    List<String> localCapturedList =
        await ref.read(pokemonsRepositoryLocalProvider).fetchCaptured();

    if (localCapturedList.isNotEmpty) {
      for (String captured in localCapturedList) {
        int index =
            pokemonList.indexWhere((element) => element.name == captured);
        pokemonList[index] = pokemonList[index].copyWith(captured: true);
      }
    }

    updateGlobalPokemonList(newGlobalPokemonList: pokemonList);

    return pokemonList;
  }

  Future updatePokemon({required Pokemon pokemon}) async {
    List<Pokemon> newGlobalPokemonList = _globalPokemonList.value;
    int index = newGlobalPokemonList.indexWhere(
      (element) => element.name == pokemon.name,
    );

    newGlobalPokemonList[index] = pokemon;

    await ref.read(pokemonsRepositoryLocalProvider).saveCaptured(
        pokemons: newGlobalPokemonList
            .where((element) => element.captured == true)
            .map((e) => e.name)
            .toList());

    await updateGlobalPokemonList(newGlobalPokemonList: newGlobalPokemonList);
  }

  void mostCommonType({required List<Pokemon> pokemonList}) {
    Map<PokemonTypes, int> typeCount = HashMap<PokemonTypes, int>();

    for (Pokemon pokemon in pokemonList) {
      for (PokemonTypes type in pokemon.type) {
        typeCount.update(type, (value) => value + 1, ifAbsent: () => 1);
      }
    }

    int maxCount = typeCount.values.fold(
        0,
        (previousValue, element) =>
            previousValue > element ? previousValue : element);

    int countMaxCount =
        typeCount.values.where((count) => count == maxCount).length;
    if (countMaxCount > 1) {
      ref
          .read(customThemeProvider.notifier)
          .changeColor(color: Palette.primary);
      return;
    }

    PokemonTypes? mostCommon;
    for (var entry in typeCount.entries) {
      if (entry.value == maxCount) {
        mostCommon = entry.key;
        ref
            .read(customThemeProvider.notifier)
            .changeColor(color: mostCommon.color);
        break;
      }
    }
  }
}
