import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';
import 'package:flutter_pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:flutter_svg/svg.dart';

class SearchCard extends StatelessWidget {
  final Pokemon pokemon;

  const SearchCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
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
    );
  }
}
