import 'package:budget/controller/bottom_nav.dart';
import 'package:budget/pages/check_user_logged_In.dart';
import 'package:budget/pages/login.dart';
import 'package:budget/pages/register.dart';
import 'package:budget/provider/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FirebaseProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme(context),
        home: const CheckUser(),
        routes: {
          BottomNavigator.routeName: (BuildContext context) =>
              const BottomNavigator(),
          LoginPage.routeName: (BuildContext context) => const LoginPage(),
          RegisterPage.routeName: (context) => const RegisterPage(),
          CheckUser.routeName: (context) => const CheckUser(),
        },
      ),
    );
  }
}

ThemeData theme(BuildContext context) {
  return ThemeData(
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      iconTheme: const IconThemeData(color: Colors.black),
      actionsIconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
