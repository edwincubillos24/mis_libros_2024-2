import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mis_libros/pages/new_book_page.dart';

import '../repository/firebase_api.dart';

class MyBooksPage extends StatefulWidget {
  const MyBooksPage({super.key});

  @override
  State<MyBooksPage> createState() => _MyBooksPageState();
}

class _MyBooksPageState extends State<MyBooksPage> {

  final FirebaseApi _firebaseApi = FirebaseApi();

  void _addButtonClicked() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewBookPage()));
  }

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
  }
}
