class SpeciesResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Species> results;

  SpeciesResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory SpeciesResponse.fromJson(Map<String, dynamic> json) {
    return SpeciesResponse(
      count: json['count'] ?? 0,
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>)
          .map((item) => Species.fromJson(item))
          .toList(),
    );
  }
}

class Species {
  final String name;
  final String classification;
  final String designation;
  final String averageHeight;
  final String skinColors;
  final String hairColors;
  final String eyeColors;
  final String averageLifespan;
  final String? homeworld;
  final String language;
  final List<String> people;
  final List<String> films;
  final String created;
  final String edited;
  final String url;

  Species({
    required this.name,
    required this.classification,
    required this.designation,
    required this.averageHeight,
    required this.skinColors,
    required this.hairColors,
    required this.eyeColors,
    required this.averageLifespan,
    this.homeworld,
    required this.language,
    required this.people,
    required this.films,
    required this.created,
    required this.edited,
    required this.url,
  });

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      name: json['name'] ?? '',
      classification: json['classification'] ?? '',
      designation: json['designation'] ?? '',
      averageHeight: json['average_height'] ?? '',
      skinColors: json['skin_colors'] ?? '',
      hairColors: json['hair_colors'] ?? '',
      eyeColors: json['eye_colors'] ?? '',
      averageLifespan: json['average_lifespan'] ?? '',
      homeworld: json['homeworld'],
      language: json['language'] ?? '',
      people: List<String>.from(json['people'] ?? []),
      films: List<String>.from(json['films'] ?? []),
      created: json['created'] ?? '',
      edited: json['edited'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
