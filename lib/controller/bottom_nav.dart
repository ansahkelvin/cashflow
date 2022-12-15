import 'package:budget/pages/currency_conversion.dart';
import 'package:budget/pages/financial_news.dart';
import 'package:budget/pages/home_page.dart';
import 'package:budget/pages/profile.dart';
import 'package:budget/provider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});
  static const String routeName = "/nav";

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false).getUserData();
    Provider.of<FirebaseProvider>(context, listen: false).fetchTransactions();

    super.initState();
  }

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
              color: Color(0xff174123),
            ),
            icon: Icon(
              CupertinoIcons.home,
              color: Colors.grey,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon:
                Icon(CupertinoIcons.creditcard, color: Color(0xff174123)),
            icon: Icon(
              CupertinoIcons.creditcard,
              color: Colors.grey,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(CupertinoIcons.bookmark, color: Color(0xff174123)),
            icon: Icon(
              CupertinoIcons.bookmark,
              color: Colors.grey,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              CupertinoIcons.person,
              color: Color(0xff174123),
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
