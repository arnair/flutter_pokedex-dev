import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pokemons_repository.g.dart';

class PokemonsRepository {
  Future<List<Pokemon>> fetchPokemons(
      {required List<String> pokemonNames}) async {
    List<Future<Pokemon>> pokemonFutures = [];

    for (String pokemonName in pokemonNames) {
      final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName');
      pokemonFutures.add(fetchPokemon(url));
    }

    List<Pokemon> pokemons = await Future.wait(pokemonFutures);

    return pokemons;
  }

  Future<Pokemon> fetchPokemon(Uri url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Pokemon.fromApiJson(jsonDecode(response.body));
    } else {
      throw Exception('Error fetching Pokemon: ${response.statusCode}');
    }
  }

  Future<List<String>> fetchPokemonSpeciesNames(
      {required String regionName}) async {
    try {
      final response = await http
          .get(Uri.parse('https://pokeapi.co/api/v2/pokedex/$regionName/'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final pokemonEntries = data['pokemon_entries'] as List;

        final speciesNames = pokemonEntries
            .map((entry) => entry['pokemon_species']['name'] as String)
            .toList();

        return speciesNames;
      } else {
        throw Exception('Failed to load Pokemon data');
      }
    } on SocketException {
      throw Exception('No internet connection');
    } catch (e) {
      throw Exception('Failed to load Pokemon data: $e');
    }
  }
}

@riverpod
PokemonsRepository pokemonsRepository(Ref ref) {
  return PokemonsRepository();
}
