import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mis_libros/pages/register_page.dart';
import 'package:mis_libros/repository/firebase_api.dart';

import 'navigation_bar_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseApi _firebaseApi = FirebaseApi();

  final _email = TextEditingController();
  final _password = TextEditingController();

  //User user = User.Empty();

  void _showMsg(String msg) {
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

  /*void _saveSession() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isUserLogged", true);
  }*/

  void _signIn() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text);
    var result = await _firebaseApi.signInUser(_email.text, _password.text);
    if (result == 'invalid-credential') {
      _showMsg('Correo electrónico o contraseña incorrecta');
    } else if (result == 'invalid-email') {
      _showMsg('El correo electrónico está mal escrito');
    } else if (result == 'network-request-failed') {
      _showMsg('Revise su conexión a internet');
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const NavigationBarPage()));
    }
  }

  /*void _loadUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(prefs.getString("user")!);
    user = User.fromJson(userMap);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/logo.png'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Correo electrónico"),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Password"),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  _signIn();
                },
                child: const Text("Iniciar sesión"),
              ),
              const SizedBox(
                height: 8,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                  child: const Text('Registrarse'))
            ],
          ),
        ),
      ),
    );
  }
}
