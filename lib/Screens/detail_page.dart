import 'package:flutter/material.dart';
import '../Models/characters.dart';
import '../Models/films.dart';
import '../Models/planets.dart';
import '../Models/species.dart';
import '../Models/starships.dart';
import '../Models/vehicles.dart';
import '../Services/api_service.dart';
import '../Utils/custom_exception.dart';

class CharacterDetailScreen extends StatelessWidget {
  final dynamic resource; // Use dynamic to handle different resource types

  CharacterDetailScreen({required this.resource});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarTitle(),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildDetailWidgets(context),
        ),
      ),
    );
  }

  // Dynamically build the AppBar title based on the resource type
  Widget _buildAppBarTitle() {
    String title = '';
    if (resource is Character) {
      title = (resource as Character).name;
    } else if (resource is Film) {
      title = (resource as Film).title;
    } else if (resource is Species) {
      title = (resource as Species).name;
    } else if (resource is Vehicle) {
      title = (resource as Vehicle).name;
    } else if (resource is Starship) {
      title = (resource as Starship).name;
    } else if (resource is Planet) {
      title = (resource as Planet).name;
    }
    return Text(title);
  }

  // Dynamically build detail widgets based on the resource type
  List<Widget> _buildDetailWidgets(BuildContext context) {
    List<Widget> widgets = [];

    if (resource is Character) {
      // Handle Character details
      Character character = resource as Character;
      widgets.addAll([
        Text(
          'Name: ${character.name}',
        ),
        Text('Height: ${character.height}'),
        Text('Mass: ${character.mass}'),
        Text('Hair Color: ${character.hairColor}'),
        Text('Skin Color: ${character.skinColor}'),
        Text('Eye Color: ${character.eyeColor}'),
        Text('Birth Year: ${character.birthYear}'),
        Text('Gender: ${character.gender}'),
        SizedBox(height: 10),
        _buildNestedListView(
            context, [character.homeworld], ResourceType.planets),
        _buildNestedListView(context, character.films, ResourceType.films),
        _buildNestedListView(context, character.species, ResourceType.species),
        _buildNestedListView(
            context, character.vehicles, ResourceType.vehicles),
        _buildNestedListView(
            context, character.starships, ResourceType.starships),
      ]);
    } else if (resource is Film) {
      // Handle Character details
      Film film = resource as Film;
      widgets.addAll([
        Text('Title: ${film.title}'),
        Text('Episode: ${film.episodeId}'),
        Text('Opening Crawl: ${film.openingCrawl}'),
        Text('Director: ${film.director}'),
        Text('Producer: ${film.producer}'),
        Text('Release Date: ${film.releaseDate}'),
        const SizedBox(height: 10),
        _buildNestedListView(context, film.characters, ResourceType.characters),
        _buildNestedListView(context, film.planets, ResourceType.planets),
        _buildNestedListView(context, film.species, ResourceType.species),
        _buildNestedListView(context, film.vehicles, ResourceType.vehicles),
        _buildNestedListView(context, film.starships, ResourceType.starships),
      ]);
    } else if (resource is Vehicle) {
      // Handle Character details
      Vehicle vehicle = resource as Vehicle;
      widgets.addAll([
        Text('Name: ${vehicle.name}'),
        Text('Model: ${vehicle.model}'),
        Text('Manufacturer: ${vehicle.manufacturer}'),
        Text('Cost in credits: ${vehicle.costInCredits}'),
        Text('Length: ${vehicle.length}'),
        Text('Max Atmosphere Speed: ${vehicle.maxAtmospheringSpeed}'),
        Text('Crew: ${vehicle.crew}'),
        Text('Passenger: ${vehicle.passengers}'),
        Text('Cargo Capacity: ${vehicle.cargoCapacity}'),
        Text('Consumables: ${vehicle.consumables}'),
        Text('Vehicle Class: ${vehicle.vehicleClass}'),
        const SizedBox(height: 10),
        _buildNestedListView(context, vehicle.films, ResourceType.films),
      ]);
    } else if (resource is Planet) {
      // Handle Character details
      Planet planet = resource as Planet;
      widgets.addAll([
        Text('Name: ${planet.name}'),
        Text('Rotation Period: ${planet.rotationPeriod}'),
        Text('Orbital Period: ${planet.orbitalPeriod}'),
        Text('Diameter: ${planet.diameter}'),
        Text('Climate: ${planet.climate}'),
        Text('Gravity: ${planet.gravity}'),
        Text('Terrain: ${planet.terrain}'),
        Text('Surface Water: ${planet.surfaceWater}'),
        Text('Population: ${planet.population}'),
        const SizedBox(height: 10),
        _buildNestedListView(context, planet.films, ResourceType.films),
      ]);
    } else if (resource is Species) {
      // Handle Character details
      Species species = resource as Species;
      widgets.addAll([
        Text('Name: ${species.name}'),
        Text('Classification: ${species.classification}'),
        Text('Designation: ${species.designation}'),
        Text('Average Height: ${species.averageHeight}'),
        Text('Skin Colors: ${species.skinColors}'),
        Text('Hair Colors: ${species.hairColors}'),
        Text('Eye Colors: ${species.eyeColors}'),
        Text('Average Life Span: ${species.averageLifespan}'),
        Text('Home World: ${species.homeworld}'),
        const SizedBox(height: 10),
        _buildNestedListView(context, species.films, ResourceType.films),
        _buildNestedListView(context, species.people, ResourceType.characters),
      ]);
    } else if (resource is Starship) {
      // Handle Character details
      Starship starship = resource as Starship;
      widgets.addAll([
        Text('Name: ${starship.name}'),
        Text('Manufacture: ${starship.manufacturer}'),
        Text('Cost in credit: ${starship.costInCredits}'),
        Text('Length: ${starship.length}'),
        Text('Max at atmosphere speed: ${starship.maxAtmospheringSpeed}'),
        Text('Crew: ${starship.crew}'),
        Text('Passengers: ${starship.passengers}'),
        Text('Cargo Capacity: ${starship.cargoCapacity}'),
        Text('Hyper Drive Rating: ${starship.hyperdriveRating}'),
        Text('Mglt: ${starship.mglt}'),
        Text('Starship Class: ${starship.starshipClass}'),
        const SizedBox(height: 10),
        _buildNestedListView(context, starship.films, ResourceType.films),
      ]);
    }

    return widgets;
  }

  // Build a nested list view for related resources
  Widget _buildNestedListView(
      BuildContext context, List<String> urls, ResourceType resourceType) {
    return FutureBuilder<List<dynamic>>(
      future: _fetchDetails(urls, resourceType),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: CircularProgressIndicator(
              color: Colors.teal,
            ),
          ));
        } else if (snapshot.hasError) {
          return Text('Error loading ${resourceTypeToString(resourceType)}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container();
        } else {
          final details = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(resourceTypeToString(resourceType),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: details.length,
                  itemBuilder: (context, index) {
                    final detail = details[index];
                    String displayText;
                    if (detail is Character) {
                      displayText = detail.name;
                    } else if (detail is Planet) {
                      displayText = detail.name;
                    } else if (detail is Film) {
                      displayText = detail.title;
                    } else if (detail is Species) {
                      displayText = detail.name;
                    } else if (detail is Vehicle) {
                      displayText = detail.name;
                    } else if (detail is Starship) {
                      displayText = detail.name;
                    } else {
                      displayText = 'Unknown';
                    }
                    return GestureDetector(
                      onTap: () {
                        _navigateToDetail(context, detail);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.teal[400],
                            borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            displayText,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  // Fetch details for related resources
  Future<List<dynamic>> _fetchDetails(
      List<String> urls, ResourceType resourceType) async {
    List<dynamic> details = [];
    for (String url in urls) {
      try {
        final detail = await ApiService().fetchData(resourceType, url: url);
        switch (resourceType) {
          case ResourceType.characters:
            details.add(Character.fromJson(detail));
            break;
          case ResourceType.planets:
            details.add(Planet.fromJson(detail));
            break;
          case ResourceType.films:
            details.add(Film.fromJson(detail));
            break;
          case ResourceType.species:
            details.add(Species.fromJson(detail));
            break;
          case ResourceType.vehicles:
            details.add(Vehicle.fromJson(detail));
            break;
          case ResourceType.starships:
            details.add(Starship.fromJson(detail));
            break;
          default:
            throw FetchDataException('Unknown resource type');
        }
      } catch (e) {
        details.add('Error fetching ${resourceTypeToString(resourceType)}');
      }
    }
    return details;
  }

  // Navigate to detail screen for nested resources
  void _navigateToDetail(BuildContext context, dynamic detail) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterDetailScreen(resource: detail),
      ),
    );
  }
}

// Helper function to convert ResourceType enum to string
String resourceTypeToString(ResourceType type) {
  switch (type) {
    case ResourceType.characters:
      return 'Characters';
    case ResourceType.planets:
      return 'Planets';
    case ResourceType.starships:
      return 'Starships';
    case ResourceType.films:
      return 'Films';
    case ResourceType.species:
      return 'Species';
    case ResourceType.vehicles:
      return 'Vehicles';
    default:
      return 'Unknown';
  }
}
