import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../navigations/nav_tab.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String? _email;
  late String? _password;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final String _baseUrl = "10.0.2.2:8000";

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("S'authentifier"),
      ),
      body: Form(
        key: _keyForm,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Image.network(
                "http://10.0.2.2:8000/upload/images/chiens.jpeg",
                width: 460,
                height: 215,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Username",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your username",
                    ),
                    onSaved: (String? value) {
                      _email = value;
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Le username ne doit pas etre vide";
                      } else if (value.length < 5) {
                        return "Le username doit avoir au moins 5 caractères";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Mot de passe",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.remove_red_eye
                              : Icons.visibility_off_outlined,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      suffixIconConstraints: const BoxConstraints(
                        maxHeight: 33,
                      ),
                    ),
                    onSaved: (String? value) {
                      _password = value;
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Le mot de passe ne doit pas etre vide";
                      } else if (value.length < 5) {
                        return "Le mot de passe doit avoir au moins 5 caractères";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: const Color(0xff008000),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: TextButton(
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      _keyForm.currentState!.save();
                      Map<String, dynamic> userData = {
                        "email": _email,
                        "password": _password
                      };
                      Map<String, String> headers = {
                        "Content-Type": "application/json; charset=UTF-8"
                      };
                      http
                          .post(
                        Uri.http(_baseUrl, "/user/login"),
                        body: json.encode(userData),
                        headers: headers,
                      )
                          .then((http.Response response) async {
                        if (response.statusCode == 200) {
                          Map<String, dynamic> responseData =
                          json.decode(response.body);
                          String userId = responseData['userId'];
                          print(userId);
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          prefs.setString("userId", userId);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavTab(userId: userId),
                            ),
                          );
                        } else if (response.statusCode == 401) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title: Text("Information"),
                                content: Text(
                                    "Le username et/ou le mot de passe est incorrect"),
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title: Text("Information"),
                                content: Text(
                                    "Une erreur est survenue, veillez réessayer plus tard"),
                              );
                            },
                          );
                        }
                      });
                    }
                  },
                  child: Text(
                    "S'authentifier",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/signup");
                  },
                  child: const Text(
                    "Créer un compte",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Mot de passe oublié ?"),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/resetPwd");
                    },
                    child: const Text(
                      "Cliquez ici",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
