import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/login_screen.dart'; // Import Login Screen sebagai halaman awal
import 'screens/home_screen.dart';
import 'screens/map_screen.dart';
import 'screens/promo_screen.dart';
import 'screens/friend_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const LaperCuyApp());
}

class LaperCuyApp extends StatelessWidget {
  const LaperCuyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LaperCuy',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      // PERUBAHAN UTAMA DI SINI:
      // Mengatur LoginScreen sebagai halaman pertama yang muncul
      home: const LoginScreen(),
    );
  }
}

// Class ini tetap ada untuk menampung Bottom Navigation Bar
// Class ini nanti akan dipanggil SETELAH user berhasil Login
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 2; // Default ke Home (index 2) agar pas login langsung liat makanan

  final List<Widget> _screens = [
    const MapScreen(),
    const PromoScreen(),
    const HomeScreen(),
    const FriendScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Map'),
            BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Promo'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.handshake), label: 'Friend'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}