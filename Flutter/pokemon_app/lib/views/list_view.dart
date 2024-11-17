import 'package:flutter/material.dart';
import 'package:pokemon_app/views/detail_view.dart';

class PokemonListView extends StatelessWidget {
  const PokemonListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<int> pokemonIds = List.generate(10, (index) => index + 1);

    return Scaffold(
      appBar: AppBar(title: Text('Pokemon List')),
      body: ListView.builder(
        itemCount: pokemonIds.length,
        itemBuilder: (context, index) {
          final id = pokemonIds[index];
          return ListTile(
            title: Text('Pokemon #$id'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PokemonDetailView(id: id),
              ));
            },
          );
        },
      ),
    );
  }
}
