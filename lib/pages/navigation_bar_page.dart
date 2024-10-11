import 'package:flutter/material.dart';
import 'package:mis_libros/pages/api_books_page.dart';
import 'package:mis_libros/pages/appmaster_book_page.dart';
import 'package:mis_libros/pages/book_stores_page.dart';
import 'package:mis_libros/pages/my_books_page.dart';
import 'package:mis_libros/pages/profile_page.dart';
import 'package:mis_libros/pages/tabs_page.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    MyBooksPage(),
    AppmasterBookPage(),
    ApiBooksPage(),
    BookStoresPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Libros"),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Mis Libros",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.api),
            label: "Appmaster",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.api),
            label: "ApiBooks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: "Tiendas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Mi Perfil",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
