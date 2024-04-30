import 'package:flutter_pokedex/constants/import_theme.dart';
import 'package:flutter_pokedex/features/pokemon/data/pokemons_repository.dart';
import 'package:flutter_pokedex/features/pokemon/domain/pokemon_model.dart';
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
  }

  Future<List<Pokemon>> setPokemonList() async {
    List<String> pokemonNames = await ref
        .read(pokemonsRepositoryProvider)
        .fetchPokemonSpeciesNames(regionName: Paths.regionName);

    List<Pokemon> pokemonList = await ref
        .read(pokemonsRepositoryProvider)
        .fetchPokemons(pokemonNames: pokemonNames);
    print('Here aaaaaaa');

    updateGlobalPokemonList(newGlobalPokemonList: pokemonList);
    return pokemonList;
  }
}
