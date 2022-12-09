import 'package:flutter/material.dart';
import 'package:flutter_application_2/views/profile_page.dart';

import 'package:flutter_application_2/views/search.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'homepage.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedIndex = 0;
  final screens = [
    const HomePageWidget(),
    const Center(child: Text('likes', style: TextStyle(fontSize: 50))),
    const Search(),
    // const Center(child: Text('profile', style: TextStyle(fontSize: 50))),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: GNav(
          onTabChange: (index) => setState(() => selectedIndex = index),
          rippleColor:
              Colors.grey.shade800, // tab button ripple color when pressed
          tabBorderRadius: 10,
          curve: Curves.easeInOut, //animation when an icon is clicked
          gap: 6, // the tab button gap between icon and text
          color: Colors.lightBlue[800], // unselected icon color
          activeColor: Colors.white, // selected icon and text color
          iconSize: 30,
          // tab button icon size
          tabBackgroundColor: const Color.fromARGB(255, 45, 133, 233)
              .withOpacity(0.5), // selected tab background color

          padding: const EdgeInsets.symmetric(
              horizontal: 15, vertical: 10), // navigation bar padding
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.heart,
              text: 'Likes',
            ),
            GButton(
              icon: LineIcons.search,
              text: 'Search',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Profile',
            )
          ]),
    );
  }
}