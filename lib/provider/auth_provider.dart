import 'package:budget/model/blog.dart';
import 'package:budget/model/expense.dart';
import 'package:budget/model/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/budget.dart';

class AuthBase {}

class FirebaseProvider with ChangeNotifier {
  List<TransactionModel> transactionList = [];
  List<Expense> expenseList = [];
  List<Budget> budgetList = [];

  List<Blog> blogList = [];

  TransactionModel transaction =
      TransactionModel(amount: "", date: "", source: "", time: "", type: "");
  Expense expense = Expense(title: "", amount: "", date: "");
  Budget budget = Budget(id: "", title: "", amount: "", date: "");

  Blog blog = Blog(id: "", title: "", description: "", imgUrl: "");

  String? name;
  String? email;
  String? balance;
  String? userId;

  final firebase = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  get firebaseUser => firebase.authStateChanges();

  get username => name;
  get useremail => email;
  get userbalance => balance;
  get getTransactions => transactionList;

  Future<void> signInUser(
      {required String email, required String password}) async {
    final user = await firebase.signInWithEmailAndPassword(
        email: email, password: password);
    userId = user.user!.uid;
    notifyListeners();
  }

  Future<void> signup(
      {required String email,
      required String password,
      required String name}) async {
    final user = await firebase.createUserWithEmailAndPassword(
        email: email, password: password);
    userId = user.user!.uid;
    firestore.doc("users/${user.user!.uid}").set({
      "name": name,
      "email": email,
      "balance": 0.0,
    });
    notifyListeners();
  }

  Future<void> setBalance(String amount) async {
    final newAmount = double.parse(balance!) + double.parse(amount);
    await firestore.doc("users/${currentUser!.uid}").update({
      "balance": newAmount,
    });
    notifyListeners();
  }

  Future<void> setDeductBalance(String amount) async {
    final newAmount = double.parse(balance!) - double.parse(amount);
    await firestore.doc("users/${currentUser!.uid}").update({
      "balance": newAmount,
    });
    notifyListeners();
  }

  Future<void> addTransaction(String amount, String source, String type) async {
    await firestore.collection("users/${currentUser!.uid}/transactions").add({
      "amount": amount,
      "source": source,
      "type": type,
      "date": DateFormat.yMMMEd().format(DateTime.now()),
      "time": DateFormat.j().format(DateTime.now()),
    });
    notifyListeners();
  }

  Future<TransactionModel> fetchTransactions() async {
    final snapshots = await firestore
        .collection("users/${currentUser!.uid}/transactions")
        .orderBy('date', descending: true)
        .get();
    final data = snapshots.docs
        .map((doc) => TransactionModel(
              date: doc.data()["date"],
              amount: doc.data()["amount"],
              source: doc.data()["source"],
              time: doc.id,
              type: doc.data()["type"],
            ))
        .toList();
    transactionList = data;
    notifyListeners();
    return transaction;
  }

  Future<void> addExpense(String amount, String item, String date) async {
    await firestore.collection("users/${currentUser!.uid}/expenses").add({
      "amount": amount,
      "itemTitle": item,
      "date": date,
    });
    notifyListeners();
  }

  Future<Expense> fetchExpense() async {
    final snapshot =
        await firestore.collection("users/${currentUser!.uid}/expenses").get();
    final data = snapshot.docs
        .map((doc) => Expense(
              title: doc.data()["itemTitle"],
              amount: doc.data()["amount"],
              date: doc.data()["date"],
            ))
        .toList();

    expenseList = data;
    notifyListeners();
    return expense;
  }

  Future<void> addBudget(String amount, String item, String date) async {
    await firestore.collection("users/${currentUser!.uid}/budget").add({
      "amount": amount,
      "itemTitle": item,
      "date": date,
    });
    notifyListeners();
  }

  Future<Budget> fetchBudget() async {
    final snapshot =
        await firestore.collection("users/${currentUser!.uid}/budget").get();
    final data = snapshot.docs
        .map((doc) => Budget(
              id: doc.id,
              title: doc.data()["itemTitle"],
              amount: doc.data()["amount"],
              date: doc.data()["date"],
            ))
        .toList();

    budgetList = data;
    notifyListeners();
    return budget;
  }

  Future<Blog> fetchBlogs() async {
    final snapshots = await firestore.collection("blog").get();
    final data = snapshots.docs
        .map((doc) => Blog(
              id: doc.id,
              title: doc.data()["title"],
              imgUrl: doc.data()["imgUrl"],
              description: doc.data()["description"],
            ))
        .toList();
    blogList = data;
    notifyListeners();
    return blog;
  }

  Future<void> deleteBudget(String id) async {
    await firestore
        .collection("users/${currentUser!.uid}/budget")
        .doc(id)
        .delete();
    notifyListeners();
  }

  Future<void> getUserData() async {
    try {
      final snapshot = await firestore.doc("users/${currentUser!.uid}").get();
      final data = snapshot.data() as Map<String, dynamic>;
      name = data["name"];
      email = data["email"];
      balance = data["balance"].toString();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editUserData(String name) async {
    await firestore.doc("users/${currentUser!.uid}").update({
      "name": name,
    });

    notifyListeners();
  }
}
