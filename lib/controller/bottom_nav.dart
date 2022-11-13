import 'package:budget/pages/currency_conversion.dart';
import 'package:budget/pages/financial_news.dart';
import 'package:budget/pages/home_page.dart';
import 'package:budget/pages/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    HomePage(),
    CurrencyConversion(),
    FinancialNewsPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(
              CupertinoIcons.home,
              color: Color.fromARGB(157, 33, 149, 243),
            ),
            icon: Icon(
              CupertinoIcons.home,
              color: Colors.grey,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              CupertinoIcons.creditcard,
              color: Color.fromARGB(157, 33, 149, 243),
            ),
            icon: Icon(
              CupertinoIcons.creditcard,
              color: Colors.grey,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              CupertinoIcons.bookmark,
              color: Color.fromARGB(157, 33, 149, 243),
            ),
            icon: Icon(
              CupertinoIcons.bookmark,
              color: Colors.grey,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              CupertinoIcons.person,
              color: Color.fromARGB(157, 33, 149, 243),
            ),
            icon: Icon(
              CupertinoIcons.person,
              color: Colors.grey,
            ),
            label: "",
          )
        ],
      ),
    );
  }
}
