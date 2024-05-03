import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common_widgets/async_value_widget.dart';
import 'package:flutter_pokedex/common_widgets/pokem_type_alert.dart';
import 'package:flutter_pokedex/constants/palette.dart';
import 'package:flutter_pokedex/constants/sizes.dart';
import 'package:flutter_pokedex/constants/textstyles.dart';
import 'package:flutter_pokedex/features/pokemon/application/pokemon_service.dart';
import 'package:flutter_pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:flutter_pokedex/features/pokemon/domain/pokemon_types_enum.dart';
import 'package:flutter_pokedex/features/pokemon/presentation/pokemon_screen.dart';
import 'package:flutter_pokedex/features/search/presentation/search_card.dart';
import 'package:flutter_pokedex/features/search/presentation/search_controller.dart';
import 'package:flutter_pokedex/features/search/presentation/search_switch.dart';
import 'package:flutter_pokedex/routing/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool showCaptured = false;
  bool orderABC = false;
  PokemonTypes? typeSelected;
  bool showSide = false;
  Pokemon? selectedPokemon;

  onPokemonSelected(pokemon) {
    ref
        .read(searchControllerProvider.notifier)
        .updatePokemonSelected(pokemon: pokemon);
    setState(() {
      selectedPokemon = pokemon;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonList = ref.watch(pokemonServiceProvider).whenData((value) {
      return filterPokemonList(
          orderABC: orderABC,
          showCaptured: showCaptured,
          typeSelected: typeSelected,
          pokemonList: value,
          searchText: _searchController.text);
    });

    double screenWidth = MediaQuery.of(context).size.width;
    showSide = screenWidth > webWidth;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: SearchSwitch(
          showCaptured: showCaptured,
          toggleCaptured: () {
            setState(() {
              showCaptured = !showCaptured;
              selectedPokemon = null;
            });
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: !showCaptured
              ? ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 450),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 1),
                    child: TextField(
                      cursorColor: Colors.white,
                      style: AppTextStyle.normalWhite,
                      controller: _searchController,
                      onChanged: (value) => setState(() {}),
                      decoration: InputDecoration(
                          hintText: 'Search pokémons...',
                          hintStyle: const TextStyle(color: Colors.white),
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                    });
                                  },
                                )
                              : const SizedBox()),
                    ),
                  ),
                )
              : SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                orderABC ? Palette.yellow : Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              orderABC = !orderABC;
                            });
                          },
                          label: const Text(
                            'order',
                            style: AppTextStyle.normalBlack,
                          ),
                          icon: const Icon(
                            Icons.sort_by_alpha,
                            color: Colors.black,
                          )),
                      gapW48,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: typeSelected != null
                              ? Palette.yellow
                              : Colors.white,
                        ),
                        onPressed: () async {
                          typeSelected = await pokemonTypeAlert(context);
                          setState(() {});
                        },
                        child: Text(
                          typeSelected == null
                              ? 'Filter by type'
                              : 'Filtered by ${typeSelected!.name}',
                          style: AppTextStyle.normalBlack,
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
      body: AsyncValueWidget<List<Pokemon>>(
          value: pokemonList,
          data: (data) {
            if (data.isEmpty) {
              return const Center(
                  child: Text(
                'No pokemons found',
                style: AppTextStyle.normalWhite,
              ));
            } else {
              return Row(
                children: [
                  Expanded(
                      flex: screenWidth > 1300 ? 2 : 1,
                      child: LayoutBuilder(builder: (context, constraints) {
                        double expandedWidth = constraints.maxWidth;
                        int crossAxisCount = (expandedWidth / 200).ceil();
                        return GridView.builder(
                          padding: const EdgeInsets.all(10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            Pokemon pokemonCard = data[index];
                            return GestureDetector(
                                onTap: () {
                                  showSide
                                      ? onPokemonSelected(pokemonCard)
                                      : context.pushNamed(
                                          AppRoute.pokemon.name,
                                          pathParameters: {
                                            'name': pokemonCard.name
                                          },
                                          extra: pokemonCard,
                                        );
                                },
                                child: SearchCard(pokemon: pokemonCard));
                          },
                        );
                      })),
                  showSide && selectedPokemon != null
                      ? Expanded(
                          child: PokemonScreen(
                            pokemon: selectedPokemon!,
                          ),
                        )
                      : const SizedBox()
                ],
              );
            }
          }),
    );
  }
}
