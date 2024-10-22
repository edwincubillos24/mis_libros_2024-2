import 'package:flutter/material.dart';
import 'package:mis_libros/models/hive_local_book.dart';

import '../boxes.dart';
import '../models/response_api_nytimes.dart';

class DetailApiBookPage extends StatefulWidget {
  final Books book;

  const DetailApiBookPage(this.book, {super.key});

  @override
  State<DetailApiBookPage> createState() => _DetailApiBookPageState(book);
}

class _DetailApiBookPageState extends State<DetailApiBookPage> {
  final Books book;

  _DetailApiBookPageState(this.book);

  void _saveBookInFavorites(){
    var hiveLocalBook = HiveLocalBook()
    ..title = book.title
    ..bookImage = book.bookImage
    ..author = book.author
    ..publisher = book.publisher
    ..description = book.description;

    final box = Boxes.getHiveLocalBookBox();
    box.add(hiveLocalBook);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title ?? "No title"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(book.bookImage ?? ""),
              SizedBox(height: 8.0,),
              IconButton(
                alignment: Alignment.bottomLeft,
                icon: const Icon(Icons.favorite),
                onPressed: _saveBookInFavorites,
              ),
              SizedBox(height: 8.0,),
              Text("Author: ${book.author}"),
              SizedBox(height: 8.0,),
              Text("Editorial: ${book.publisher}"),
              SizedBox(height: 8.0,),
              Text("Decription: ${book.description}",
              textAlign: TextAlign.justify,),
            ],
          ),
        ),
      ),
    );
  }
}
