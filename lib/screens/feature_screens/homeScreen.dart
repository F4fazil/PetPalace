// bottom navigation
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petpalace/constant/constant.dart';
import 'package:petpalace/screens/FaviouriteScreens.dart';
import 'package:petpalace/screens/ProfileScreen.dart';
import 'package:petpalace/screens/chatScreen.dart';
import 'package:petpalace/screens/homepage.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const ChatScreen(),
    const FavoritesPage(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bc,
      resizeToAvoidBottomInset: false,
      body: SlidingUpPanel(
        minHeight: 0, // Minimum height when panel is collapsed
        maxHeight:
            MediaQuery.of(context).size.height *
            0.3, // Adjust the height as needed
        panel: Container(
          color: bc,
          child: const Center(child: Text('Sliding Panel Content')),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
          ), // Add margin from left, right, and bottom
          height: 70, // Set a fixed height to make the container consistent
          decoration: BoxDecoration(
            color: bc, // Background color for the navigation bar
            borderRadius: BorderRadius.circular(30), // Make it circular
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4), // Shadow effect
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              30,
            ), // Ensures the BottomNavigationBar is also rounded
            child: BottomNavigationBar(
              backgroundColor: app_bc,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  backgroundColor: app_bc,
                  icon: const Icon(Icons.pentagon_outlined),
                  label: '▲',
                ),
                BottomNavigationBarItem(
                  icon: chatIconWithIndicator(),
                  backgroundColor: app_bc,
                  label: '▲',
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite_sharp),
                  backgroundColor: app_bc,
                  label: '▲',
                ),
                BottomNavigationBarItem(
                  backgroundColor: app_bc,
                  icon: const Icon(Icons.person),
                  label: '▲',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black54,
              iconSize: 30.0,
              selectedFontSize: 14.0,
              unselectedFontSize: 16.0,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }

  Widget chatIconWithIndicator() {
    final currentUserId = _firebaseAuth.currentUser!.uid;

    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore
              .collection("chat_rooms")
              .where('participants', arrayContains: currentUserId)
              .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Icon(Icons.chat);

        int totalUnread = 0;

        for (var doc in snapshot.data!.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          int unreadCount = data['unread_messages'][currentUserId] ?? 0;
          totalUnread += unreadCount;
        }

        return Stack(
          children: [
            const Icon(Icons.chat_bubble_outline_outlined),
            if (totalUnread > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    totalUnread.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
