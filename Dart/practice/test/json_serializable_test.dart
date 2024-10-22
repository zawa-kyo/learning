import 'package:test/test.dart';
import 'package:practice/json_serializable/book.dart';
import 'package:practice/json_serializable/author.dart';

void main() {
  group('Book', () {
    test('シリアライズとデシリアライズが正しく行われる', () {
      // テスト用のAuthor, Bookインスタンスを作成
      final author = Author(id: 67890, name: 'John Doe');
      final book =
          Book(id: 12345, name: 'Test Book', price: 12.345, author: author);

      // シリアライズして期待されるJSONマップと等しいか確認
      final json = book.toJson();
      final expectedJson = {
        'id': 12345,
        'name': 'Test Book',
        'price': 12.345,
        'author': {
          'id': 67890,
          'name': 'John Doe',
        },
      };

      expect(json, equals(expectedJson));

      // Bookオブジェクトにデシリアライズして等しいか確認
      final deserializedBook = Book.fromJson(json);

      expect(deserializedBook.id, equals(book.id));
      expect(deserializedBook.name, equals(book.name));
      expect(deserializedBook.price, equals(book.price));
      expect(deserializedBook.author?.id, equals(book.author?.id));
      expect(deserializedBook.author?.name, equals(book.author?.name));
    });

    test('authorがnullの場合でも正しく処理される', () {
      // authorがnullのBookオブジェクトを作成
      final book = Book(id: 456, name: 'No Author Book', price: 9.99);

      // シリアライズして期待されるJSONマップと等しいか確認
      final json = book.toJson();
      final expectedJson = {
        'id': 456,
        'name': 'No Author Book',
        'price': 9.99,
        'author': null,
      };
      expect(json, equals(expectedJson));

      // JSONからBookオブジェクトにデシリアライズ
      final deserializedBook = Book.fromJson(json);

      // デシリアライズしたオブジェクトが正しいか確認
      expect(deserializedBook.id, equals(book.id));
      expect(deserializedBook.name, equals(book.name));
      expect(deserializedBook.price, equals(book.price));
      expect(deserializedBook.author, isNull);
    });
  });
}
