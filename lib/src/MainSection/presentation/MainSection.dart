import 'package:flutter/material.dart';
import 'package:instagram_clone/components/bottom_navigation_bar.dart';
import 'package:instagram_clone/src/DiscoverScreen/presentation/screens/DiscoverScreen.dart';
import 'package:instagram_clone/src/HomeScreen/presentation/screens/HomeScreen.dart';
import 'package:instagram_clone/src/ReelsScreen/presentation/screens/ReelsScreen.dart';
import 'package:instagram_clone/src/UserProfileScreen/presentation/screens/UserProfileScreen.dart';
import 'package:instagram_clone/utils/theams/color_pallet.dart';

import '../../AddPostScreen/presentation/screens/AddPostScreen.dart';

class MainSection extends StatefulWidget with WidgetsBindingObserver {
  const MainSection({super.key});

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  List screens = [
    const HomeScreen(),
    const DiscoverScreen(),
    const AddPostScreen(),
    const ReelsScreen(),
    const UserProfileScreen(),
  ];

  int selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    List<BottomMenuModel> bottomMenuList = [
      BottomMenuModel(
        icon: Icons.home,
        title: "Home",
        type: BottomBarEnum.HOME,
        id: 0,
        color: black,
      ),
      BottomMenuModel(
        icon: Icons.find_in_page,
        title: "Search",
        type: BottomBarEnum.SEARCH,
        id: 1,
        color: black,
      ),
      BottomMenuModel(
          icon: Icons.add_circle,
          title: "Add",
          type: BottomBarEnum.ADD_POST,
          id: 2,
          color: primaryShade500),
      BottomMenuModel(
        icon: Icons.movie,
        title: "Reels",
        type: BottomBarEnum.REELS,
        id: 3,
        color: black,
      ),
      BottomMenuModel(
        icon: Icons.account_circle,
        title: "User",
        type: BottomBarEnum.USER,
        id: 4,
        color: black,
      )
    ];



    return Scaffold(
      body: screens[selectedScreen],
      backgroundColor: primaryShade50,
      // backgroundColor:Theme.of(context).colorScheme.secondaryContainer,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CoustomBottomNavigationBar(
        items: bottomMenuList,
        onChange: (index) {
          setState(() {
            selectedScreen = index;
          });
        },
      ),
    );
  }
}
