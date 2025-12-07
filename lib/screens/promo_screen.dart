import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import ini untuk fitur copy to clipboard (opsional)
import '../theme.dart';

class PromoScreen extends StatelessWidget {
  const PromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. UPDATE DATA DUMMY: Menambahkan field 'code' untuk kode promo unik
    final List<Map<String, dynamic>> promoList = [
      {
        "name": "Sate Madura Kemanggisan",
        "image": "https://picsum.photos/id/292/300/300",
        "distance": "1.2 km",
        "price": "Rp 12k - 22k",
        "discount": "50%",
        "available": true,
        "code": "SATE50JEGER", // Kode unik
      },
      {
        "name": "Nasi Goreng Pak Agus",
        "image": "https://picsum.photos/id/225/300/300",
        "distance": "1.2 km",
        "price": "Rp 12k - 22k",
        "discount": "50%",
        "available": true,
        "code": "NASGOR50TOP",
      },
      {
        "name": "Bakmie Ayam Mbak",
        "image": "https://picsum.photos/id/835/300/300",
        "distance": "1.2 km",
        "price": "Rp 12k - 22k",
        "discount": "30%",
        "available": false,
        "code": "BAKMIE30YUM",
      },
      {
        "name": "Bakso Malang Jono",
        "image": "https://picsum.photos/id/429/300/300",
        "distance": "1.2 km",
        "price": "Rp 12k - 22k",
        "discount": "20%",
        "available": true,
        "code": "BAKSO20HEBAT",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Promo Spesial Untuk Kamu",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.card_giftcard, size: 28),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: GridView.builder(
          itemCount: promoList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.62,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final item = promoList[index];
            // Kita pass context ke fungsi card agar bisa memanggil Dialog
            return _buildPromoCard(context, item);
          },
        ),
      ),
    );
  }

  // 2. FUNGSI BARU: Untuk menampilkan Popup (Dialog) Detail Promo
  void _showPromoDetailDialog(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
          backgroundColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min, // Agar dialog menyesuaikan tinggi konten
            children: [
              // Bagian Foto Restoran (Header Dialog)
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.network(
                      item['image'],
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Nama Restoran
                    Text(
                      item['name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Gunakan kode di bawah ini:",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 12),

                    // KOTAK KODE PROMO
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: primaryBlue, style: BorderStyle.solid),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item['code'], // Menampilkan Kode Unik
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                              color: primaryBlue,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.copy, size: 16, color: primaryBlue)
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Keterangan Kecil (Sesuai Requirement)
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.info_outline, color: Colors.orange, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Silahkan menukar kode promo ini ke toko!",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFE65100),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Parameter context ditambahkan di sini
  Widget _buildPromoCard(BuildContext context, Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ... (Bagian Gambar & Label Diskon SAMA SEPERTI SEBELUMNYA) ...
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    item['image'],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: -5,
                  child: Transform.rotate(
                    angle: -0.1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: promoYellow,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(1, 1))
                          ]
                      ),
                      child: Text(
                        "Diskon\n${item['discount']}!!",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- BAGIAN KONTEN TEXT ---
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: textDark,
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 12, color: primaryBlue),
                          const SizedBox(width: 4),
                          Text(item['distance'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.sell, size: 12, color: primaryBlue),
                          const SizedBox(width: 4),
                          Text(item['price'], style: const TextStyle(fontSize: 11, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: item['available'] ? greenAvailable : redSoldOut,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item['available'] ? "Tersedia" : "Habis",
                          style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      ),

                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            height: 24,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryBlue,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                              ),
                              // 3. UPDATE ONPRESSED: Memanggil Dialog
                              onPressed: item['available']
                                  ? () {
                                // Panggil fungsi dialog di sini
                                _showPromoDetailDialog(context, item);
                              }
                                  : null, // Tombol mati jika sold out
                              child: const Text(
                                "Lihat Detail Promo",
                                style: TextStyle(fontSize: 8, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}