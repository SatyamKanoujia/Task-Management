// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_management/models/user.dart';
import 'package:task_management/providers/user_provider.dart';
import 'package:task_management/src/constants/error_handling.dart';
import 'package:task_management/src/constants/text_string.dart';
import 'package:task_management/src/constants/utils.dart';
import 'package:task_management/src/features/screens/home_screen/home.dart';

class AuthService {
  int getPositionLevel(String position) {
    const positionLevels = {
      'Executive Director': 1,
      'Chief General Manager': 2,
      'General Manager': 3,
      'Deputy General Manager': 4,
      'Manager': 5,
      'Assistant Manager': 6,
    };

    return positionLevels[position] ?? 7;
  }

  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required String position,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        password: password,
        position: position,
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              contentType: ContentType.success,
              title: 'Congratulations!',
              message: 'Your account has been cretated.',
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  //sign in
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const HomeScreen();
            }),
          );
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  // get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  // update user profile
  Future<bool> updateUserProfile(BuildContext context, User user) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      final response = await http.put(
        Uri.parse('$uri/api/updateProfile'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token ?? '',
        },
        body: user.toJson(),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {},
        );
        return false;
      }
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
      return false;
    }
  }

  // get all users
  Future<List<User>> getAllUsers(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<User> userList = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/users'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          int currentUserLevel = getPositionLevel(userProvider.user.position);

          for (var userMap in jsonDecode(res.body)) {
            User user = User.fromMap(userMap);
            int userLevel = getPositionLevel(user.position);
            if (user.id != userProvider.user.id &&
                userLevel > currentUserLevel) {
              userList.add(user);
            }
          }

          // Sort users by their position level
          userList.sort(
            (a, b) => getPositionLevel(a.position).compareTo(
              getPositionLevel(
                b.position,
              ),
            ),
          );
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    return userList;
  }
}
