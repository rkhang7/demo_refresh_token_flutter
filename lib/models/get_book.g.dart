// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBooks _$GetBooksFromJson(Map<String, dynamic> json) => GetBooks(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBooksToJson(GetBooks instance) => <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
