import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/network/pokemon_service.dart';
import 'package:pokemon_app/network/pokemon_service_impl.dart';

final pokemonServiceProvider =
    Provider<PokemonService>((ref) => PokemonServiceImpl());

final pokemonProvider = FutureProvider.family<Pokemon, int>((ref, id) async {
  final service = ref.watch(pokemonServiceProvider);
  return service.fetch(id);
});
