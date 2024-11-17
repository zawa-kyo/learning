import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:pokemon_app/models/pokemon.dart';
import 'pokemon_service.dart';

class PokemonServiceImpl implements PokemonService {
  /// 特定の`id`をもつポケモンを取得するUriを戻す
  Uri _getParsedUri(int id) {
    return Uri.parse('https://pokeapi.co/api/v2/pokemon/$id/');
  }

  @override
  Future<Pokemon> fetch(int id) async {
    final uri = _getParsedUri(id);
    final response = await http.get(uri);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to fetch Pokemon Info');
    }

    final decodedResponse = json.decode(response.body);
    return Pokemon.fromJson(decodedResponse);
  }
}
