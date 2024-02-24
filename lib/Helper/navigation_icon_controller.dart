import 'package:bookbazaar/Screens/add_book_page.dart';
import 'package:bookbazaar/Screens/cart_page.dart';
import 'package:bookbazaar/Screens/home_page.dart';
import 'package:bookbazaar/Screens/profile_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NavigationIconController extends GetxController {
  final Rx<int> selectIndex = 0.obs;
  RxList<Widget> screens = RxList<Widget>([]);

  @override
  void onInit() {
    super.onInit();
    fetchUserModelAndSetupScreens();
  }

  void fetchUserModelAndSetupScreens() async {
    screens.value = const [
      Home(),
      AddBook(),
      Cart(),
      Profile(),
    ];
  }
}
