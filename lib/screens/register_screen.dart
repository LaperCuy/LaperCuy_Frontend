import 'package:flutter/material.dart';
import '../theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Buat Akun Baru",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textDark),
              ),
              const Text(
                "Gabung bersama kami di LaperCuy!",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // 1. Input Email
              _buildInputLabel("Email"),
              const SizedBox(height: 8),
              TextFormField(decoration: _inputDecoration("Masukkan Email")),
              const SizedBox(height: 20),

              // 2. Input Username
              _buildInputLabel("Username"),
              const SizedBox(height: 8),
              TextFormField(decoration: _inputDecoration("Masukkan Username")),
              const SizedBox(height: 20),

              // 3. Input Password
              _buildInputLabel("Password"),
              const SizedBox(height: 8),
              TextFormField(
                obscureText: _isObscure,
                decoration: _inputDecoration("Masukkan Password").copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                    onPressed: () => setState(() => _isObscure = !_isObscure),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // 4. Tombol Register
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Mimik Registrasi Berhasil
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Registrasi akun berhasil! Silahkan Login."),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );

                    // Kembali ke Login Screen setelah delay sebentar
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Daftar Sekarang", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: textDark));
  }

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