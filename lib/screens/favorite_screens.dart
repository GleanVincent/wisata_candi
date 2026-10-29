import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_candi/data/candi_data.dart';
import 'package:wisata_candi/providers/favorite_providers.dart';
import 'package:wisata_candi/screens/detail_screens.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<FavoriteProvider>();
    final favorites = candiList
        .where((candi) => favoriteProvider.isFavorite(candi.name))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Candi Favorit')),
      body: favorites.isEmpty
          ? const Center(child: Text('Belum ada candi favorit.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final candi = favorites[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    leading: Image.asset(
                      candi.imageAsset,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                    title: Text(candi.name),
                    subtitle: Text(candi.location),
                    trailing: IconButton(
                      tooltip: 'Hapus dari favorit',
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        context.read<FavoriteProvider>().toggle(candi.name);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(candi: candi),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
