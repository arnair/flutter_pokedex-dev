import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common_widgets/button_type.dart';
import 'package:flutter_pokedex/constants/custom_theme.dart';
import 'package:flutter_pokedex/constants/palette.dart';
import 'package:flutter_pokedex/constants/sizes.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';
import 'package:flutter_pokedex/features/pokemon/application/pokemon_service.dart';
import 'package:flutter_pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:flutter_pokedex/features/search/presentation/search_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class PokemonScreen extends ConsumerStatefulWidget {
  final Pokemon pokemon;
  const PokemonScreen({super.key, required this.pokemon});
  @override
  PokemonScreenState createState() => PokemonScreenState();
}

class PokemonScreenState extends ConsumerState<PokemonScreen> {
  late Pokemon pokemon;
  bool _isButtonDisabled = false;
  bool captured = false;
  @override
  void initState() {
    super.initState();
    pokemon = widget.pokemon;
    captured = pokemon.captured;
  }

  @override
  Widget build(BuildContext context) {
    if ((MediaQuery.of(context).size.width) > webWidth) {
      pokemon = ref.watch(searchControllerProvider) ?? widget.pokemon;
    }
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
          '${pokemon.id}: ${pokemon.name}',
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
                  pokemon.type.first.color,
                  Colors.black,
                ],
              ),
            ),
            child: Stack(
              children: [
                Hero(
                  tag: pokemon.id,
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 250,
                      width: 250,
                      child: SvgPicture.network(
                        pokemon.photo,
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
                            Text(pokemon.height.toString(),
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
                            Text(pokemon.weight.toString(),
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
                      ...pokemon.type.map((e) => LabelType(
                            pokemonType: e,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          gapH20,
          ElevatedButton(
              onPressed: _isButtonDisabled
                  ? null
                  : () async {
                      setState(() {
                        captured = !captured;
                        _isButtonDisabled = true;
                      });
                      pokemon = pokemon.copyWith(captured: captured);
                      await ref
                          .read(pokemonServiceProvider.notifier)
                          .updatePokemon(pokemon: pokemon);
                      if (context.mounted) {
                        final scaffoldMessenger = ScaffoldMessenger.of(context);
                        scaffoldMessenger.removeCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Palette.yellow,
                            duration: const Duration(seconds: 1),
                            content: Text(
                              captured
                                  ? 'Pokemon ${pokemon.name} captured!'
                                  : 'Pokemon ${pokemon.name} released!',
                              style: AppTextStyle.titleBlack,
                            ),
                          ),
                        );
                      }

                      setState(() {
                        _isButtonDisabled = false;
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: captured ? context.colorTheme : Colors.white,
                minimumSize: const Size(200, 50),
              ),
              child: Text(
                !captured ? 'Capture' : 'Release',
                style: !captured
                    ? AppTextStyle.titleBlack
                    : AppTextStyle.titleWhite,
              ))
        ],
      ),
    );
  }
}
