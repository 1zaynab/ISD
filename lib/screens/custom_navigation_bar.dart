/*
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../pages/community_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../pages/search_page.dart';
import '../selected_category/selected_categories.dart';
import 'app_drawer.dart';

class CustomNavigationBar extends StatefulWidget {
  final List<String> selectedCategories;

  const CustomNavigationBar({super.key, required this.selectedCategories});

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;
  void updateSelectedCategories(List<String> categories) {
    Provider.of<SelectedCategories>(context, listen: false).setSelectedCategories(categories);
  }
  late final HomePage _homePage = HomePage();

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeState>(context);
    final List<Widget> pages = [
      _homePage,
       SearchPage(),
      const CommunityPage(),
      const ProfilePage(),
    ];
    final primaryColor = themeState.themeData.primaryColor;
    final iconColor = themeState.themeData.brightness == Brightness.dark ? Colors.white : primaryColor;



    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon:  Icon(
                Icons.notifications,
              color: themeState.themeData.brightness == Brightness.dark
                  ? Colors.white // Use white for dark theme
                  : Colors.black, // Use pinkAccent for light theme
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications'); // Navigate to the notifications page
            },
          ),
          IconButton(
            icon:  Icon(Icons.bookmark,
              color: themeState.themeData.brightness == Brightness.dark
                ? Colors.white // Use white for dark theme
                : Colors.black, // Use pinkAccent for light theme
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/saved'); // Navigate to the saved page
            },
          ),
        ],
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon:  Icon(Icons.menu,
                color: themeState.themeData.brightness == Brightness.dark
                    ? Colors.white // Use white for dark theme
                    : Colors.black, // Use pinkAccent for light theme
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: AppDrawer(themeState: Provider.of<ThemeState>(context),),
      body: pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: themeState.themeData,
        child: FlashyTabBar(
          selectedIndex: _selectedIndex,
          // Customizable properties (adjust as needed)
          showElevation: true,  // Show shadow under the bar
          height: 60.0,        // Adjust the bar's height
          iconSize: 24.0,       // Adjust the size of the icons
          animationDuration: const Duration(milliseconds: 170), // Control animation speed
          animationCurve: Curves.linear, // Choose animation curve (e.g., Curves.easeIn)
          backgroundColor: themeState.themeData.brightness == Brightness.dark ? Colors.grey[800] : Colors.grey[200],  // Set background color based on theme
          shadows: const [BoxShadow(color: Colors.black12, blurRadius: 3)], // Add shadows (optional)

          items: [
            FlashyTabBarItem(
              icon: Icon(Icons.home, color: iconColor),
              title: const Text('Home'),
              activeColor: primaryColor, // Use theme's primary color for active state
              inactiveColor: themeState.themeData.brightness == Brightness.dark
                  ? Colors.grey[700] ?? const Color(0xff9496c1) // Default for dark theme
                  : Colors.grey[400] ?? const Color(0xff9496c1), // Default for light theme // Set inactive color based on theme
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.search, color: iconColor),
              title: const Text('Search'),
              activeColor: primaryColor,
              inactiveColor: themeState.themeData.brightness == Brightness.dark
                  ? Colors.grey[700] ?? const Color(0xff9496c1) // Default for dark theme
                  : Colors.grey[400] ?? const Color(0xff9496c1), // Default for light theme
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.people, color: iconColor),
              title: const Text('Community'),
              activeColor: primaryColor,
              inactiveColor: themeState.themeData.brightness == Brightness.dark
                  ? Colors.grey[700] ?? const Color(0xff9496c1) // Default for dark theme
                  : Colors.grey[400] ?? const Color(0xff9496c1), // Default for light theme
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.person, color: iconColor),
              title: const Text('Profile'),
              activeColor: primaryColor,
              inactiveColor: themeState.themeData.brightness == Brightness.dark
                  ? Colors.grey[700] ?? const Color(0xff9496c1) // Default for dark theme
                  : Colors.grey[400] ?? const Color(0xff9496c1), // Default for light theme
            ),
          ],
          onItemSelected: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }
}*/

import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../pages/community_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../pages/search_page.dart';
import '../selected_category/selected_categories.dart';
import '../tweet_service.dart';
import 'app_drawer.dart';

class CustomNavigationBar extends StatefulWidget {
  final String title;
  final APIService apiService;

  const CustomNavigationBar({
    Key? key,
    required this.title,
    required this.apiService,
  }) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeState>(context);
    final List<Widget> pages = [
      HomePage(title: widget.title, apiService: widget.apiService),
      SearchPage(),
      const CommunityPage(),
      const ProfilePage(),
    ];
    final primaryColor = themeState.themeData.primaryColor;
    final iconColor = themeState.themeData.brightness == Brightness.dark
        ? Colors.white
        : primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: themeState.themeData.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.bookmark_added_outlined,
              color: themeState.themeData.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/saved');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.favorite_border_rounded,
              color: themeState.themeData.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/liked');
            },
          ),
        ],
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: themeState.themeData.brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: AppDrawer(themeState: Provider.of<ThemeState>(context)),
      body: pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: themeState.themeData,
        child: FlashyTabBar(
          selectedIndex: _selectedIndex,
          showElevation: true,
          height: 60.0,
          iconSize: 24.0,
          animationDuration: const Duration(milliseconds: 170),
          animationCurve: Curves.linear,
          backgroundColor: themeState.themeData.brightness == Brightness.dark
              ? Colors.grey[800]
              : Colors.grey[200],
          shadows: const [BoxShadow(color: Colors.black12, blurRadius: 3)],
          items: [
            FlashyTabBarItem(
              icon: Icon(Icons.home, color: iconColor),
              title: const Text('Home'),
              activeColor: primaryColor,
              inactiveColor:
              themeState.themeData.brightness == Brightness.dark
                  ? Colors.grey[700] ?? const Color(0xff9496c1)
                  : Colors.grey[400] ?? const Color(0xff9496c1),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.search, color: iconColor),
              title: const Text('Search'),
              activeColor: primaryColor,
              inactiveColor:
              themeState.themeData.brightness == Brightness.dark
                  ? Colors.grey[700] ?? const Color(0xff9496c1)
                  : Colors.grey[400] ?? const Color(0xff9496c1),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.people, color: iconColor),
              title: const Text('Community'),
              activeColor: primaryColor,
              inactiveColor:
              themeState.themeData.brightness == Brightness.dark
                  ? Colors.grey[700] ?? const Color(0xff9496c1)
                  : Colors.grey[400] ?? const Color(0xff9496c1),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.person, color: iconColor),
              title: const Text('Profile'),
              activeColor: primaryColor,
              inactiveColor:
              themeState.themeData.brightness == Brightness.dark
                  ? Colors.grey[700] ?? const Color(0xff9496c1)
                  : Colors.grey[400] ?? const Color(0xff9496c1),
            ),
          ],
          onItemSelected: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }
}
