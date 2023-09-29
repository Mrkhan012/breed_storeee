import 'package:breed_storeee/utils/colors.dart';
import 'package:flutter/material.dart';


class FavoritesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> favorites;
  const FavoritesScreen(this.favorites, {super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> breeds = [];
  List<Map<String, dynamic>> favorites = [];

  static const String poppinsFontFamily = "Poppins";


  void removeFromFavorites(Map<String, dynamic> breed) {
    setState(() {
      favorites.remove(breed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBluishColor,
        title: const Text("Favorites",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
              fontFamily: poppinsFontFamily
          ),

        ),

      ),
      backgroundColor: creamColor,
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Favorite Dog Breeds",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: widget.favorites.isEmpty
                  ? const Center(
                   child: CircularProgressIndicator(),
                   )
                  : ListView.builder(
                      itemCount: widget.favorites.length,
                      itemBuilder: (context, index) {
                     final breed = widget.favorites[index];
                     return Card(
                       elevation: 4,
                       shadowColor: darkBluishColor,
                       shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                       ),
                        margin: const EdgeInsets.all(10),
                          child: ListTile(
                           title: Text(breed["name"],
                            style: const TextStyle(fontWeight: FontWeight.bold,
                            fontFamily: poppinsFontFamily,
                             ),
                             ),
                            trailing: IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.red),
                              onPressed: () {
                              removeFromFavorites(breed);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}