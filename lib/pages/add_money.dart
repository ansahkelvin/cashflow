import 'package:budget/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({super.key});

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  final amountController = TextEditingController();
  final sourceController = TextEditingController();
  final key = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    amountController.dispose();
    sourceController.dispose();
    super.dispose();
  }

  bool validate() {
    if (key.currentState!.validate()) {
      key.currentState!.save();

      return true;
    }
    return false;
  }

  Future<void> addMoney() async {
    final provider = Provider.of<FirebaseProvider>(context, listen: false);
    if (validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await provider.setBalance(amountController.text);
        await provider.getUserData();
        await provider.addTransaction(
            amountController.text, sourceController.text, "add");
        setState(() {
          isLoading = false;
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Added successfully"),
          ),
        );
        if (!mounted) return;
        Navigator.of(context).pop();
      } on FirebaseException catch (e) {
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
    final provider = Provider.of<FirebaseProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        backgroundColor: Colors.red,
        onRefresh: () async {
          return await provider.getUserData();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: Form(
            key: key,
            child: ListView(
              children: [
                const Text(
                  "Your balance",
                  style: TextStyle(
                    color: Color(0xffB2B2B2),
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "GHC ${provider.balance}",
                  style: const TextStyle(
                    color: Color(0xff181818),
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                TextFormField(
                  validator: ((value) =>
                      value!.isEmpty ? "Cannot be empty" : null),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter Amount",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: ((value) =>
                      value!.isEmpty ? "Cannot be empty" : null),
                  controller: sourceController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Source of Income",
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff174123),
                    minimumSize: Size(
                      MediaQuery.of(context).size.width,
                      50,
                    ),
                  ),
                  onPressed: addMoney,
                  child: Text(
                    isLoading ? "Processing" : "Add Money",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
