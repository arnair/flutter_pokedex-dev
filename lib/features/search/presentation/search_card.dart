import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';
import 'package:flutter_pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:flutter_pokedex/routing/app_router.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SearchCard extends StatelessWidget {
  final Pokemon pokemon;

  const SearchCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: GestureDetector(
        onTap: () {
          context.pushNamed(
            AppRoute.pokemon.name,
            pathParameters: {'name': pokemon.name},
            extra: pokemon,
          );
        },
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                pokemon.type.first.color,
                Colors.black,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: pokemon.id,
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: SvgPicture.network(
                    pokemon.photo,
                  ),
                ),
              ),
              Text(
                pokemon.name,
                style: AppTextStyle.normalWhite,
              )
            ],
          ),
        ),
      ),
    );
  }
}
