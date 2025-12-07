import 'package:flutter/material.dart';
import '../theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGrey, // Background keseluruhan abu-abu
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () {
            // Logika kembali (biasanya pop, tapi ini root screen)
          },
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER PROFILE ---
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // 1. Background Biru Tambahan (Penyambung AppBar)
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)), // Lurus saja
                  ),
                ),

                // 2. Kartu Profil Utama
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))
                    ],
                  ),
                  child: Row(
                    children: [
                      // Avatar Bebek
                      Container(
                        width: 70, height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black12),
                          image: const DecorationImage(
                            // Ganti dengan aset lokal Anda: 'assets/images/duck_avatar.png'
                            image: NetworkImage("https://cdn-icons-png.flaticon.com/512/3069/3069172.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Info Text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Franscelino Melvyn",
                              style: TextStyle(
                                color: primaryBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Text(
                              "@Melvynism",
                              style: TextStyle(color: Colors.blueAccent, fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            // Badge Premium
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFCC4D), // Warna Emas/Kuning Premium
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                "Premium Member",
                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // --- MENU OPTIONS ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildMenuButton(icon: Icons.edit, label: "Edit Profile"),
                  _buildMenuButton(icon: Icons.favorite_border, label: "My Favorites"),
                  _buildMenuButton(icon: Icons.history, label: "Search History"),
                  _buildMenuButton(icon: Icons.account_balance_wallet_outlined, label: "Manage Subscription"),
                  _buildMenuButton(icon: Icons.settings_outlined, label: "Settings"),
                  _buildMenuButton(icon: Icons.support_agent, label: "Customer Service"),
                  const SizedBox(height: 10),
                  _buildMenuButton(
                      icon: Icons.logout,
                      label: "Logout",
                      isLogout: true,
                      onTap: () {
                        // Logika Logout
                      }
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    bool isLogout = false,
    VoidCallback? onTap
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12), // Jarak antar tombol
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 2)
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () {},
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isLogout ? redLogout : primaryBlue, // Ikon merah jika logout
                  size: 24,
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isLogout ? redLogout : textDark, // Teks merah jika logout
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}