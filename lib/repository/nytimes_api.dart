import 'dart:convert';

import 'package:mis_libros/models/response_api_nytimes.dart';
import 'package:http/http.dart' as http;

class NytimesApi {

  Future<ResponseApiNytimes> getBooks() async {
    final response = await http.get(Uri.parse(
        'https://api.nytimes.com/svc/books/v3/lists/full-overview.json?api-key=5G41UbKylBuWJfBlSsOQQxXEG7E3vZCs'));
    print("resultado ${response.body}");

    if (response.statusCode == 200){
      return ResponseApiNytimes.fromJson(jsonDecode(response.body));
    } else
      throw Exception('Falla al cargar los libros');
  }
}