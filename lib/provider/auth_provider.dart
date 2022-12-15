import 'package:budget/model/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AuthBase {}

class FirebaseProvider with ChangeNotifier {
  List transactionList = [];

  String? name;
  String? email;
  double? balance;
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
    final newAmount = balance! + double.parse(amount);
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

  Future<void> fetchTransactions() async {
    await firestore
        .collection("users/${currentUser!.uid}/transactions")
        .withConverter(
            fromFirestore: (snapshot, _) =>
                TransactionModel.fromJson(snapshot.data()!),
            toFirestore: (transaction, _) => transaction.toJson())
        .get();
  }

  Future<void> getUserData() async {
    final snapshot = await firestore.doc("users/${currentUser!.uid}").get();
    final data = snapshot.data() as Map<String, dynamic>;
    name = data["name"];
    email = data["email"];
    balance = data["balance"];
    notifyListeners();
  }

  

  
}
