import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_candi/providers/favorite_providers.dart';
import 'package:wisata_candi/providers/auth_providers.dart';
import 'package:wisata_candi/screens/sign_in_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Mendengarkan seluruh perubahan data dari masing-masing Provider
    final auth = context.watch<AuthProvider>();
    final favoriteCount = context.watch<FavoriteProvider>().count;

    return Scaffold(
      // Properti ini membuat body naik ke atas melewati batas AppBar sehingga visual background ungu menyatu sempurna
      extendBodyBehindAppBar: true,

      // Kustomisasi AppBar agar tombol dan teksnya berwarna putih terang
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: Colors.transparent, // Transparan agar warna Container ungu memancar dari belakang
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Membuat tombol panah back menjadi PUTIH
        titleTextStyle: const TextStyle(
          color:
              Colors.white, // Membuat judul menjadi PUTIH agar terlihat jelas
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Stack(
        children: [
          // Latar belakang balok warna ungu di area atas profil
          Container(
            height: 220, // Ketinggian disesuaikan untuk mengakomodasi wilayah AppBar kustom
            width: double.infinity,
            color: Colors.deepPurple,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                // 2. Membuat widget untuk menampilkan foto profil bulat
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 130, // Jarak disesuaikan ulang agar lingkaran foto pas menggantung di batas ungu
                    ),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white, // Border diganti PUTIH agar kontras dengan warna dasar ungu
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                              'images/placeholder_image.png',
                            ),
                          ),
                        ),
                        if (auth.isSignedIn)
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.deepPurple,
                              shape: BoxShape.circle,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // 3. Menampilkan bagian informasi profil menggunakan data Provider
                // Latihan Mandiri 1: Mengambil nilai username langsung dari AuthProvider
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(Icons.lock, color: Colors.amber),
                          SizedBox(width: 8),
                          Text(
                            'Pengguna',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ': ${auth.isSignedIn ? auth.username : 'Belum Sign In'}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(color: Colors.grey, thickness: 0.5),

                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(Icons.person, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            'Nama',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ': ${auth.isSignedIn ? auth.username : ''}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    if (auth.isSignedIn)
                      IconButton(
                        onPressed: () => debugPrint('Icon edit ditekan'),
                        icon: const Icon(Icons.edit),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(color: Colors.grey, thickness: 0.5),

                // Menampilkan jumlah total favorit candi secara real-time dari FavoriteProvider
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(Icons.favorite, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            'Favorit',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ': $favoriteCount',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),

                // 4. Membuat bagian tombol aksi Sign Out / Sign In dinamis
                const SizedBox(height: 4),
                const Divider(color: Colors.grey, thickness: 0.5),
                const SizedBox(height: 20),

                auth.isSignedIn
                    ? TextButton(
                        onPressed: () {
                          // Latihan Mandiri 2 & 3: Saat Sign Out, hapus semua favorit & ubah status autentikasi
                          context.read<FavoriteProvider>().clearAll();
                          context.read<AuthProvider>().signOut();
                        },
                        child: const Text(
                          'Sign Out',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          // Berpindah ke halaman SignInScreen ketika tombol Sign In ditekan
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignInScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 16,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
