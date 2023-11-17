import 'dart:convert';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../common/page_header.dart';
import '../common/page_heading.dart';
import '../user/login_page.dart';
import 'package:http/http.dart' as http;
import '../common/custom_form_button.dart';
import '../common/custom_input_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


  final _signupFormKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String number = '';
  String password = '';
  String address = '';


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String _baseUrl = "http://10.0.2.2:8000"; // Add the protocol

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEEF1F3),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const PageHeader(),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const PageHeading(title: 'Devenir membre de AmiAnimaux'),
                      const SizedBox(height: 16,),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nom',
                          hintText: 'Your name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Le champ Nom est obligatoire';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          name = value ?? '';
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Your email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Le champ Email est obligatoire';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Veuillez entrer une adresse email valide';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          email = value ?? '';
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Number',
                          hintText: 'Your Number',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Le champ Num est obligatoire';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          number = value ?? '';
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Adresse',
                          hintText: 'Your Address',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Le champ Adresse est obligatoire';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          address = value ?? '';
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Your Password',
                          suffixIcon: Icon(Icons.visibility_off),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Le champ Password est obligatoire';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          password = value ?? '';
                        },
                      ),
                      // ... (other input fields)
                      CustomFormButton(
                        innerText: 'Sign up',
                        onPressed: () {
                          if(_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            print('Sending signup request');
                            print('User data: $_signupFormKey');

                            Map<String, dynamic> userData = {
                              "email" : email,
                              "password" : password.toString(),
                              "name": name,
                              "number" : number,
                              "address" : address
                            };

                            Map<String, String> headers = {
                              "Content-Type": "application/json; charset=UTF-8"
                            };

                            http.post(Uri.parse("$_baseUrl/user/signup"), headers: headers, body: json.encode(userData))

                                .then((http.Response response) {
                              print('Response status code: ${response.statusCode}');
                              if(response.statusCode == 200) {
                                Navigator.pushReplacementNamed(context, "/");
                              }
                              else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const AlertDialog(
                                        title: Text("Information"),
                                        content: Text("Une erreur s'est produite. Veuillez réessayer !"),
                                      );

                                    });
                              }
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 30,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}