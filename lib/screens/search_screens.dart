import 'package:flutter/material.dart';
import '../data/candi_data.dart';
import '../models/candi.dart';
import 'package:wisata_candi/screens/detail_screens.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // TODO 1: Deklarasi variabel
  final TextEditingController _searchController = TextEditingController();

  List<Candi> _filteredCandis = candiList;

  // TODO 6: Fungsi pencarian
  void _searchCandi(String query) {
    setState(() {
      _filteredCandis = candiList.where((candi) {
        return candi.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  // TODO 7: Menghapus input pencarian
  void _clearSearch() {
    _searchController.clear();
    _searchCandi('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO 2: AppBar
      appBar: AppBar(
        title: const Text('Search Candi'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      // TODO 3: Body
      body: Column(
        children: [
          // TODO 4: TextField pencarian
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: _searchController,
                autofocus: false,
                onChanged: _searchCandi,
                decoration: InputDecoration(
                  hintText: 'Cari candi ...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _clearSearch,
                  ),
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),

          // TODO 5: ListView
          Expanded(
            child: _filteredCandis.isEmpty
                ? const Center(child: Text('Candi tidak ditemukan'))
                : ListView.builder(
                    itemCount: _filteredCandis.length,
                    itemBuilder: (context, index) {
                      final candi = _filteredCandis[index];

                      return GestureDetector(
                        // TODO 8: GestureDetector
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(candi: candi),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Hero(
                                    tag: candi.name,
                                    child: Image.asset(
                                      candi.imageAsset,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              // Informasi candi
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      candi.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(candi.location),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
