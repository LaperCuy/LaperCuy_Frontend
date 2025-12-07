import 'package:flutter/material.dart';

// Warna diambil persis dari Mockup
const Color primaryBlue = Color(0xFF0095DA); // Biru khas LaperCuy
const Color promoYellow = Color(0xFFFFD600); // Kuning badge diskon
const Color backgroundGrey = Color(0xFFF2F2F2); // Abu-abu background
const Color textDark = Color(0xFF2E2E2E);
const Color redLogout = Color(0xFFD32F2F);
const Color greenAvailable = Color(0xFF00C853);
const Color redSoldOut = Color(0xFFFF0000);
ThemeData appTheme = ThemeData(
  primaryColor: primaryBlue,
  scaffoldBackgroundColor: backgroundGrey,
  fontFamily: 'Poppins', // Pastikan font Poppins sudah ada di pubspec.yaml
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(seedColor: primaryBlue),
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryBlue,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
  ),
);