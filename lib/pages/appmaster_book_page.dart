import 'package:flutter/material.dart';
import 'package:mis_libros/repository/appmaster_api.dart';

import '../models/response_api_appmaster_get_books.dart';
import 'appmaster_new_book_page.dart';
import 'new_book_page.dart';

class AppmasterBookPage extends StatefulWidget {
  const AppmasterBookPage({super.key});

  @override
  State<AppmasterBookPage> createState() => _AppmasterBookPageState();
}

class _AppmasterBookPageState extends State<AppmasterBookPage> {
  final AppmasterApi appmasterApi = AppmasterApi();
  List<Data> listBooks = <Data>[];

  Future _getBooks() async {
    listBooks.clear();
    var results = await appmasterApi.getBooks();
    setState(() {
      results.data?.forEach((book) {
        listBooks.add(book);
        print("name: ${book.name}, author: ${book.author}");
      });
    });
  }

  @override
  void initState() {
    _getBooks();
    super.initState();
  }

  void _addButtonClicked() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AppmasterNewBookPage()));
  }

  void showMessage(String msg) {
    SnackBar snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future _deleteBooks(int id) async{
    var result = await appmasterApi.deleteBook(id);
    if (result.success!){
      showMessage("Libro eliminado con exito");
      _getBooks();
    } else {
      showMessage('Error al eliminar el libro');
    }
  }

  showAlertDialog(BuildContext context, Data book) {
    AlertDialog alert = AlertDialog(
      title: const Text("Advertencia"),
      content:
      Text("¿Esta seguro que desea eliminar el libro ${book.name}?"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancelar'),
        ),
        TextButton(
            child: const Text('Aceptar'),
            onPressed: () => {
              _deleteBooks(book.id!.toInt()),
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

  InkWell buildCard(Data book) {
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
          child: Center(
            child: ListView.builder(
              itemCount: listBooks.length,
              itemBuilder: (BuildContext context, int index) {
                Data book = listBooks[index];
                return buildCard(book);
              },
            ),
          ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _addButtonClicked, child: const Icon(Icons.add)),
    );
  }
}
