import 'package:breed_storeee/common/comHelper.dart';
import 'package:breed_storeee/screens/favorites_screen.dart';
import 'package:breed_storeee/screens/showLogout_AlertDialog.dart';
import 'package:breed_storeee/utils/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';



class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final Dio _dio = Dio();
  final String apiUrl = "https://api.thedogapi.com/v1/breeds?limit=50&page=0";
  static const String poppinsFontFamily = "Poppins";

  List<Map<String, dynamic>> breeds = [];
  List<Map<String, dynamic>> favorites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      fetchBreeds();
      addInitialFavorites();
    });
  }

  Future<void> fetchBreeds() async {
    try {
      final response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        setState(() {
          breeds = List<Map<String, dynamic>>.from(response.data);
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void addInitialFavorites() {
    if (breeds.length >= 5) {
      for (int i = 0; i < 5; i++) {
        addToFavorites(breeds[i]);
      }
    }
  }

  void addToFavorites(Map<String, dynamic> breed) {
    if (favorites.length < 5 && !favorites.contains(breed)) {
      setState(() {
        favorites.add(breed);
      });
    } else {
      showSnackBar(context: context, content: "Only 5 Favorites can be added");

    }
  }

  void removeFromFavorites(Map<String, dynamic> breed) {
    setState(() {
      favorites.remove(breed);
    });
  }

   logout() {
    showLogoutAlertDialog(context);

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBluishColor,
        title: const Text("Store Catalog",
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => FavoritesScreen(favorites),
              ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_sharp),
            onPressed:logout,
          ),
        ],
      ),

      backgroundColor: creamColor,
      body: isLoading
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
           )
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Dog Breeds",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                fontFamily: poppinsFontFamily
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: breeds.length,
                itemBuilder: (context, index) {
                  final breed = breeds[index];
                  final isFavorite = favorites.contains(breed);

                  return Card(
                    elevation: 4,
                    shadowColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.all(10),

                    child: ListTile(
                      title: Text(breed["name"],
                        style: const TextStyle(fontWeight: FontWeight.bold,
                          fontFamily: poppinsFontFamily,
                        ),
                      ),
                      trailing: IconButton(
                        icon: isFavorite
                            ? const Icon(Icons.favorite, color: Colors.red)
                            : const Icon(Icons.favorite_border),
                        onPressed: () {
                          if (isFavorite) {
                            removeFromFavorites(breed);
                          } else {
                            addToFavorites(breed);
                          }
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
