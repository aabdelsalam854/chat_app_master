import 'package:chat_master/features/home/presentation/pages/home_page.dart';
import 'package:chat_master/features/stories/presentation/pages/stories.dart';
import 'package:chat_master/home/presentation/views/widget/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomePage(),
    const StatusScreen(),
    const HomePage(),
    const HomePage(),
    // Payment(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],

        // body: IndexedStack(
        //   index: _selectedIndex,
        //   children: _screens,
        // ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.message_outlined, size: 30),
              label: "Messages",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.flip_camera_android_outlined, size: 30),
              label: "stories",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.groups_2_outlined, size: 30),
              label: "groups",
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.call, size: 30),
              label: "calls",
            ),
          ],
        ));
  }
}
