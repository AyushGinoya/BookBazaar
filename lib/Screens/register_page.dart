import 'package:bookbazaar/Helper/constant.dart';
import 'package:bookbazaar/Widgets/my_password_field.dart';
import 'package:bookbazaar/Widgets/my_text_button.dart';
import 'package:bookbazaar/Widgets/my_text_field.dart';
import 'package:bookbazaar/navigation_menu.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                          const MyTextField(
                            hintText: 'Name',
                            inputType: TextInputType.name,
                          ),
                          const MyTextField(
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                          ),
                          const MyTextField(
                            hintText: 'Phone',
                            inputType: TextInputType.phone,
                          ),
                          MyPasswordField(
                            isPasswordVisible: passwordVisibility,
                            onTap: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: kBodyText,
                        ),
                        Text(
                          "Sign In",
                          style: kBodyText.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextButton(
                      buttonName: 'Register',
                      onTap: () {
                        Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationMenu()));
                      },
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                    )
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
