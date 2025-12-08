import 'package:flutter/material.dart';
import '../theme.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = []; // List pesan

  @override
  void initState() {
    super.initState();
    // 1. Pesan Sambutan Otomatis saat masuk
    _addMessage(
        "Halo! 👋 Saya LaperCuy AI.\nBingung mau makan apa di sekitar Binus Anggrek? Tanyakan saja pada saya!",
        false // false artinya pesan dari AI
    );
  }

  // Fungsi menambah pesan ke layar
  void _addMessage(String text, bool isUser) {
    setState(() {
      _messages.add({
        "text": text,
        "isUser": isUser,
        "time": DateTime.now(),
      });
    });
    // Scroll otomatis ke bawah
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  // Fungsi Simulasi Jawaban AI (MOCK BRAIN)
  void _simulateAIResponse(String userText) {
    String response = "";
    String lowerText = userText.toLowerCase();

    // Logika Sederhana untuk MVP
    if (lowerText.contains("halo") || lowerText.contains("hi")) {
      response = "Halo juga! Ada yang bisa saya bantu cari makan hari ini?";
    } else if (lowerText.contains("lapar") || lowerText.contains("makan")) {
      response = "Kalau lagi lapar, saya sarankan 'Nasi Goreng Pak Agus' di dekat Syahdan. Ratingnya 4.8 lho! 😋";
    } else if (lowerText.contains("promo") || lowerText.contains("diskon")) {
      response = "Lagi hemat ya? Tenang, 'Sate Madura Kemanggisan' lagi ada diskon 50% nih. Cek menu Promo ya!";
    } else if (lowerText.contains("terima kasih") || lowerText.contains("makasih")) {
      response = "Sama-sama! Selamat makan kenyang! 🥘";
    } else {
      response = "Maaf, saya masih belajar. Tapi kamu bisa cek peta untuk melihat semua restoran di sekitar Binus!";
    }

    // Delay 1 detik seolah-olah mikir
    Future.delayed(const Duration(seconds: 1), () {
      _addMessage(response, false);
    });
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;
    _textController.clear();
    _addMessage(text, true); // Tambah pesan user
    _simulateAIResponse(text); // Picu jawaban AI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.smart_toy, color: primaryBlue, size: 20), // Icon Robot AI
            ),
            const SizedBox(width: 10),
            const Text("LaperCuy AI", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // --- LIST PESAN ---
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['isUser'];
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isUser ? primaryBlue : Colors.grey[200], // Biru untuk User, Abu untuk AI
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: isUser ? const Radius.circular(16) : const Radius.circular(0),
                        bottomRight: isUser ? const Radius.circular(0) : const Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      msg['text'],
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // --- INPUT BOX ---
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: backgroundGrey,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: "Tanya rekomendasi makan...",
                        border: InputBorder.none,
                      ),
                      onSubmitted: _handleSubmitted,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => _handleSubmitted(_textController.text),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: primaryBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}