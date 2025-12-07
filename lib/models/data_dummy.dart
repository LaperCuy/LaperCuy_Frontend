import 'package:google_maps_flutter/google_maps_flutter.dart';

class Restaurant {
  final String name;
  final String imageUrl;
  final double rating;
  final String priceRange;
  final double distance; // km
  final LatLng location;
  final bool isOpen;

  Restaurant({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.priceRange,
    required this.distance,
    required this.location,
    this.isOpen = true,
  });
}

// Koordinat Binus Anggrek
const LatLng binusLocation = LatLng(-6.2023936, 106.7818357);

final List<Restaurant> dummyRestaurants = [
  Restaurant(
    name: "Sate Madura Kemanggisan",
    imageUrl: "https://picsum.photos/id/292/300/200", // Placeholder
    rating: 5.0,
    priceRange: "20k - 25k",
    distance: 4.7,
    location: LatLng(-6.201, 106.782),
  ),
  Restaurant(
    name: "Mie Bakso Pak Gugun",
    imageUrl: "https://picsum.photos/id/1080/300/200",
    rating: 5.0,
    priceRange: "12k - 22k",
    distance: 1.2,
    location: LatLng(-6.203, 106.780),
  ),
  Restaurant(
    name: "Nasi Goreng Pak Agus",
    imageUrl: "https://picsum.photos/id/163/300/200",
    rating: 4.8,
    priceRange: "15k - 20k",
    distance: 0.8,
    location: LatLng(-6.204, 106.783),
  ),
];