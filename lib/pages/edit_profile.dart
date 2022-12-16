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
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FirebaseProvider>(context);

    return Column(
      children: [
        TextFormField(
          initialValue: provider.name,
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
          onTap: () {},
          child: Container(
            height: 53,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xff0B1116),
            ),
            child: const Center(
              child: Text(
                "Save",
                style: TextStyle(
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
