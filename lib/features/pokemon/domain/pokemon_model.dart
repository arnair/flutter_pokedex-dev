import 'package:flutter_pokedex/features/pokemon/domain/pokemon_types_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_model.freezed.dart';
part 'pokemon_model.g.dart';

@freezed
class Pokemon with _$Pokemon {
  const factory Pokemon({
    required int id,
    required String name,
    required String photo,
    required int height,
    required int weight,
    required List<PokemonTypes> type,
    @Default(false) bool captured,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  factory Pokemon.fromApiJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] as int,
      name: (json['name'] as String)[0].toUpperCase() +
          (json['name'] as String).substring(1),
      photo: json['sprites']['other']['dream_world']['front_default'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      type: (json['types'] as List)
          .map((typeJson) =>
              PokemonTypes.fromString(typeJson['type']['name'] as String))
          .toList(),
    );
  }
}
