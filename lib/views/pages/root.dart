import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix/controllers/home_controller.dart';
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
  final HomeController _c = Get.put(HomeController());
  int _index = 0;
  double _opacity = 0;
  bool _isShowGenre = false;

  void _openGenre() async {
    setState(() {
      _isShowGenre = true;
    });

    for (int i = 0; i < 5; i++) {
      await Future.delayed(const Duration(milliseconds: 25));
      setState(() {
        _opacity += 0.2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> body = [
      Home(openGenre: _openGenre),
      const Search(),
      const Profile()
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
                minWidth: 80,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Remix.home_2_line),
                    label: Text("Home"),
                  ),
                  NavigationRailDestination(
                      icon: Icon(Remix.search_2_line), label: Text("Search")),
                  NavigationRailDestination(
                      icon: Icon(Remix.heart_2_line), label: Text("Favourite"))
                ],
                trailing: IconButton(
                    onPressed: () {}, icon: const Icon(Remix.settings_2_line)),
                leading: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Image.asset(
                    'assets/images/user.png',
                    width: 25,
                  ),
                ),
                labelType: NavigationRailLabelType.none,
                backgroundColor: Colors.black,
                selectedLabelTextStyle: const TextStyle(fontSize: 10),
                selectedIconTheme: const IconThemeData(color: Colors.white),
                selectedIndex: _index,
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
}
