import 'package:flutter/material.dart';
import '../theme.dart';
import '../main.dart'; // Import MainNavigation
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true; // State untuk menyembunyikan password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView( // Agar tidak error saat keyboard muncul
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Logo LaperCuy
                Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/logo_lapercuy.jpg'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Selamat Datang!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textDark),
                ),
                const Text(
                  "Silahkan masuk untuk melanjutkan",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 40),

                // 2. Input Username
                _buildInputLabel("Username"),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: _inputDecoration("Masukkan Username"),
                ),
                const SizedBox(height: 20),

                // 3. Input Password
                _buildInputLabel("Password"),
                const SizedBox(height: 8),
                TextFormField(
                  obscureText: _isObscure, // Password jadi titik-titik
                  decoration: _inputDecoration("Masukkan Password").copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                      onPressed: () => setState(() => _isObscure = !_isObscure),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 4. Tombol Login
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Masuk ke Halaman Utama (Home)
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MainNavigation())
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Login", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),

                const SizedBox(height: 20),

                // 5. Tombol ke Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Belum memiliki akun? ", style: TextStyle(color: Colors.grey)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterScreen())
                        );
                      },
                      child: const Text(
                          "Daftar Sekarang",
                          style: TextStyle(color: primaryBlue, fontWeight: FontWeight.bold)
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper Widget untuk Label
  Widget _buildInputLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: textDark)),
    );
  }

  // Helper Decoration
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primaryBlue)),
    );
  }
}