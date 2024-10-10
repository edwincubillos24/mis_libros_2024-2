import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mis_libros/models/api_response_create_book.dart';
import 'package:mis_libros/models/api_response_delete_book.dart';
import 'package:mis_libros/models/api_response_get_books.dart';

import '../models/api_book.dart';
import '../models/local_book.dart';

class AppmasterApi {
  Future<ApiResponseCreateBook> createBook(ApiBook book) async {
    print(jsonEncode(book.toJson()));
    final apiResponse = await http.post(
        Uri.parse('https://wgreosi-app.apms.io/api/create_book/'),
        body: jsonEncode(book.toJson()));
    print('result ${apiResponse.body}');

    print('statusCode = ${apiResponse.statusCode}');
    if (apiResponse.statusCode == 200) {
      return ApiResponseCreateBook.fromJson(jsonDecode(apiResponse.body));
    } else {
      throw Exception('Failed to create book');
    }
  }

  Future<ApiResponseGetBooks> getBooks() async {
    final apiResponse =
        await http.get(Uri.parse('https://wgreosi-app.apms.io/api/get_books/'));
    print('result: ${apiResponse.body}');
    print('statusCode = ${apiResponse.statusCode}');
    if (apiResponse.statusCode == 200) {
      return ApiResponseGetBooks.fromJson(jsonDecode(apiResponse.body));
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<ApiResponseDeleteBook> deleteBook(int id) async {
    final apiResponse = await http.delete(
      Uri.parse('https://wgreosi-app.apms.io/api/delete_book/'),
      body: jsonEncode(<String, int>{
        'id': id,
      }),
    );
    if (apiResponse.statusCode == 200) {
      return ApiResponseDeleteBook.fromJson(jsonDecode(apiResponse.body));
    } else {
      throw Exception('Failed to delete books');
    }
  }
}
