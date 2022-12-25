import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/kelompok.dart';
import 'package:flutter_application_1/page/list_news.dart';
import 'package:flutter_application_1/page/kelompok.dart';
import 'package:flutter_application_1/page/list_news.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final screens = [ListNews(), Kelompok()];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(size: 30),
          selectedItemColor: Colors.deepPurple,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Kelompok',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
        ),
        body: screens[_selectedIndex],
      ),
    );
  }
}
