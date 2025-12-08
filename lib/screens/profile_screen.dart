import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lapercuy/screens/login_screen.dart';
import '../theme.dart';
import 'subscription_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // URL Gambar Koala (Sama seperti di Friend Screen)
  final String _profileImageUrl = "https://cdn-icons-png.flaticon.com/512/3069/3069172.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGrey,
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER PROFILE ---
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: primaryBlue,
                  ),
                ),
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
                      // UPDATE 1: FOTO PROFIL KOALA
                      Container(
                        width: 70, height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade200),
                          image: DecorationImage(
                            image: NetworkImage(_profileImageUrl), // Menggunakan Koala
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
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
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFCC4D),
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

            const SizedBox(height: 30),

            // --- MENU OPTIONS ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildMenuButton(
                    icon: Icons.edit,
                    label: "Edit Profile",
                    onTap: () => _showEditProfileDialog(context),
                  ),
                  _buildMenuButton(
                    icon: Icons.account_balance_wallet_outlined,
                    label: "Manage Subscription",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SubscriptionScreen())
                      );
                    },
                  ),
                  _buildMenuButton(
                    icon: Icons.support_agent,
                    label: "Customer Service",
                    onTap: () => _showCustomerServiceDialog(context),
                  ),
                  const SizedBox(height: 10),
                  _buildMenuButton(
                      icon: Icons.logout,
                      label: "Logout",
                      isLogout: true,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              title: const Text("Konfirmasi Logout"),
                              content: const Text("Apakah anda yakin ingin keluar dari aplikasi?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context), // Batal
                                  child: const Text("Batal", style: TextStyle(color: Colors.grey)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // PROSES LOGOUT
                                    Navigator.pop(context); // Tutup dialog dulu

                                    // Pindah ke Login Screen & Hapus semua riwayat halaman (Back Stack)
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                                            (Route<dynamic> route) => false
                                    );
                                  },
                                  child: const Text("Keluar", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            );
                          },
                        );
                      }
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- LOGIKA POPUP EDIT PROFILE ---
  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 20),

                  // UPDATE 2: FOTO DI POPUP EDIT JUGA KOALA
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Custom Painter untuk Garis Putus-putus
                      CustomPaint(
                        painter: DashedCirclePainter(),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey.shade100,
                            backgroundImage: NetworkImage(_profileImageUrl), // Menggunakan Koala
                          ),
                        ),
                      ),
                      // Icon Pensil Overlay
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: primaryBlue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit, color: Colors.white, size: 16),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Input Nama Baru
                  _buildInputLabel("Masukkan nama baru"),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: "Franscelino Melvyn",
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: "Nama Lengkap",
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Input Username Baru
                  _buildInputLabel("Masukkan username baru"),
                  const SizedBox(height: 8),
                  TextFormField(
                    initialValue: "Melvynism",
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: "Username",
                        prefixText: "@"
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Tombol Save
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 12)
                      ),
                      child: const Text("Simpan Perubahan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // --- LOGIKA POPUP CUSTOMER SERVICE ---
  void _showCustomerServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.support_agent, size: 50, color: primaryBlue),
                const SizedBox(height: 10),
                const Text("Customer Service", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const Text("Kami siap membantu kamu!", style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 20),

                _buildContactItem(Icons.email, "LaperCuy@business.com", Colors.redAccent),
                _buildContactItem(Icons.camera_alt, "@LaperCuy", Colors.purpleAccent),
                _buildContactItem(Icons.phone, "+62 812 3456 7890", Colors.green),

                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Tutup", style: TextStyle(color: Colors.grey)),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  Widget _buildContactItem(IconData icon, String text, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200)
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
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
      margin: const EdgeInsets.only(bottom: 12),
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
                  color: isLogout ? const Color(0xFFD32F2F) : primaryBlue,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isLogout ? const Color(0xFFD32F2F) : textDark,
                  ),
                ),
                const Spacer(),
                if (!isLogout)
                  const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 4, dashSpace = 4, startX = 0;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    var path = Path();
    path.addOval(Rect.fromLTWH(0, 0, size.width, size.height));

    Path dashPath = Path();
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (startX < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(startX, startX + dashWidth),
          Offset.zero,
        );
        startX += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}