import 'package:eazy/core/config/app_palette.dart';
import 'package:eazy/features/home/presentation/Screens/home.dart';
import 'package:eazy/features/myLessons/presentation/screens/myLessons_screen.dart';
import 'package:eazy/features/profile/presentation/presentation/screen/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';


class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key, this.initialIndex = 1});
  final int initialIndex;

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late int _currentIndex; // Start with home selected

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // ابدأ بالـ index اللي جاي من بره
  }

  final iconList = <IconData>[Icons.menu_book_outlined, Icons.person_rounded];

  final labels = ['دروسي', 'الرئيسية', 'حسابي'];

  final List<Widget> _pages = [
    const MyLessonsScreen(),
    const HomeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      backgroundColor: Colors.grey[100],
      body: IndexedStack(index: _currentIndex, children: _pages),
      floatingActionButton: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == 1 ? AppPalette.badgeButton : Colors.black,
          boxShadow: [
            BoxShadow(
              color:
                  (_currentIndex == 1 ? AppPalette.badgeButton : Colors.black)
                      .withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.home, size: 30, color: Colors.white),
          onPressed: () {
            setState(() {
              _currentIndex = 1;
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (index, isActive) {
          int actualIndex = index == 0 ? 0 : 2;
          bool isCurrentActive = _currentIndex == actualIndex;

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                color: isCurrentActive ? AppPalette.badgeButton : Colors.black,
              ),
              Text(
                labels[actualIndex],
                style: TextStyle(
                  color: isCurrentActive
                      ? AppPalette.badgeButton
                      : Colors.black,
                ),
              ),
            ],
          );
        },
        activeIndex: _getActiveIndex(),
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) {
          setState(() {
            _currentIndex = index == 0 ? 0 : 2;
          });
        },
      ),
    );
  }

  int _getActiveIndex() {
    if (_currentIndex == 1) return -1;
    return _currentIndex == 0 ? 0 : 1;
  }
}
