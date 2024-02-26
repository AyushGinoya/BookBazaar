import 'dart:developer';

import 'package:bookbazaar/Helper/constant.dart';
import 'package:bookbazaar/Models/user_model.dart';
import 'package:bookbazaar/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  Future<void> createUser() async {
    UserModel user = UserModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      name: nameController.text.trim(),
      phone: numberController.text.trim(),
    );

    var userData = user.toJson();

    var url = Uri.parse('http://10.0.2.2:3000/signup');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      log("hello");
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NavigationMenu()));
    } else {
      throw Exception('Failed to create user. Error: ${response.body}');
    }
  }

  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_rounded)),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Register",
                            style: kHeadline,
                          ),
                          const Text(
                            "Create new account to get started.",
                            style: kBodyText2,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          // Name TextField
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20),
                              hintText: 'Name',
                              hintStyle: kBodyText,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            keyboardType: TextInputType.name,
                            style: kBodyText.copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Email TextField
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20),
                              hintText: 'Email',
                              hintStyle: kBodyText,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: kBodyText.copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Phone TextField
                          TextField(
                            controller: numberController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20),
                              hintText: 'Phone',
                              hintStyle: kBodyText,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            style: kBodyText.copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Password TextField
                          TextField(
                            controller: passwordController,
                            obscureText: passwordVisibility,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20),
                              hintText: 'Password',
                              hintStyle: kBodyText,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordVisibility
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    passwordVisibility = !passwordVisibility;
                                  });
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            style: kBodyText.copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () async {
                                  try {
                                    await createUser();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const NavigationMenu()));
                                  } catch (e) {
                                    print("Failed to create user: $e");
                                  }
                                },
                                child: const Text('Register'),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black87,
                                  backgroundColor: Colors.white,
                                ),
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
          ],
        ),
      ),
    );
  }
}
