import 'package:budget/provider/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TrackExpense extends StatefulWidget {
  const TrackExpense({super.key});

  @override
  State<TrackExpense> createState() => _TrackExpenseState();
}

class _TrackExpenseState extends State<TrackExpense> {
  final amountController = TextEditingController();
  final itemController = TextEditingController();
  final key = GlobalKey<FormState>();
  DateTime? date = DateTime.now();
  bool isLoading = false;

  @override
  void dispose() {
    amountController.dispose();
    itemController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date!,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }

  bool validate() {
    if (key.currentState!.validate()) {
      key.currentState!.save();

      return true;
    }
    return false;
  }

  Future<void> expense() async {
    final provider = Provider.of<FirebaseProvider>(context, listen: false);
    if (validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await provider.setDeductBalance(amountController.text);
        await provider.addTransaction(
            amountController.text, itemController.text, "deduct");
        await provider.addExpense(amountController.text, itemController.text,
            DateFormat.yMMMEd().format(date!));
        await provider.getUserData();
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
                  controller: itemController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Item title",
                  ),
                ),
                const SizedBox(
                  height: 20,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(date != null
                        ? DateFormat.yMMMEd().format(DateTime.now())
                        : "Selected Date"),
                    IconButton(
                        onPressed: () => _selectDate(context),
                        icon: const Icon(Icons.calendar_month_outlined))
                  ],
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
                  onPressed: expense,
                  child: Text(
                    isLoading ? "Processing" : "Create Expense",
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
