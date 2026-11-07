import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const DompetMuApp());
}

class DompetMuApp extends StatelessWidget {
  const DompetMuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DOMPETMU',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}

// 1. SPLASH SCREEN (LOADING)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_balance_wallet, size: 100, color: Color(0xFF0097A7)),
            const SizedBox(height: 20),
            const Text('DOMPETMU', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
            const SizedBox(height: 40),
            const CircularProgressIndicator(color: Color(0xFF0097A7)),
          ],
        ),
      ),
    );
  }
}

// 2. LOGIN SCREEN
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Icon(Icons.account_balance_wallet, size: 80, color: Color(0xFF0097A7)),
              const SizedBox(height: 20),
              const Text('Masuk ke', style: TextStyle(fontSize: 18, color: Colors.black54)),
              const Text('DOMPETMU', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
              const SizedBox(height: 30),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Google Bohongan Berhasil!')));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
                  },
                  icon: const Icon(Icons.g_mobiledata, size: 35, color: Colors.white),
                  label: const Text('Masuk dengan Google', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                ),
              ),
              
              const Padding(padding: EdgeInsets.symmetric(vertical: 20.0), child: Text('atau', style: TextStyle(color: Colors.grey))),
              
              TextField(decoration: InputDecoration(hintText: 'Email', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15))),
              const SizedBox(height: 15),
              TextField(obscureText: true, decoration: InputDecoration(hintText: 'Kata Sandi', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15))),
              const SizedBox(height: 30),
              
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A237E), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                  child: const Text('Masuk Sekarang', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 30),
              const Text('© DOMPETMU.ID', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

// 3. MAIN SCREEN
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [const NominalPage(), const AkunPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) { setState(() { _selectedIndex = index; }); },
        selectedItemColor: const Color(0xFF0097A7),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'Nominal'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
      ),
    );
  }
}

// 3A. HALAMAN NOMINAL
class NominalPage extends StatefulWidget {
  const NominalPage({super.key});
  @override
  State<NominalPage> createState() => _NominalPageState();
}

class _NominalPageState extends State<NominalPage> {
  int totalNominal = 0;
  List<Map<String, dynamic>> riwayatList = [];

  void tambahNota() {
    setState(() {
      int nominalBaru = 15000; 
      riwayatList.add({
        'judul': 'Nota Belanja ${riwayatList.length + 1}',
        'nominal': nominalBaru,
      });
      totalNominal += nominalBaru;
    });
  }

  void hapusNota(int index) {
    setState(() {
      totalNominal -= riwayatList[index]['nominal'] as int; 
      riwayatList.removeAt(index);
    });
  }

  String formatRupiah(int angka) {
    return 'Rp ${angka.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.account_balance_wallet, color: Color(0xFF0097A7)),
                const SizedBox(width: 8),
                const Text('DOMPETMU', style: TextStyle(color: Color(0xFF1A237E), fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
            const SizedBox(height: 30),
            const Text('Total Pengeluaran', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54)),
            const SizedBox(height: 15),
            
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              // PERBAIKAN WARNING BIRU DI SINI
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.teal.withValues(alpha: 0.1), blurRadius: 15, spreadRadius: 5)]),
              child: Center(
                child: Text(formatRupiah(totalNominal), style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
              ),
            ),
            const SizedBox(height: 30),
            
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: tambahNota, 
                icon: const Icon(Icons.camera_alt, color: Colors.white, size: 28),
                label: const Text('Tambah Nota Belanja', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0097A7), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              ),
            ),
            const SizedBox(height: 30),
            
            const Text('Riwayat Belanja', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
            const SizedBox(height: 15),

            if (riwayatList.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('Belum ada riwayat belanja.\nSilakan scan nota.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                ),
              )
            else
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: riwayatList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.all(15),
                      // PERBAIKAN WARNING BIRU DI SINI
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5)]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.receipt_long, size: 20, color: Color(0xFF0097A7)),
                              GestureDetector(
                                onTap: () => hapusNota(index),
                                child: const Icon(Icons.delete, size: 20, color: Colors.red),
                              ),
                            ],
                          ),
                          Text(riwayatList[index]['judul'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          Text(formatRupiah(riwayatList[index]['nominal']), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
            const SizedBox(height: 30),
            const Center(child: Text('© DOMPETMU.ID', style: TextStyle(color: Colors.grey, fontSize: 12))),
          ],
        ),
      ),
    );
  }
}

// 3B. HALAMAN AKUN
class AkunPage extends StatelessWidget {
  const AkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(radius: 50, backgroundColor: Color(0xFF0097A7), child: Icon(Icons.person, size: 60, color: Colors.white)),
            const SizedBox(height: 15),
            const Text('Pengguna DOMPETMU', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
            const SizedBox(height: 5),
            const Text('Level 1 / 100', style: TextStyle(color: Colors.grey)),
            
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              // PERBAIKAN WARNING BIRU DI SINI
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5)]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Progres Level', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('0 Koin', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const LinearProgressIndicator(value: 0.0, minHeight: 10, backgroundColor: Colors.black12, color: Color(0xFF0097A7)),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            _buildMenuButton(context, Icons.edit, 'Edit Profil'),
            _buildMenuButton(context, Icons.alternate_email, 'Ubah Username'),
            _buildMenuButton(context, Icons.share, 'Bagikan Profil'),
            _buildMenuButton(context, Icons.stars, 'Reward & Level'),
            _buildMenuButton(context, Icons.lock, 'Ganti Kata Sandi'),
            
            const SizedBox(height: 30),
            const Text('© DOMPETMU.ID', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF0097A7)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Membuka halaman $title...')));
        },
      ),
    );
  }
}
