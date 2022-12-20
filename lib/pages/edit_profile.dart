import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final nameController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    final provider = Provider.of<FirebaseProvider>(context, listen: false);
    nameController.text = provider.name!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseProvider>(context);

    return Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.person_outline,
            ),
            hintText: "Full name",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          initialValue: provider.email,
          readOnly: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.mail,
            ),
            hintText: "Email",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          readOnly: true,
          obscureText: true,
          initialValue: "password",
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.lock_outline,
            ),
            hintText: "Password",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () async {
            setState(() {
              isLoading = true;
            });
            await provider.editUserData(nameController.text);
            await provider.getUserData();
            setState(() {
              isLoading = false;
            });
          },
          child: Container(
            height: 53,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xff0B1116),
            ),
            child: Center(
              child: Text(
                isLoading ? "Saving Changes" : "Save",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
