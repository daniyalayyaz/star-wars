class StarshipList {
  int count;
  String next;
  String previous;
  List<Starship> results;

  StarshipList({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory StarshipList.fromJson(Map<String, dynamic> json) {
    var resultsList = json['results'] as List;
    List<Starship> starships =
        resultsList.map((i) => Starship.fromJson(i)).toList();

    return StarshipList(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: starships,
    );
  }
}

class Starship {
  String name;
  String model;
  String manufacturer;
  String costInCredits;
  String length;
  String maxAtmospheringSpeed;
  String crew;
  String passengers;
  String cargoCapacity;
  String consumables;
  String hyperdriveRating;
  String mglt;
  String starshipClass;
  List<String> films;
  String created;
  String edited;
  String url;

  Starship({
    required this.name,
    required this.model,
    required this.manufacturer,
    required this.costInCredits,
    required this.length,
    required this.maxAtmospheringSpeed,
    required this.crew,
    required this.passengers,
    required this.cargoCapacity,
    required this.consumables,
    required this.hyperdriveRating,
    required this.mglt,
    required this.starshipClass,
    required this.films,
    required this.created,
    required this.edited,
    required this.url,
  });

  factory Starship.fromJson(Map<String, dynamic> json) {
    var filmsList = json['films'] as List;
    List<String> films = filmsList.map((i) => i.toString()).toList();

    return Starship(
      name: json['name'],
      model: json['model'],
      manufacturer: json['manufacturer'],
      costInCredits: json['cost_in_credits'],
      length: json['length'],
      maxAtmospheringSpeed: json['max_atmosphering_speed'],
      crew: json['crew'],
      passengers: json['passengers'],
      cargoCapacity: json['cargo_capacity'],
      consumables: json['consumables'],
      hyperdriveRating: json['hyperdrive_rating'],
      mglt: json['MGLT'],
      starshipClass: json['starship_class'],
      films: films,
      created: json['created'],
      edited: json['edited'],
      url: json['url'],
    );
  }
}
