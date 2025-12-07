import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/data_dummy.dart';
import '../theme.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    // Dummy Data Menu Makanan (Khusus untuk tampilan ini)
    final List<Map<String, dynamic>> foodMenu = [
      {
        "name": "Paket Kenyang 1",
        "price": "Rp 25.000",
        "image": "https://picsum.photos/id/292/200/200"
      },
      {
        "name": "Mie Spesial Pedas",
        "price": "Rp 18.000",
        "image": "https://picsum.photos/id/1080/200/200"
      },
      {
        "name": "Es Teh Manis Jumbo",
        "price": "Rp 5.000",
        "image": "https://picsum.photos/id/430/200/200"
      },
      {
        "name": "Kerupuk Kaleng",
        "price": "Rp 2.000",
        "image": "https://picsum.photos/id/102/200/200"
      },
    ];

    // Dummy Foto Galeri Makanan untuk Carousel
    final List<String> galleryPhotos = [
      "https://picsum.photos/id/225/400/250",
      "https://picsum.photos/id/292/400/250",
      "https://picsum.photos/id/835/400/250",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Restoran", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- BAGIAN 1: HEADER INFO (Nama, Alamat, Jarak) ---
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: primaryBlue, size: 18),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "Jl. Kemanggisan Raya No. 10 (Dekat Binus)", // Alamat dummy
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.directions_walk, color: primaryBlue, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        "${restaurant.distance} km dari Binus Anggrek",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: textDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Indikator Promo Tersedia
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: promoYellow.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.orange),
                    ),
                    child: const Text(
                      "🔥 Promo Tersedia: Diskon s/d 50%",
                      style: TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 10),

            // --- BAGIAN 2: CAROUSEL FOTO MAKANAN (Animasi Geser) ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Galeri Makanan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.85,
                aspectRatio: 16/9,
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
              items: galleryPhotos.map((url) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // --- BAGIAN 3: LIST MAKANAN (Menu) ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Daftar Menu", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true, // Penting agar tidak error scroll di dalam SingleChildScrollView
                    physics: const NeverScrollableScrollPhysics(), // Scroll mengikuti body utama
                    itemCount: foodMenu.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final food = foodMenu[index];
                      return _buildFoodCard(food);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Tombol Pesan (Opsional, pemanis UI)
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.all(16),
      //   decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))]),
      //   child: ElevatedButton(
      //     onPressed: () {},
      //     style: ElevatedButton.styleFrom(
      //       backgroundColor: primaryBlue,
      //       padding: const EdgeInsets.symmetric(vertical: 16),
      //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      //     ),
      //     child: const Text("Pesan Sekarang", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      //   ),
      // ),
    );
  }

  Widget _buildFoodCard(Map<String, dynamic> food) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundGrey, // Sedikit abu-abu agar kontras dengan putih
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Foto Makanan (Kotak Kiri)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              food['image'],
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (ctx, _, __) => Container(width: 80, height: 80, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 16),
          // Detail Makanan (Kanan)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  food['price'],
                  style: const TextStyle(color: primaryBlue, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                // Tombol Tambah Kecil
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //         border: Border.all(color: primaryBlue),
                //         borderRadius: BorderRadius.circular(20)
                //     ),
                //     child: const Text("Tambah", style: TextStyle(color: primaryBlue, fontSize: 10, fontWeight: FontWeight.bold)),
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}