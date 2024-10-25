import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mis_libros/models/hive_local_book.dart';

import '../boxes.dart';

class BookFavoritesPage extends StatefulWidget {
  const BookFavoritesPage({super.key});

  @override
  State<BookFavoritesPage> createState() => _BookFavoritesPageState();
}

class _BookFavoritesPageState extends State<BookFavoritesPage> {
  Widget _buildListView() {
    return ValueListenableBuilder<Box<HiveLocalBook>>(
        valueListenable: Boxes.getHiveLocalBookBox().listenable(),
        builder: (context, box, _) {
          final bookBox = box.values.toList().cast<HiveLocalBook>();
          return ListView.builder(
            itemCount: bookBox.length,
            itemBuilder: (BuildContext context, int index) {
              final book = bookBox[index];
              return Card(
                child: ListTile(
                  title: Text(book.title ?? "No title"),
                  subtitle: Text(book.author ?? "No author"),
                  leading: Image.network(
                    book.bookImage ?? "",
                  ),
                  onTap: () {},
                  onLongPress: () {
                    book.delete();
                  },
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: _buildListView(),
        ),
      ),
    );
  }
}
