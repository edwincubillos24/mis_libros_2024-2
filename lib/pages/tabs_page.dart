import 'package:flutter/material.dart';
import 'package:mis_libros/pages/profile_page.dart';

import 'api_books_page.dart';
import 'book_favorites_page.dart';
import 'book_stores_page.dart';
import 'my_books_page.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Mis Libros"),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list, color: Colors.black)),
                Tab(icon: Icon(Icons.api, color: Colors.black)),
                Tab(icon: Icon(Icons.store, color: Colors.black)),
                Tab(icon: Icon(Icons.person, color: Colors.black)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              MyBooksPage(),
              ApiBooksPage(),
              BookStoresPage(),
              ProfilePage(),
            ],
          ),
        ),
      ),
    );
  }
}
