import 'package:flutter/material.dart';
import '../theme.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> with TickerProviderStateMixin {
  bool _isFinding = false;
  late AnimationController _radarController;

  // DATA DUMMY: User Lain di Peta
  final List<Map<String, dynamic>> _nearbyFriends = [
    {
      "name": "Bryan Thanaya",
      "username": "@bryan.th",
      "image": "https://picsum.photos/id/1005/200/200",
      "meets": 12,
      "followers": 150,
      "following": 120,
      "top": 300.0,
      "left": 100.0,
    },
    {
      "name": "Jessica Jane",
      "username": "@jessjane",
      "image": "https://picsum.photos/id/338/200/200",
      "meets": 8,
      "followers": 340,
      "following": 10,
      "top": 450.0,
      "left": 280.0,
    },
    {
      "name": "Kevin Anggara",
      "username": "@kevinchocs",
      "image": "https://picsum.photos/id/64/200/200",
      "meets": 45,
      "followers": 1200,
      "following": 500,
      "top": 200.0,
      "left": 250.0,
    },
  ];

  // DATA DUMMY: Orang yang pernah ditemui (Untuk Slider)
  final List<Map<String, dynamic>> _peopleMet = [
    {"name": "Budi Santoso", "image": "https://picsum.photos/id/11/200/200"},
    {"name": "Siti Aminah", "image": "https://picsum.photos/id/12/200/200"},
    {"name": "Rudi Tabuti", "image": "https://picsum.photos/id/13/200/200"},
    {"name": "Lina Marlina", "image": "https://picsum.photos/id/14/200/200"},
  ];

  @override
  void initState() {
    super.initState();
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _radarController.dispose();
    super.dispose();
  }

  void _startFinding() {
    Navigator.pop(context); // Tutup modal sheet

    setState(() => _isFinding = true);

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _isFinding = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Teman di map sudah diperbarui!", style: TextStyle(color: Colors.white)),
            backgroundColor: primaryBlue,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(20), // Menambahkan margin agar tidak nempel bawah
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PERBAIKAN DISINI: Menggunakan Container dengan DecorationImage untuk background
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/map_placeholder.png'), // Pastikan path benar
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // -------------------------------------------
            // LAYER 1: PINPOINT USER LAIN (Langsung di atas background)
            // -------------------------------------------
            ..._nearbyFriends.map((friend) {
              return Positioned(
                top: friend['top'],
                left: friend['left'],
                child: GestureDetector(
                  onTap: () => _showOtherUserProfile(friend),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
                            ]
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(friend['image']),
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.white, size: 24, shadows: [Shadow(color: Colors.black26, blurRadius: 2)]),
                    ],
                  ),
                ),
              );
            }).toList(),

            // -------------------------------------------
            // LAYER 2: HEADER (Nama User & Icon People)
            // -------------------------------------------
            SafeArea(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 5)]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/3069/3069172.png"),
                        ),
                        SizedBox(width: 10),
                        Text(
                            "Melvyn",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textDark)
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: _showCurrentUserDetail,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: primaryBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.people, color: primaryBlue),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // -------------------------------------------
            // LAYER 3: ANIMASI FINDING (OVERLAY)
            // -------------------------------------------
            if (_isFinding)
              Container(
                color: Colors.black.withOpacity(0.7),
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          _buildRadarWave(0),
                          _buildRadarWave(0.3),
                          _buildRadarWave(0.6),
                          Container(
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3)),
                            child: const CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/3069/3069172.png"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                          "Finding...",
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.5)
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Please take a ☕ and enjoy",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER & MODALS (TIDAK BERUBAH DARI SEBELUMNYA) ---
  Widget _buildRadarWave(double delay) {
    return ScaleTransition(
      scale: Tween(begin: 1.0, end: 4.0).animate(
        CurvedAnimation(parent: _radarController, curve: Interval(delay, 1.0, curve: Curves.easeOut)),
      ),
      child: FadeTransition(
        opacity: Tween(begin: 0.5, end: 0.0).animate(
          CurvedAnimation(parent: _radarController, curve: Interval(delay, 1.0)),
        ),
        child: Container(
          width: 80, height: 80,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryBlue.withOpacity(0.5),
              border: Border.all(color: primaryBlue.withOpacity(0.5))
          ),
        ),
      ),
    );
  }

  void _showOtherUserProfile(Map<String, dynamic> user) {
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
                CircleAvatar(radius: 40, backgroundImage: NetworkImage(user['image'])),
                const SizedBox(height: 10),
                Text(user['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(user['username'], style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem("Meets", user['meets'].toString()),
                    _buildStatItem("Followers", user['followers'].toString()),
                    _buildStatItem("Following", user['following'].toString()),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: primaryBlue),
                    child: const Text("Close", style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCurrentUserDetail() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/3069/3069172.png"),
                ),
                const SizedBox(height: 10),
                const Text("Franscelino Melvyn", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                const Text("@Melvynism", style: const TextStyle(color: primaryBlue)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem("Meets", "24"),
                    _buildStatItem("Followers", "15"),
                    _buildStatItem("Following", "9"),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: _startFinding,
                    icon: const Icon(Icons.search, color: Colors.white),
                    label: const Text("Find Friend", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 5,
                      shadowColor: primaryBlue.withOpacity(0.4),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: const Text("People You've Met Before", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _peopleMet.length,
                    itemBuilder: (context, index) {
                      final person = _peopleMet[index];
                      return Container(
                        width: 100,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                            boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0,2))]
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(radius: 24, backgroundImage: NetworkImage(person['image'])),
                            const SizedBox(height: 8),
                            Text(person['name'], maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            InkWell(
                              onTap: (){},
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(color: primaryBlue, borderRadius: BorderRadius.circular(20)),
                                child: const Text("Add", style: const TextStyle(color: Colors.white, fontSize: 10)),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textDark)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}