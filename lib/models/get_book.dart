import 'package:test_jwt/models/book.dart';

import 'package:json_annotation/json_annotation.dart';
part 'get_book.g.dart';

@JsonSerializable()
class GetBooks {
  String status;
  List<Book> data;
  GetBooks({
    required this.status,
    required this.data,
  });

  factory GetBooks.fromJson(Map<String, dynamic> json) =>
      _$GetBooksFromJson(json);
  Map<String, dynamic> toJson() => _$GetBooksToJson(this);
}
