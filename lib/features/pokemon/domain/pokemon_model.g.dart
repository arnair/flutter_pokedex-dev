// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PokemonImpl _$$PokemonImplFromJson(Map<String, dynamic> json) =>
    _$PokemonImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      photo: json['photo'] as String,
      height: (json['height'] as num).toInt(),
      weight: (json['weight'] as num).toInt(),
      type: (json['type'] as List<dynamic>)
          .map((e) => $enumDecode(_$PokemonTypesEnumMap, e))
          .toList(),
      captured: json['captured'] as bool? ?? false,
    );

Map<String, dynamic> _$$PokemonImplToJson(_$PokemonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo': instance.photo,
      'height': instance.height,
      'weight': instance.weight,
      'type': instance.type.map((e) => _$PokemonTypesEnumMap[e]!).toList(),
      'captured': instance.captured,
    };

const _$PokemonTypesEnumMap = {
  PokemonTypes.bug: 'bug',
  PokemonTypes.dark: 'dark',
  PokemonTypes.dragon: 'dragon',
  PokemonTypes.electric: 'electric',
  PokemonTypes.fairy: 'fairy',
  PokemonTypes.fighting: 'fighting',
  PokemonTypes.fire: 'fire',
  PokemonTypes.flying: 'flying',
  PokemonTypes.ghost: 'ghost',
  PokemonTypes.grass: 'grass',
  PokemonTypes.ground: 'ground',
  PokemonTypes.ice: 'ice',
  PokemonTypes.normal: 'normal',
  PokemonTypes.poison: 'poison',
  PokemonTypes.psychic: 'psychic',
  PokemonTypes.rock: 'rock',
  PokemonTypes.steel: 'steel',
  PokemonTypes.water: 'water',
};
