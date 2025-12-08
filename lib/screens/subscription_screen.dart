import 'package:flutter/material.dart';
import '../theme.dart'; // Pastikan import theme benar

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Manage Subscription", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Pilih paket terbaik untukmu!",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // --- KARTU FREEMIUM (Biru) ---
            _buildPlanCard(
              context,
              title: "Freemium",
              price: "Gratis",
              color: primaryBlue,
              features: ["Akses Map Dasar", "Lihat Promo Terbatas", "Iklan Tampil"],
              isActive: false, // Melvyn bukan Freemium
            ),

            const SizedBox(height: 20),

            // --- KARTU PREMIUM (Emas) ---
            _buildPlanCard(
              context,
              title: "Premium Member",
              price: "Rp 25.000 / bulan",
              color: const Color(0xFFD4AF37), // Warna Emas Elegan
              features: ["Akses Map Unlimited", "Promo Eksklusif", "Bebas Iklan", "Fitur Friend Radar"],
              isActive: true, // Melvyn adalah Premium
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, {
    required String title,
    required String price,
    required Color color,
    required List<String> features,
    required bool isActive,
  }) {
    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20), // Corner melengkung
              boxShadow: [
                BoxShadow(color: color.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 5))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  price,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 20),
                ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text(feature, style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                )),
              ],
            ),
          ),

          // --- INDIKATOR ACTIVE PLAN (Lingkaran Emas/Putih dengan Centang) ---
          if (isActive)
            Positioned(
              top: 15,
              right: 15,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                ),
                child: Icon(Icons.check, color: color, size: 24),
              ),
            ),

          if (isActive)
            Positioned(
              bottom: 20,
              right: 20,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white)
                ),
                child: const Text(
                  "Anda telah menjadi bagian dari premium plan subscription!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            )
        ],
      ),
    );
  }
}