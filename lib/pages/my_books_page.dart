import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mis_libros/pages/new_book_page.dart';
import 'package:mis_libros/repository/appmaster_api.dart';

import '../models/api_response_get_books.dart';
import '../repository/firebase_api.dart';

class MyBooksPage extends StatefulWidget {
  const MyBooksPage({super.key});

  @override
  State<MyBooksPage> createState() => _MyBooksPageState();
}

class _MyBooksPageState extends State<MyBooksPage> {

  final FirebaseApi _firebaseApi = FirebaseApi();

  final AppmasterApi _appmasterApi = AppmasterApi();

  List<Data> listBooks = <Data>[];

  Future _getBooks() async {
    listBooks.clear();
    var resultsFuture = await _appmasterApi.getBooks();
    setState(() {
      resultsFuture.data?.forEach((book) {
        listBooks.add(book);
        print('id: ${book.id} libro: ${book.name}, rating ${book.rating}');
      });
    });
  }

  Future _deleteBook(int id) async {
    var result = await _appmasterApi.deleteBook(id);
    if (result.success!) {
      showMessage("Libro eliminado con exito");
      _getBooks();
    } else {
      showMessage("error no se por que");
    }
  }

  void showMessage(String msg) {
    SnackBar snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _addButtonClicked() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewBookPage()));
  }

  showAlertDialogApi(BuildContext context, Data book) {
    AlertDialog alert = AlertDialog(
      title: const Text("Advertencia"),
      content: Text("¿Esta seguro que desea eliminar el libro ${book.name}?"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancelar'),
        ),
        TextButton(
            child: const Text('Aceptar'),
            onPressed: () => {
                  _deleteBook(book.id!.toInt()),
                  Navigator.pop(context, 'OK'),
                }),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  InkWell buildCardAPI(Data book) {
    var heading = book.name!;
    var subheading = book.author!;
    var cardImage = book.urlPicture == ""
        ? const AssetImage('assets/images/logo.png') as ImageProvider
        : NetworkImage(book.urlPicture!);

    return InkWell(
      onTap: () {
        print("clic");
      },
      onLongPress: () {
        print("longClic");
        showAlertDialogApi(context, book);
      },
      child: Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(heading),
              subtitle: Text(subheading),
            ),
            Container(
              height: 100.0,
              width: 100.0,
              child: Ink.image(
                image: Image.memory(base64Decode(book.urlPicture!)) as ImageProvider,
              ),
            ),
            const SizedBox(
              height: 8.0,
            )
          ],
        ),
      ),
    );
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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: listBooks.length,
                itemBuilder: (BuildContext context, int index) {
                  Data book = listBooks[index];
                  return buildCardAPI(book);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _addButtonClicked, child: const Icon(Icons.add)),
    );
  }

/* //-----------------FIREBASE

  showAlertDialog(BuildContext context, QueryDocumentSnapshot book) {
    AlertDialog alert = AlertDialog(
      title: const Text("Advertencia"),
      content:
          Text("¿Esta seguro que desea eliminar el libro ${book['name']}?"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancelar'),
        ),
        TextButton(
            child: const Text('Aceptar'),
            onPressed: () => {
                  _firebaseApi.deleteBook(book),
                  Navigator.pop(context, 'OK'),
                }),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

    InkWell buildCard(QueryDocumentSnapshot book) {
    var heading = book['name'];
    var subheading = book['author'];
    var cardImage = book['urlPicture'] == ""
        ? const AssetImage('assets/images/logo.png') as ImageProvider
        : NetworkImage(book['urlPicture']);

    return InkWell(
      onTap: () {
        print("clic");
      },
      onLongPress: () {
        print("longClic");
        showAlertDialog(context, book);
      },
      child: Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(heading),
              subtitle: Text(subheading),
              /*  leading: Image.network(
                book['urlPicture'] ?? "",
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stracktrace) {
                  return const Image(
                    image: AssetImage('assets/images/logo.png'),
                  );
                },
              ),*/
            ),
            Container(
              height: 100.0,
              width: 100.0,
              child: Ink.image(
                image: cardImage,
              ),
            ),
            const SizedBox(
              height: 8.0,
            )
          ],
        ),
      ),
    );
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("books").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text("Loading...");
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot book = snapshot.data!.docs[index];
                  return buildCard(book);
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _addButtonClicked, child: const Icon(Icons.add)),
    );
  }*/
}
