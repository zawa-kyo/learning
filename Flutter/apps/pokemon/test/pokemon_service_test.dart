import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon_app/models/pokemon.dart';
import 'package:pokemon_app/network/pokemon_service.dart';

import 'pokemon_service_test.mocks.dart';

@GenerateMocks([PokemonService])
void main() {
  test('Fetch Pokemon returns a Pokemon object', () async {
    final service = MockPokemonService();
    final mockPokemon = Pokemon(id: 1, name: 'abc', height: 5, weight: 30);

    when(service.fetch(1)).thenAnswer((_) async => mockPokemon);

    final result = await service.fetch(1);

    expect(result, isA<Pokemon>());
    expect(result.name, 'abc');
    expect(result.height, 5);
    expect(result.weight, 30);
  });
}
