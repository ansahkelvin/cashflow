import 'package:budget/controller/bottom_nav.dart';
import 'package:budget/pages/register.dart';
import 'package:budget/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  final key = GlobalKey<FormState>();

  Future<void> loginUser() async {
    try {
      if (key.currentState!.validate()) {
        key.currentState!.save();
        setState(() {
          isLoading = true;
        });
        await Provider.of<FirebaseProvider>(context, listen: false).signInUser(
          email: emailController.text,
          password: passwordController.text,
        );
        if (!mounted) return;

        Navigator.of(context).pushReplacementNamed(
          BottomNavigator.routeName,
        );
      }
      setState(() {
        isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: SvgPicture.asset("assets/login.svg"),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Welcome to CashFlow",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Enter your credentials to continue",
                  style: TextStyle(color: Colors.black87),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: ((value) =>
                      value!.isEmpty ? "Cannot be empty" : null),
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  validator: ((value) =>
                      value!.isEmpty ? "Cannot be empty" : null),
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff174123),
                    minimumSize: Size(
                      MediaQuery.of(context).size.width,
                      50,
                    ),
                  ),
                  onPressed: loginUser,
                  child: Text(
                    isLoading ? "Logging in" : "Login",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: const Color(0xff174123)),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: const Text("Don't have an account ? Sign up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
