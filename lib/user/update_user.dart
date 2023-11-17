import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../navigations/nav_tab.dart';
class UpdateUserPage extends StatefulWidget {
  const UpdateUserPage({Key? key}) : super(key: key);

  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final _updateFormKey = GlobalKey<FormState>();
  String name = '';
  String number = '';
  String password = '';
  String email = '';
  String address = '';

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final String _baseUrl = "10.0.2.2:8000";


  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final userId = arguments['userId'];
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Update User'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _updateFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GenericInputFormField(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value ?? '';
                  },
                ),
                const SizedBox(height: 16),
                GenericInputFormField(
                  labelText: 'Number',
                  hintText: 'Enter your number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Number is required';
                    }
                    // You can add additional validation for the number if needed
                    return null;
                  },
                  onSaved: (value) {
                    number = value ?? '';
                  },
                ),
                const SizedBox(height: 16),
                GenericInputFormField(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    // You can add additional validation for the password if needed
                    return null;
                  },
                  onSaved: (value) {
                    password = value ?? '';
                  },
                ),
                const SizedBox(height: 16),
                GenericInputFormField(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    // You can add additional validation for the email if needed
                    return null;
                  },
                  onSaved: (value) {
                    email = value ?? '';
                  },
                ),
                const SizedBox(height: 16),
                GenericInputFormField(
                  labelText: 'Address',
                  hintText: 'Enter your address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address is required';
                    }
                    // You can add additional validation for the address if needed
                    return null;
                  },
                  onSaved: (value) {
                    address = value ?? '';
                  },
                ),
                const SizedBox(height: 20),
                CustomFormButton(
                  innerText: 'Save',
                    onPressed: () {
                      if (_keyForm.currentState != null && _keyForm.currentState!.validate()) {

                        _keyForm.currentState!.save();

                        Map<String, dynamic> userData = {
                          "name" : name,
                          "email" : email,
                          "password" : password,
                          "address" : address,
                          "number" : number
                        };

                        Map<String, String> headers = {
                          "Content-Type": "application/json; charset=UTF-8"
                        };

                        http.put(Uri.http(_baseUrl, "/user/$userId"), headers: headers, body: json.encode(userData))
                            .then((http.Response response) {
                          if(response.statusCode == 200) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NavTab(userId: userId),
                              ),
                            );
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
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveUpdatedUserInfo() {
    // Implement logic to save updated user information
    // You can use the values of name, number, password, email, and address here
    print('Updating user information:');
    print('Name: $name');
    print('Number: $number');
    print('Password: $password');
    print('Email: $email');
    print('Address: $address');
    // Add your logic to update the user information in your system
  }
}

class GenericInputFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final Function(String?) validator;
  final Function(String?) onSaved;

  const GenericInputFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    required this.validator,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
        obscureText: obscureText,
        validator: (value) => validator(value),
        onSaved: (value) => onSaved(value),
      ),
    );
  }
}

class CustomFormButton extends StatelessWidget {
  final String innerText;
  final void Function()? onPressed;
  const CustomFormButton({Key? key, required this.innerText, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xff008000),
        borderRadius: BorderRadius.circular(26),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(innerText, style: const TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }
}
