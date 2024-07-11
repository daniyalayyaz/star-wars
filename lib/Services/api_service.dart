import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Utils/custom_exception.dart';

enum ResourceType { characters, planets, starships, films, species, vehicles }

class ApiService {
  final String baseUrl = 'https://swapi.dev/api';

  Future<dynamic> fetchData(ResourceType resourceType, {String? url}) async {
    try {
      final response = await http
          .get(Uri.parse(url ?? _getUrlForResourceType(resourceType)));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (url != null) {
          return data;
        }
        switch (resourceType) {
          case ResourceType.characters:
            Map<String, dynamic> characterData = data;
            List<dynamic> results = characterData['results'];
            return {'data': results, 'next': data['next']};
          case ResourceType.planets:
            Map<String, dynamic> planetData = data;
            List<dynamic> results = planetData['results'];
            return {'data': results, 'next': data['next']};
          case ResourceType.starships:
            Map<String, dynamic> starshipData = data;
            List<dynamic> results = starshipData['results'];
            return {'data': results, 'next': data['next']};
          case ResourceType.films:
            Map<String, dynamic> filmData = data;
            List<dynamic> results = filmData['results'];
            return {'data': results, 'next': data['next']};
          case ResourceType.species:
            Map<String, dynamic> speciesData = data;
            List<dynamic> results = speciesData['results'];
            return {'data': results, 'next': data['next']};
          case ResourceType.vehicles:
            Map<String, dynamic> vehicles = data;
            List<dynamic> results = vehicles['results'];
            return {'data': results, 'next': data['next']};
          default:
            throw FetchDataException('Unknown resource type');
        }
      } else {
        throw FetchDataException('Failed to load data');
      }
    } catch (e) {
      throw FetchDataException('Failed to load data');
    }
  }

  String _getUrlForResourceType(ResourceType resourceType) {
    switch (resourceType) {
      case ResourceType.characters:
        return '$baseUrl/people/';
      case ResourceType.planets:
        return '$baseUrl/planets/';
      case ResourceType.starships:
        return '$baseUrl/starships/';
      case ResourceType.vehicles:
        return '$baseUrl/vehicles/';
      case ResourceType.species:
        return '$baseUrl/species/';
      case ResourceType.films:
        return '$baseUrl/films/';
      default:
        throw FetchDataException('Unknown resource type');
    }
  }
}
