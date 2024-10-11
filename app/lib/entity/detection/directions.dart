class Directions {
  final String id;
  final String name;

  Directions(this.id, this.name);

  Directions.fromJson(Map<String, dynamic> json)
      :
        id = json['id'] as String,
        name = json['name'] as String;

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
      };
}