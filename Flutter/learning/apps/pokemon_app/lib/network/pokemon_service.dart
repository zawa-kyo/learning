import 'package:pokemon_app/models/pokemon.dart';

abstract class PokemonService {
  /// `id`をもつポケモンを取得してパースする
  Future<Pokemon> fetch(int id);
}
