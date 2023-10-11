import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  int ind = 0;

  AppBottomNav({super.key});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 100,
      currentIndex: ind,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.grey.shade300, size: 20),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications,color: Colors.blueGrey[300], size: 20),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined,color: Colors.blueGrey[300] , size: 20),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.notes_rounded ,color: Colors.blueGrey, size: 20),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.person ,color: Colors.blueGrey, size: 20),
            label: ''),
      ],
      fixedColor: Colors.deepPurple[200],
      onTap: (int idx) {
        ind = idx;
        switch (idx) {
          case 0:
            // do nothing
            break;
          case 1:
            Navigator.pushNamed(context, '/');
            break;
          case 3:
            Navigator.pushNamed(context, '/resume_upload');
            break;
        }
      },
    );
  }
}
