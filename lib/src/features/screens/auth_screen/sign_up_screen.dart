import 'package:flutter/material.dart';
import 'package:task_management/src/constants/text_string.dart';
import 'package:task_management/src/features/screens/auth_screen/sign_in_screen.dart';
import 'package:task_management/src/features/services/auth_services.dart';
import 'package:task_management/utils/theme/widget_themes/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthService authServices = AuthService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      authServices.signUpUser(
        context: context,
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        phoneNumber: phoneController.text,
        position: dropdownValue,
      );

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  String dropdownValue = 'Assistant Manager';

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
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/second.png'),
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF90CAF9),
                Color(0xFF64B5F6),
                Color(0xFF42A5F5),
              ],
            ),
          ),
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenSize.height / 1.5,
                      child: FittedBox(
                        child: Container(
                          height: screenSize.height / 1.4,
                          width: screenSize.width,
                          padding: const EdgeInsets.all(18),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const SignInScreen();
                                          },
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Text(
                                    "Hello!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 33,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              TextFieldWidget(
                                title: "Name",
                                controller: nameController,
                                obscureText: false,
                                hintText: "Enter your name",
                              ),
                              TextFieldWidget(
                                title: "Mobile Number",
                                controller: phoneController,
                                obscureText: false,
                                hintText: "Enter your Mobile Number",
                              ),
                              TextFieldWidget(
                                title: "Email",
                                controller: emailController,
                                obscureText: false,
                                hintText: "Enter your email",
                              ),
                              TextFieldWidget(
                                title: "Password",
                                controller: passwordController,
                                obscureText: true,
                                hintText: "Enter your password",
                              ),
                              const Text(
                                "Choose Your Position",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
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
                                    setState(
                                      () {
                                        dropdownValue = newValue!;
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return const SignInScreen();
                                            },
                                          ),
                                        );
                                      },
                                      child: const Text('Back To LogIn?'),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: isLoading ? null : signUpUser,
                                      child: isLoading
                                          ? const CircularProgressIndicator()
                                          : Text(tSingup.toUpperCase()),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
