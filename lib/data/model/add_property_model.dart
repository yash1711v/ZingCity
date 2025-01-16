class PropertyTypeResponse {
  final bool status;
  final String message;
  final List<PropertyType> sale;
  final List<PropertyType> rent;
  final List<State> state;
  final List<City> city;
  final List<RoomType> roomType;

  PropertyTypeResponse({
    required this.status,
    required this.message,
    required this.sale,
    required this.rent,
    required this.state,
    required this.city,
    required this.roomType,
  });

  factory PropertyTypeResponse.fromJson(Map<String, dynamic> json) {
    return PropertyTypeResponse(
      status: json['status'],
      message: json['message'],
      sale: (json['sale'] as List).map((e) => PropertyType.fromJson(e)).toList(),
      rent: (json['rent'] as List).map((e) => PropertyType.fromJson(e)).toList(),
      state: (json['state'] as List).map((e) => State.fromJson(e)).toList(),
      city: (json['city'] as List).map((e) => City.fromJson(e)).toList(), roomType: (json['roomType'] as List).map((e) => RoomType.fromJson(e)).toList(),
    );
  }
}

class PropertyType {
  final int id;
  final String name;
  final String slug;
  final String icon;
  final String type;
  final int status;
  final String createdAt;
  final String updatedAt;
  final int totalProperty;

  PropertyType({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.totalProperty,
  });

  factory PropertyType.fromJson(Map<String, dynamic> json) {
    return PropertyType(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      icon: json['icon'],
      type: json['type'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      totalProperty: json['totalProperty'],
    );
  }
}

class State {
  final int id;
  final String name;
  final String code;
  final String createdAt;
  final String updatedAt;
  final int totalProperty;

  State({
    required this.id,
    required this.name,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
    required this.totalProperty,
  });

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      id: json['id'],
      name: json['name'].toString(),
      code: json['code'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
      totalProperty: json['totalProperty'] ?? 0,
    );
  }
}

class City {
  final int id;
  final String name;
  final String slug;
  final bool showHomepage;
  final String image;
  final int serial;
  final String createdAt;
  final String updatedAt;
  final int stateId;
  final int totalProperty;

  City({
    required this.id,
    required this.name,
    required this.slug,
    required this.showHomepage,
    required this.image,
    required this.serial,
    required this.createdAt,
    required this.updatedAt,
    required this.stateId,
    required this.totalProperty,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'].toString(),
      slug: json['slug'].toString(),
      showHomepage: json['show_homepage'] == 1,
      image: json['image'].toString(),
      serial: json['serial'] ?? 0,
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
      stateId: json['state_id'] ?? 0,
      totalProperty: json['totalProperty'] ?? 0,
    );
  }
}

class RoomType {
  final int id;
  final String name;
  final String slug;
  final String icon;
  final String type;
  final int status;
  final String createdAt;
  final String updatedAt;
  final int totalProperty;

  RoomType({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.totalProperty,
  });

  factory RoomType.fromJson(Map<String, dynamic> json) {
    return RoomType(
      id: json['id'] ?? 0,
      name: json['name'].toString(),
      slug: json['slug'].toString(),
      icon: json['icon'].toString(),
      type: json['type'].toString(),
      status: json['status'] ?? 0,
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
      totalProperty: json['totalProperty'] ?? 0,
    );
  }
}
