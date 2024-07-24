import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/providers/user_provider.dart';
import 'package:task_management/src/constants/colors.dart';
import 'package:task_management/src/constants/sizes.dart';
import 'package:task_management/src/features/screens/profile_screen/update_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(100),
          child: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
              const SizedBox(
                height: 10,
              ),
              Text(
                userProvider.user.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const UpdateProfile();
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tPrimaryColor,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: tDarkColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: tAccentColor.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.email_outlined,
                    color: tAccentColor,
                  ),
                ),
                title: Text(
                  userProvider.user.email,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: tAccentColor.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.numbers,
                    color: tAccentColor,
                  ),
                ),
                title: Text(
                  userProvider.user.phoneNumber,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: tAccentColor.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.password,
                    color: tAccentColor,
                  ),
                ),
                title: Text(
                  "**********",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: tAccentColor.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.star_outline_sharp,
                    color: tAccentColor,
                  ),
                ),
                title: Text(
                  userProvider.user.position,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
