import 'package:flutter/material.dart';
import 'package:test_2/pages/CardPage.dart';
import 'package:test_2/pages/FavouritesPage.dart';
import 'package:test_2/pages/SearchPage.dart';
import 'package:test_2/pages/WelcomPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> pages = [
    WelcomPage(),
    SearchPage(),
    FavouritesPage(),
    CardPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.orange,),label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.search,color: Colors.black,),label: "search"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,color:Colors.black),label: "shopping_cart"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite, color:Colors.black ,),label: "favorite")
        ],
        currentIndex: _selectedIndex,
      ),

      body: Center(child: pages.first,),

    );
  }
}
