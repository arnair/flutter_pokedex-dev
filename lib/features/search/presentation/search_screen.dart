import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common_widgets/async_value_widget.dart';
import 'package:flutter_pokedex/features/pokemon/application/pokemon_service.dart';
import 'package:flutter_pokedex/features/pokemon/domain/pokemon_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final pokemonList = ref.watch(pokemonServiceProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: AsyncValueWidget<List<Pokemon>>(
          value: pokemonList,
          data: (data) {
            print('Here ${data[0].photo}');
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return Column(
                  children: [
                    SvgPicture.network(
                      item.photo,
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      item.name,
                    ),
                  ],
                );
              },
            );
          }),
    );
  }
}
