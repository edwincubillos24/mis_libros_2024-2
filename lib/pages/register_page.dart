import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../repository/firebase_api.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Genre { male, female }

class _RegisterPageState extends State<RegisterPage> {

  final FirebaseApi _firebaseApi = FirebaseApi();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();

  bool _isActionFavorite = false,
      _isAdventureFavorite = false,
      _isFictionFavorite = false,
      _isSuspenseFavorite = false;

  bool _isPasswordObscure = true;
  bool _isRepPasswordObscure = true;

  Genre? _genre = Genre.male;

  late String? _city;

  final List<String> _cities = [
    'Barranquilla',
    'Bogotá',
    'Cali',
    'Medellin',
    'Pereira'
  ];

  String buttonMsg = "Fecha de nacimiento";

  DateTime _date = DateTime.now();

  String _dateConverter(DateTime date){
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dateFormatted = formatter.format(date);
    return dateFormatted;
  }

  void _showSelectDate() async {
    final DateTime? newDate = await showDatePicker(
      locale: const Locale("es"),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1924,1),
      lastDate: DateTime.now(),
      helpText: "Fecha de nacimiento",
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
        buttonMsg = "Fecha de nacimiento: ${_dateConverter(newDate)}";
      });
    }
  }

  void _showMsg(String msg){
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
        SnackBar(
          content: Text(msg),
          duration: Duration(days: 365),
          action: SnackBarAction(
            label: "Aceptar", onPressed: scaffold.hideCurrentSnackBar),
          ),
        );
  }

  void _saveUser(User user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", jsonEncode(user));
    Navigator.pop(context);
  }
  void _onRegisterButtonClicked(){
    String genre = "Masculino";
    if (_email.text.isEmpty || _password.text.isEmpty){
      _showMsg("ERROR: Debe digitar el correo y la contraseña");
    } else {
      if (_password.text != _repPassword.text) {
        _showMsg("ERROR: Las contraseñas deben de ser iguales");
      } else {
        if (_genre == Genre.female){
          genre = "Femenino";
        }
        var user = User(
          _name.text, _email.text, _password.text, _city, genre,
          _isActionFavorite, _isAdventureFavorite, _isFictionFavorite, _isSuspenseFavorite,
          _date.toString());
        _saveUser(user);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 192,
                  height: 192,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nombre",
                      prefixIcon: Icon(Icons.person)),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Correo electrónico",
                      prefixIcon: Icon(Icons.email),
                      helperText: "*Campo obligatorio"),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Debe digitar un correo";
                    } else {
                      if (!value!.isValidEmail() ){
                        return "Correo inválido";
                      }
                    }
                  }
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _password,
                  obscureText: _isPasswordObscure,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Contraseña",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordObscure
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isPasswordObscure = !_isPasswordObscure;
                          });
                        },
                      ),
                      helperText: "*Campo obligatorio"),
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _repPassword,
                  obscureText: _isRepPasswordObscure,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Repita la contraseña",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_isRepPasswordObscure
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isRepPasswordObscure = !_isRepPasswordObscure;
                        });
                      },
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 16,
                ),
                DropdownMenu<String>(
                  width: 380,
                  enableFilter: true,
                  requestFocusOnTap: true,
                  label: const Text("Ciudad de residencia"),
                  onSelected: (String? city){
                    setState(() {
                      _city = city;
                    });
                  },
                  dropdownMenuEntries: _cities.map<DropdownMenuEntry<String>>((String city){
                    return DropdownMenuEntry<String>(value: city, label: city);
                  }).toList(),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Seleccione su género",
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: const Text("Masculino"),
                        value: Genre.male,
                        groupValue: _genre,
                        onChanged: (Genre? value) {
                          setState(() {
                            _genre = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text("Femenino"),
                        value: Genre.female,
                        groupValue: _genre,
                        onChanged: (Genre? value) {
                          setState(() {
                            _genre = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Géneros literarios favoritos",
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text("Acción"),
                        value: _isActionFavorite,
                        selected: _isActionFavorite,
                        onChanged: (bool? value) {
                          setState(() {
                            _isActionFavorite = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text("Aventura"),
                        value: _isAdventureFavorite,
                        selected: _isAdventureFavorite,
                        onChanged: (bool? value) {
                          setState(() {
                            _isAdventureFavorite = value!;
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
                        title: const Text("Ficción"),
                        value: _isFictionFavorite,
                        selected: _isFictionFavorite,
                        onChanged: (bool? value) {
                          setState(() {
                            _isFictionFavorite = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text("Suspenso"),
                        value: _isSuspenseFavorite,
                        selected: _isSuspenseFavorite,
                        onChanged: (bool? value) {
                          setState(() {
                            _isSuspenseFavorite = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: (){
                    _showSelectDate();
                  },
                  child: Text(buttonMsg)
                ),
                ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    onPressed: () {
                      _onRegisterButtonClicked();
                    },
                    child: const Text("Registrar"))
              ],
            ),
          ),
        ),
      ),
    );
  }


}

extension on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
