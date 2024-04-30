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
    required String type,
    @Default(false) bool captured,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  factory Pokemon.fromApiJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] as int,
      name: json['name'] as String,
      photo: json['sprites']['other']['dream_world']['front_default'] as String,
      height: json['height'] as int,
      weight: json['weight'] as int,
      type: json['types'][0]['type']['name'] as String,
    );
  }
}
