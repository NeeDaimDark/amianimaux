import 'package:amianimauxx/race/racehome.dart';
import 'package:amianimauxx/reservation/agenda.dart';
import 'package:amianimauxx/user/forget_password_page.dart';
import 'package:amianimauxx/user/login_page.dart';
import 'package:amianimauxx/user/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'animal/animalhome.dart';
import 'navigations/nav_bottom.dart';
import 'navigations/nav_tab.dart';
import 'reservation/reservermeeting.dart';
import 'user/update_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString("userId") ?? ""; // Retrieve userId from SharedPreferences

  runApp(MyApp(userId: userId)); // Pass userId to MyApp
}

class MyApp extends StatelessWidget {
  final String userId;

  const MyApp({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'amianimaux',
        onGenerateRoute: (settings) {
          if (settings.name == "/reserver") {
            // Extract the DateTime from settings.arguments if available
            final DateTime selectedDateTime = settings.arguments as DateTime;
            return MaterialPageRoute(
              builder: (context) => ReserverMeet(selectedDateTime),
            );
          }
        },
      routes: {
        "/": (BuildContext context) => LoginPage(),
        "/home": (BuildContext context) => Rhome(userId: userId), // Pass userId here
        "/homeTab": (BuildContext context) => NavTab(userId: userId), // Pass userId here
        "Ahome": (BuildContext context) => Ahome(),
        "/signup": (BuildContext context) => SignupPage(),
        "/resetPwd": (BuildContext context) => ForgetPasswordPage(),
        "/homeBottom": (BuildContext context) => NavBottom(userId: userId), // Pass userId here
        "/agenda":(BuildContext context) => Agenda(),
        "/home/updateUser": (BuildContext context) => UpdateUserPage(),
      },
    );
  }
}
