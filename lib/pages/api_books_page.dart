import 'package:flutter/material.dart';
import 'package:mis_libros/models/response_api_nytimes.dart';
import 'package:mis_libros/pages/detail_api_book_page.dart';
import 'package:mis_libros/repository/nytimes_api.dart';

class ApiBooksPage extends StatefulWidget {
  const ApiBooksPage({super.key});

  @override
  State<ApiBooksPage> createState() => _ApiBooksPageState();
}

class _ApiBooksPageState extends State<ApiBooksPage> {
  final NytimesApi nytimesApi = NytimesApi();
  List<Books> listBooks = <Books>[];

  Future _getBooks() async {
    var results = await nytimesApi.getBooks();
    setState(() {
      results.results?.lists?.forEach((list) {
        list.books?.forEach((book) {
          listBooks.add(book);
        });
      });
    });
  }

  @override
  void initState() {
    _getBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Expanded(
            child: ListView.builder(
              itemCount: listBooks.length,
              itemBuilder: (BuildContext context, int index) {
                Books book = listBooks[index];
                return Card(
                  child: ListTile(
                    title: Text(book.title ?? "No title"),
                    subtitle: Text(book.author ?? "No author"),
                    leading: Image.network(
                      book.bookImage ?? "",
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailApiBookPage(book)));
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
