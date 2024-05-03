import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pokemons_repository_local.g.dart';

class PokemonsRepositoryLocal {
  Future saveCaptured({required List<String> pokemons}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('capuredPokemons', pokemons);
  }

  Future<List<String>> fetchCaptured() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('capuredPokemons') ?? [];
  }
}

@riverpod
PokemonsRepositoryLocal pokemonsRepositoryLocal(Ref ref) {
  return PokemonsRepositoryLocal();
}
