import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'restaurant_detail_screen.dart';
import '../models/data_dummy.dart';
import '../theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentAdIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        title: const Text("Halo, Melvyn!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.ramen_dining, color: Colors.yellow),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- SECTION 1: ADS CAROUSEL ---
            _buildAdsCarousel(),
            const SizedBox(height: 20),

            // --- SECTION 2: RESTAURANT LIST ---
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dummyRestaurants.length,
              itemBuilder: (context, index) {
                return _buildRestaurantCard(dummyRestaurants[index]);
              },
            ),
            const SizedBox(height: 80), // Padding bottom for navbar
          ],
        ),
      ),
    );
  }

  Widget _buildAdsCarousel() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180.0,
            autoPlay: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _currentAdIndex = index;
              });
            },
          ),
          items: [1, 2, 3].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 5)],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        // Placeholder Iklan Biru seperti Mockup
                        Container(color: Colors.blue[100]),
                        Positioned(
                            top: 20, left: 20,
                            child: Text("Makan hemat?\nDiskon s/d 50%!",
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
                        ),
                        Positioned(
                          right: -20, bottom: -20,
                          child: CircleAvatar(radius: 60, backgroundColor: primaryBlue),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        // Custom Indicators (Lingkaran vs Persegi Panjang)
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [1, 2, 3].asMap().entries.map((entry) {
              bool isActive = _currentAdIndex == entry.key;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isActive ? 24.0 : 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  color: isActive ? primaryBlue : Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantCard(Restaurant res) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  res.imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(height: 150, color: Colors.grey),
                ),
              ),
              if (res.isOpen)
                Positioned(
                  top: 8, right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
                    child: const Text("Open", style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(res.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: primaryBlue),
                    Text(" ${res.distance} km", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(width: 10),
                    const Icon(Icons.sell, size: 14, color: primaryBlue),
                    Text(" ${res.priceRange}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(" ${res.rating}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        minimumSize: const Size(80, 30),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestaurantDetailScreen(restaurant: res),
                          ),
                        );
                      },
                      child: const Text("View Detail", style: TextStyle(color: Colors.white, fontSize: 12)),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}