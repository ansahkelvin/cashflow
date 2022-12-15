import 'package:budget/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
          child: Column(children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.6,
              child: SvgPicture.asset("assets/bro.svg"),
            ),
            const Text(
              "Welcome to CashFlow",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Cashflow is a  mobile application that helps users manage their personal finances by tracking their income and expenses. By using this app, individuals can gain greater control over their spending and improve their financial situation.",
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 70,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff174123),
                minimumSize: Size(
                  MediaQuery.of(context).size.width,
                  50,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RegisterPage()));
              },
              child: const Text(
                "Get Started",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
