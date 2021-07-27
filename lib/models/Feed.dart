class Feed {
  final String id;
  final String name;
  final String data;
  final String unit;

  Feed(this.id, this.name, this.data, this.unit);

  Feed.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        data = json['data'],
        unit = json['unit'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'data': data,
        'unit': unit,
      };
}
