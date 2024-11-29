import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/viewmodels/pokemon_viewmodel.dart';

class PokemonDetailView extends ConsumerWidget {
  final int id;

  const PokemonDetailView({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(pokemonProvider(id));

    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: asyncValue.when(
        data: (pokemon) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Name: ${pokemon.name}'),
              Text('Height: ${pokemon.height}'),
              Text('Weight: ${pokemon.weight}'),
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
