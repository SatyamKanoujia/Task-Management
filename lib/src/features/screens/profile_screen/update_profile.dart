// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/models/user.dart';
import 'package:task_management/providers/user_provider.dart';
import 'package:task_management/src/constants/colors.dart';
import 'package:task_management/src/constants/sizes.dart';
import 'package:task_management/src/features/services/auth_services.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _positionController;

  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    _nameController = TextEditingController(text: user.name);
    _passwordController = TextEditingController(text: "");
    _phoneNumberController = TextEditingController(text: user.phoneNumber);
    _positionController = TextEditingController(text: user.position);
    dropdownValue = user.position;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  void updateUserProfile() async {
    if (_formKey.currentState!.validate()) {
      final user = Provider.of<UserProvider>(context, listen: false).user;
      User updatedUser = User(
        id: user.id,
        name: _nameController.text,
        password: _passwordController.text,
        phoneNumber: _phoneNumberController.text,
        position: dropdownValue,
        email: user.email,
        token: user.token,
      );

      bool success =
          await AuthService().updateUserProfile(context, updatedUser);
      if (success) {
        Provider.of<UserProvider>(context, listen: false)
            .setUserFromModel(updatedUser);
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.success,
            title: 'Done!',
            message: 'Profile Updated Successfully!',
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            contentType: ContentType.failure,
            title: 'Oops!',
            message: 'Failed to update Profile!',
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }

  final List<String> items = [
    'Executive Director',
    'Chief General Manager',
    'General Manager',
    'Deputy General Manager',
    'Manager',
    'Assistant Manager',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: "Full Name",
                        prefixIcon: Icon(Icons.person_2_outlined),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your name' : null,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: "Old/New Password",
                        prefixIcon: Icon(Icons.password_sharp),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your password' : null,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon: Icon(Icons.numbers),
                      ),
                      validator: (value) => value!.isEmpty
                          ? 'Please enter your phone number'
                          : null,
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 1, vertical: 1),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      child: DropdownButton<String>(
                        focusColor: Colors.black,
                        alignment: Alignment.center,
                        isExpanded: true,
                        value: dropdownValue,
                        style: const TextStyle(color: Colors.black),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconEnabledColor: Colors.black,
                        items: items.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: updateUserProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tPrimaryColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          "Update Profile",
                          style: TextStyle(color: tDarkColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
