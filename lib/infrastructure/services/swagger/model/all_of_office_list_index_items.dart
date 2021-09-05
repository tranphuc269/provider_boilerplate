part of swagger.api;

class AllOfOfficeListIndexItems {
  int id;
  String name;


  AllOfOfficeListIndexItems();

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'AllOfOfficeListIndexItems[name=$name, id=$id,]';
  }

  AllOfOfficeListIndexItems.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static List<AllOfOfficeListIndexItems> listFromJson(List<dynamic> json) {
    return json == null
        ? <AllOfOfficeListIndexItems>[]
        : json
            .map((value) => new AllOfOfficeListIndexItems.fromJson(value))
            .toList();
  }

  static Map<String, AllOfOfficeListIndexItems> mapFromJson(
      Map<String, Map<String, dynamic>> json) {
    final map = <String, AllOfOfficeListIndexItems>{};
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) =>
          map[key] = new AllOfOfficeListIndexItems.fromJson(value));
    }
    return map;
  }
}
