import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mis_libros/repository/appmaster_api.dart';

import '../models/request_api_create_book.dart';

class AppmasterNewBookPage extends StatefulWidget {
  const AppmasterNewBookPage({super.key});

  @override
  State<AppmasterNewBookPage> createState() => _AppmasterNewBookPageState();
}

class _AppmasterNewBookPageState extends State<AppmasterNewBookPage> {

  final AppmasterApi appmasterApi = AppmasterApi();

  final _name = TextEditingController();
  final _author = TextEditingController();
  final _pages = TextEditingController();

  double _rating = 3.0;

  bool _isActionGenre = false,
      _isAdventureGenre = false,
      _isDramaGenre = false;
  bool _isFantasyGenre = false,
      _isFictionGenre = false,
      _isRomanceGenre = false;
  bool _isSuspenseGenre = false, _isTerrorGenre = false;

  Future<void> _saveBook() async{

    var book = Book (
        name: _name.text,
        author: _author.text,
        pages: int.parse(_pages.text),
        rating: _rating,
        id: 0,
        isActionGenre: _isActionGenre,
        isAdventureGenre: _isAdventureGenre,
        isDramaGenre: _isDramaGenre,
        isFantasyGenre: _isFantasyGenre,
        isFictionGenre: _isFictionGenre,
        isRomanceGenre: _isRomanceGenre,
        isSuspenseGenre: _isSuspenseGenre,
        isTerrorGenre: _isTerrorGenre,
        urlPicture: "");

    var requestApiCreateBook = RequestApiCreateBook(book: book);
    var resultApi = await appmasterApi.createBook(requestApiCreateBook);

    if (resultApi.success!) {
      showMessage('Libro creado exitosamente');
      Navigator.pop(context);
    } else {
      showMessage('Error al crear el libro');
    }
  }

  void showMessage(String msg) {
    SnackBar snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Libro'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                height: 170,
                child: Stack(
                  children: [
                    image != null
                        ? Image.file(image!, width: 150, height: 150)
                        : const Image(
                      image: AssetImage('assets/images/logo.png'),
                      width: 150,
                      height: 150,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        alignment: Alignment.bottomLeft,
                        onPressed: () async {
                          pickImage();
                        },
                        icon: const Icon(Icons.camera_alt),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Nombre'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _author,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Autor'),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _pages,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Páginas'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 16.0,
              ),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _rating = rating;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Género(s) del libro',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Acción'),
                      value: _isActionGenre,
                      selected: _isActionGenre,
                      onChanged: (bool? value) {
                        setState(() {
                          _isActionGenre = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Aventura'),
                      value: _isAdventureGenre,
                      selected: _isAdventureGenre,
                      onChanged: (bool? value) {
                        setState(() {
                          _isAdventureGenre = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Drama'),
                      value: _isDramaGenre,
                      selected: _isDramaGenre,
                      onChanged: (bool? value) {
                        setState(() {
                          _isDramaGenre = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Fantasia'),
                      value: _isFantasyGenre,
                      selected: _isFantasyGenre,
                      onChanged: (bool? value) {
                        setState(() {
                          _isFantasyGenre = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Ficción'),
                      value: _isFictionGenre,
                      selected: _isFictionGenre,
                      onChanged: (bool? value) {
                        setState(() {
                          _isFictionGenre = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Romance'),
                      value: _isRomanceGenre,
                      selected: _isRomanceGenre,
                      onChanged: (bool? value) {
                        setState(() {
                          _isRomanceGenre = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Suspenso'),
                      value: _isSuspenseGenre,
                      selected: _isSuspenseGenre,
                      onChanged: (bool? value) {
                        setState(() {
                          _isSuspenseGenre = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Terror'),
                      value: _isTerrorGenre,
                      selected: _isTerrorGenre,
                      onChanged: (bool? value) {
                        setState(() {
                          _isTerrorGenre = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _saveBook();
                },
                child: const Text('Guardar libro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
