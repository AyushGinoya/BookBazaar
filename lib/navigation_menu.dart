import 'package:bookbazaar/Helper/constant.dart';
import 'package:bookbazaar/Helper/navigation_icon_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationIconController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          elevation: 0,
          height: 80,
          indicatorColor: kBackgroundColor,
          selectedIndex: controller.selectIndex.value,
          onDestinationSelected: (index) {
            controller.selectIndex.value = index;
          },
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              selectedIcon: Icon(Icons.home, color: Colors.white),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.add),
              selectedIcon: Icon(Icons.add, color: Colors.white),
              label: 'Add',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              selectedIcon:
                  Icon(Icons.shopping_cart_outlined, color: Colors.white),
              label: 'Cart',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_box_sharp),
              selectedIcon: Icon(Icons.account_box_sharp, color: Colors.white),
              label: 'Profile',
            ),
          ],
        ),
      ),
      // Display the selected screen
      body: Obx(() => controller.screens.isNotEmpty
          ? controller.screens[controller.selectIndex.value]
          : const CircularProgressIndicator()),
    );
  }
}
