import 'package:budget/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackExpense extends StatefulWidget {
  const TrackExpense({super.key});

  @override
  State<TrackExpense> createState() => _TrackExpenseState();
}

class _TrackExpenseState extends State<TrackExpense> {
  final amountController = TextEditingController();
  final itemController = TextEditingController();
  DateTime? _date;

  pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    );

    if (pickedDate != null) {
      // setState(() {
      //   _date = pickedDate;
      // });
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
                controller: itemController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Item title",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
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
                  Text("${_date ?? "Selected Date"}"),
                  IconButton(
                      onPressed: pickDate(),
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
                onPressed: () async {
                  await provider.setBalance(amountController.text);
                  await provider.getUserData();
                },
                child: const Text(
                  "Add Money",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
