import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mis_libros/models/request_api_create_book.dart';
import 'package:mis_libros/models/response_api_appmaster_create_book.dart';
import 'package:mis_libros/models/response_api_appmaster_get_books.dart';

import '../models/response_api_appmaster_delete_book.dart';

class AppmasterApi {
  Future<ResponseApiAppmasterGetBooks> getBooks() async {
    final apiResponse =
        await http.get(Uri.parse('https://wgreosi-app.apms.io/api/get_books/'));

    if (apiResponse.statusCode == 200) {
      return ResponseApiAppmasterGetBooks.fromJson(
          jsonDecode(apiResponse.body));
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<ResponseApiAppmasterCreateBook> createBook(RequestApiCreateBook book) async {
    final apiResponse = await http.post(
        Uri.parse('https://wgreosi-app.apms.io/api/create_book/'),
        body: jsonEncode(book.toJson()));

    if (apiResponse.statusCode == 200) {
      return ResponseApiAppmasterCreateBook.fromJson(
          jsonDecode(apiResponse.body));
    } else {
      throw Exception('failed to create books');
    }
  }

  Future<ResponseApiAppmasterDeleteBook> deleteBook(int id) async {
    final apiResponse = await http.delete(
        Uri.parse('https://wgreosi-app.apms.io/api/delete_book/'),
        body: jsonEncode(<String, int>{
          'id': id,
        }));
    print("apiResponse: ${apiResponse.statusCode}");
    if (apiResponse.statusCode == 200) {
      return ResponseApiAppmasterDeleteBook.fromJson(
          jsonDecode(apiResponse.body));
    } else {
      throw Exception('failed to create books');
    }
  }


}
