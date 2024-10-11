import 'package:flutter/material.dart';

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
