import 'package:flutter/material.dart';
import 'package:movies/movies/presentation/screens/movies_screen.dart';
import 'package:movies/tvs/presentation/screens/tvs_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List screens = [
      const MoviesScreen(),
      const TvsScreen(),
    ];
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.grey.shade900,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "FILMS"),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: "TVS"),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
