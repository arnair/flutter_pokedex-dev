import 'package:flutter_pokedex/features/pokemon/application/pokemon_service.dart';
import 'package:flutter_pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LodingScreenController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}
  Future<bool> setPokemons() async {
    List<Pokemon> pokemonList =
        await ref.read(pokemonServiceProvider.notifier).setPokemonList();

    return pokemonList.isNotEmpty;
  }
}

final loadingScreenControllerProvider =
    AsyncNotifierProvider<LodingScreenController, void>(
        LodingScreenController.new);
