import 'package:flutter/material.dart';
import '../Services/api_service.dart';
import '../Models/characters.dart';
import '../Utils/custom_exception.dart';
import 'detail_page.dart';
import '../Widgets/character_grid_tile.dart';

class PeopleScreen extends StatefulWidget {
  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  late Future<List<Character>> _charactersFuture;

  @override
  void initState() {
    super.initState();
    _charactersFuture = _fetchCharacters();
  }

  Future<List<Character>> _fetchCharacters() async {
    try {
      final response = await ApiService().fetchData(ResourceType.characters);
      final List<dynamic> results = response['data'];
      return results
          .map((characterJson) => Character.fromJson(characterJson))
          .toList();
    } catch (e) {
      if (e is FetchDataException) {
        throw e; // Rethrow the FetchDataException for proper error handling
      } else {
        throw FetchDataException('Error fetching characters: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Star Wars Characters'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Character>>(
        future: _charactersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error loading characters: ${snapshot.error}'));
          } else {
            final characters = snapshot.data ?? [];
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: characters.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CharacterDetailScreen(resource: characters),
                      ),
                    );
                  },
                  child: CharacterGridTile(character: characters[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
