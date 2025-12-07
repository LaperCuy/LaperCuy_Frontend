import 'package:flutter/material.dart';
import '../models/data_dummy.dart';
import '../theme.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Kita hapus controller GoogleMap karena belum ada API Key
  double _radiusKm = 1.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- PENGGANTI GOOGLE MAP (PLACEHOLDER) ---
          Positioned.fill(
            child: Image.asset(
              'assets/images/map_placeholder.png', // Pastikan Anda punya gambar ini
              fit: BoxFit.cover,
            ),
            // Jika belum ada gambar, pakai Container warna abu-abu dulu:
            // child: Container(color: Colors.grey[300]),
          ),

          // --- PINPOINT DUMMY (Manual Positioning) ---
          // Karena tidak ada map asli, kita taruh icon manual di layar biar terlihat seperti ada pin
          Positioned(
            top: 300, left: 150,
            child: Icon(Icons.location_on, color: Colors.red, size: 40),
          ),
          Positioned(
            top: 400, left: 250,
            child: Icon(Icons.location_on, color: Colors.red, size: 40),
          ),

          // --- HEADER & FILTERS (Tetap sama seperti kode sebelumnya) ---
          SafeArea(
            child: Column(
              children: [
                // Search Bar
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios, size: 16),
                      const SizedBox(width: 8),
                      Expanded(child: Text("Jl. Kb. Jeruk No.27 (Binus)", style: const TextStyle(fontWeight: FontWeight.bold))),
                      const Icon(Icons.location_on, color: primaryBlue),
                    ],
                  ),
                ),
                // Filter Chips... (Copy dari kode sebelumnya)
              ],
            ),
          ),

          // --- Slider Radius (Tetap bisa dimainkan) ---
          Positioned(
            bottom: 20, left: 16, right: 16,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Radius Simulation: ${_radiusKm.toStringAsFixed(1)} km"),
                  Slider(
                    value: _radiusKm,
                    min: 0.5, max: 3.0, divisions: 5,
                    activeColor: primaryBlue,
                    onChanged: (val) => setState(() => _radiusKm = val),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}