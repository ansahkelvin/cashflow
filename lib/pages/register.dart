import 'package:budget/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../controller/bottom_nav.dart';
import '../provider/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const String routeName = "/register";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  bool isLoading = false;
  final key = GlobalKey<FormState>();

  Future<void> signup() async {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      try {
        setState(() {
          isLoading = true;
        });
        await Provider.of<FirebaseProvider>(context, listen: false).signup(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text);
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed(
          BottomNavigator.routeName,
        );
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
          child: Form(
            key: key,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                child: SvgPicture.asset("assets/signup.svg"),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Welcome to CashFlow",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter your credentials to proceed",
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: ((value) =>
                    value!.isEmpty ? "Cannot be empty" : null),
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Full name",
                  border: OutlineInputBorder(),
                ),
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
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff174123),
                  minimumSize: Size(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                ),
                onPressed: signup,
                child: Text(
                  isLoading ? "Processing" : "Register",
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
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Text("Already having an account ? Sign in"),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
