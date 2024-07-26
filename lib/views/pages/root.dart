import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix/views/pages/home.dart';
import 'package:netflix/views/pages/profile.dart';
import 'package:netflix/views/pages/search.dart';
import 'package:remixicon/remixicon.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> body = [
      const Home(),
      const Search(),
      const Profile(),
      const SizedBox()
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Row(
            children: [
              NavigationRail(
                groupAlignment: 0.0,
                minWidth: 72,
                destinations: [
                  _buildNavigationRailDestination(
                    Remix.home_8_line,
                    "Home",
                  ),
                  _buildNavigationRailDestination(
                      Remix.search_2_fill, "Search"),
                  _buildNavigationRailDestination(Remix.list_ordered, "Saved"),
                  _buildNavigationRailDestination(
                      Remix.settings_2_fill, "Settings")
                ],
                labelType: NavigationRailLabelType.none,
                backgroundColor: Colors.black,
                selectedLabelTextStyle: const TextStyle(fontSize: 10),
                selectedIconTheme: const IconThemeData(color: Colors.white),
                selectedIndex: _index,
                useIndicator: true,
                indicatorColor: Colors.blue.withOpacity(0.2),
                indicatorShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onDestinationSelected: (index) {
                  setState(() {
                    _index = index;
                  });
                },
              ),
              Expanded(child: body[_index]),
            ],
          )),
    );
  }

  NavigationRailDestination _buildNavigationRailDestination(
      IconData icon, String label) {
    return NavigationRailDestination(
      icon: Icon(icon),
      selectedIcon: Icon(icon, color: Colors.blue),
      label: Text(label),
    );
  }
}
