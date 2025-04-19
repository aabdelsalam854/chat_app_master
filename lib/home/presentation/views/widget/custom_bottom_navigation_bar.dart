import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final List<BottomNavigationBarItem> items;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      currentIndex: selectedIndex,
      // selectedItemColor: AppColors.green,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      // selectedLabelStyle: AppTextStyles.font11RobotoGrey,
      // unselectedLabelStyle: AppTextStyles.font11RobotoGrey,
      onTap: onItemTapped,
    );
  }
}
