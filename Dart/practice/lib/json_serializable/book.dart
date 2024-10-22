import 'author.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable(explicitToJson: true)
class Book {
  final int id;
  final String name;
  final double price;
  final Author? author;

  Book(
      {required this.id, required this.name, required this.price, this.author});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}
