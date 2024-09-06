import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Genre { male, female }

class _RegisterPageState extends State<RegisterPage> {
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      value!.isValidEmail() ? null : "Correo inválido",
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
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    onPressed: () {},
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
