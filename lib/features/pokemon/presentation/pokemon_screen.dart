import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/sizes.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';
import 'package:flutter_pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class PokemonScreen extends ConsumerStatefulWidget {
  final Pokemon pokemon;
  const PokemonScreen({super.key, required this.pokemon});
  @override
  PokemonScreenState createState() => PokemonScreenState();
}

class PokemonScreenState extends ConsumerState<PokemonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          '${widget.pokemon.id}: ${widget.pokemon.name}',
          style: AppTextStyle.titleWhite,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 430,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  widget.pokemon.type.first.color,
                  Colors.black,
                ],
              ),
            ),
            child: Stack(
              children: [
                Hero(
                  tag: widget.pokemon.id,
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 250,
                      width: 250,
                      child: SvgPicture.network(
                        widget.pokemon.photo,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.height,
                              color: Colors.white,
                            ),
                            gapW8,
                            Text(widget.pokemon.height.toString(),
                                style: AppTextStyle.titleWhite),
                          ],
                        ),
                        gapH12,
                        Row(
                          children: [
                            const Icon(
                              Icons.monitor_weight_outlined,
                              color: Colors.white,
                            ),
                            gapW8,
                            Text(widget.pokemon.weight.toString(),
                                style: AppTextStyle.titleWhite),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...widget.pokemon.type.map((e) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            margin:
                                const EdgeInsets.only(right: 10, bottom: 30),
                            decoration: BoxDecoration(
                                border: Border.all(color: e.color),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Text(
                              e.name,
                              style: AppTextStyle.normalWhite
                                  .copyWith(color: e.color),
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          gapH20,
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              child: const Text(
                'Capture',
                style: AppTextStyle.titleBlack,
              ))
        ],
      ),
    );
  }
}
