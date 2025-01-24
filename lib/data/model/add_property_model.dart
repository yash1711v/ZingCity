import 'dart:convert';

class PropertyTypeResponse {
  bool? status;
  String? message;
  PurposeClass? purpose;
  List<Category>? categories;
  Map<String, Category>? subcategories;
  List<RoomType>? roomType;
  List<State>? state;
  List<City>? city;
  List<Amenity>? amenities;
  List<Location>? nearestLocation;

  PropertyTypeResponse({
    this.status,
    this.message,
    this.purpose,
    this.categories,
    this.subcategories,
    this.roomType,
    this.state,
    this.city,
    this.amenities,
    this.nearestLocation,
  });

  PropertyTypeResponse copyWith({
    bool? status,
    String? message,
    PurposeClass? purpose,
    List<Category>? categories,
    Map<String, Category>? subcategories,
    List<RoomType>? roomType,
    List<State>? state,
    List<City>? city,
    List<Amenity>? amenities,
    List<Location>? nearestLocation,
  }) =>
      PropertyTypeResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        purpose: purpose ?? this.purpose,
        categories: categories ?? this.categories,
        subcategories: subcategories ?? this.subcategories,
        roomType: roomType ?? this.roomType,
        state: state ?? this.state,
        city: city ?? this.city,
        amenities: amenities ?? this.amenities,
        nearestLocation: nearestLocation ?? this.nearestLocation,
      );

  factory PropertyTypeResponse.fromJson(Map<String, dynamic> json) => PropertyTypeResponse(
    status: json['status'] as bool?,
    message: json['message'] as String?,
    purpose: json['purpose'] != null ? PurposeClass.fromJson(json['purpose']) : null,
    categories: (json['categories'] as List<dynamic>?)
        ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList(),
    subcategories: (json['subcategories'] as Map<String, dynamic>?)?.map(
          (key, value) => MapEntry(key, Category.fromJson(value as Map<String, dynamic>)),
    ),
    roomType: (json['room_type'] as List<dynamic>?)
        ?.map((e) => RoomType.fromJson(e as Map<String, dynamic>))
        .toList(),
    state: (json['state'] as List<dynamic>?)
        ?.map((e) => State.fromJson(e as Map<String, dynamic>))
        .toList(),
    city: (json['city'] as List<dynamic>?)
        ?.map((e) => City.fromJson(e as Map<String, dynamic>))
        .toList(),
    amenities: (json['amenities'] as List<dynamic>?)
        ?.map((e) => Amenity.fromJson(e as Map<String, dynamic>))
        .toList(),
    nearestLocation: (json['nearest_location'] as List<dynamic>?)
        ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'purpose': purpose?.toJson(),
    'categories': categories?.map((e) => e.toJson()).toList(),
    'subcategories': subcategories?.map((key, value) => MapEntry(key, value.toJson())),
    'room_type': roomType?.map((e) => e.toJson()).toList(),
    'state': state?.map((e) => e.toJson()).toList(),
    'city': city?.map((e) => e.toJson()).toList(),
    'amenities': amenities?.map((e) => e.toJson()).toList(),
    'nearestLocation': nearestLocation?.map((e) => e.toJson()).toList(),
  };
}

class Amenity {
  int? id;
  String? aminity;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? location;

  Amenity({
    this.id,
    this.aminity,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.location,
  });

  Amenity copyWith({
    int? id,
    String? aminity,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? location,
  }) =>
      Amenity(
        id: id ?? this.id,
        aminity: aminity ?? this.aminity,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        location: location ?? this.location,
      );

  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
    id: json['id'],
    aminity: json['aminity'],
    status: json['status'],
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'])
        : null,
    location: json['location'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'aminity': aminity,
    'status': status,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'location': location,
  };
}

class Location {
  int? id;
  String? location;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  // String? location;

  Location({
    this.id,
    this.location,
    this.status,
    this.createdAt,
    this.updatedAt,
    // this.location,
  });

  Location copyWith({
    int? id,
    String? location,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    // String? location,
  }) =>
      Location(
        id: id ?? this.id,
        location: location ?? this.location,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        // location: location ?? this.location,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json['id'],
    location: json['location'],
    status: json['status'],
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'])
        : null,
    // location: json['location'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'location': location,
    'status': status,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    // 'location': location,
  };
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? icon;
  List<dynamic>? purpose;
  dynamic type;
  int? parentId;
  dynamic image;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? totalProperty;

  Category({
    this.id,
    this.name,
    this.slug,
    this.icon,
    this.purpose,
    this.type,
    this.parentId,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.totalProperty,
  });

  Category copyWith({
    int? id,
    String? name,
    String? slug,
    String? icon,
    List<String>? purpose,
    dynamic type,
    int? parentId,
    dynamic image,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalProperty,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        icon: icon ?? this.icon,
        purpose: purpose ?? this.purpose,
        type: type ?? this.type,
        parentId: parentId ?? this.parentId,
        image: image ?? this.image,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        totalProperty: totalProperty ?? this.totalProperty,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json['id'],
    name: json['name'],
    slug: json['slug'],
    icon: json['icon'],
    purpose: json['purpose'] != null
        ? jsonDecode(json['purpose'])
        : null,
    type: json['type'],
    parentId: json['parent_id'],
    image: json['image'],
    status: json['status'],
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'])
        : null,
    totalProperty: json['totalProperty'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'icon': icon,
    'purpose': purpose,
    'type': type,
    'parent_id': parentId,
    'image': image,
    'status': status,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'totalProperty': totalProperty,
  };
}

// enum PurposeEnum {
//   THE_1,
//   THE_12,
//   THE_2
// }

class City {
  int? id;
  String? name;
  String? slug;
  int? showHomepage;
  String? image;
  int? serial;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? stateId;
  int? totalProperty;

  City({
    this.id,
    this.name,
    this.slug,
    this.showHomepage,
    this.image,
    this.serial,
    this.createdAt,
    this.updatedAt,
    this.stateId,
    this.totalProperty,
  });

  City copyWith({
    int? id,
    String? name,
    String? slug,
    int? showHomepage,
    String? image,
    int? serial,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? stateId,
    int? totalProperty,
  }) =>
      City(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        showHomepage: showHomepage ?? this.showHomepage,
        image: image ?? this.image,
        serial: serial ?? this.serial,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        stateId: stateId ?? this.stateId,
        totalProperty: totalProperty ?? this.totalProperty,
      );

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json['id'],
    name: json['name'],
    slug: json['slug'],
    showHomepage: json['showHomepage'],
    image: json['image'],
    serial: json['serial'],
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'])
        : null,
    stateId: json['stateId'],
    totalProperty: json['totalProperty'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'showHomepage': showHomepage,
    'image': image,
    'serial': serial,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'stateId': stateId,
    'totalProperty': totalProperty,
  };
}

class PurposeClass {
  List<Rent>? sell;
  List<Rent>? rent;

  PurposeClass({
    this.sell,
    this.rent,
  });

  PurposeClass copyWith({
    List<Rent>? sell,
    List<Rent>? rent,
  }) =>
      PurposeClass(
        sell: sell ?? this.sell,
        rent: rent ?? this.rent,
      );

  factory PurposeClass.fromJson(Map<String, dynamic> json) => PurposeClass(
    sell: (json['sell'] as List<dynamic>?)
        ?.map((e) => Rent.fromJson(e))
        .toList(),

    // (json['sell'] as Map<String, dynamic>?),
    rent: (json['rent'] as List<dynamic>?)
        ?.map((e) => Rent.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'sell': sell?.map((e) => e.toJson()).toList(),
    'rent': rent?.map((e) => e.toJson()).toList(),
  };
}

class Rent {
  int? categoryId;
  List<int>? subcategories;

  Rent({
    this.categoryId,
    this.subcategories,
  });

  Rent copyWith({
    int? categoryId,
    List<int>? subcategories,
  }) =>
      Rent(
        categoryId: categoryId ?? this.categoryId,
        subcategories: subcategories ?? this.subcategories,
      );

  factory Rent.fromJson(Map<String, dynamic> json) => Rent(
    categoryId: json['category_id'],
    subcategories: (json['subcategories'] as List<dynamic>?)
        ?.map((e) => e as int)
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'category_id': categoryId,
    'subcategories': subcategories,
  };
}

class RoomType {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  RoomType({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  RoomType copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      RoomType(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory RoomType.fromJson(Map<String, dynamic> json) => RoomType(
    id: json['id'],
    name: json['bhk_type'] ?? "",
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'bhk_type': name,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}

class State {
  int? id;
  String? name;
  String? code;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? totalProperty;

  State({
    this.id,
    this.name,
    this.code,
    this.createdAt,
    this.updatedAt,
    this.totalProperty,
  });

  State copyWith({
    int? id,
    String? name,
    String? code,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? totalProperty,
  }) =>
      State(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        totalProperty: totalProperty ?? this.totalProperty,
      );

  factory State.fromJson(Map<String, dynamic> json) => State(
    id: json['id'],
    name: json['name'],
    code: json['code'],
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : null,
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'])
        : null,
    totalProperty: json['totalProperty'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'code': code,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'totalProperty': totalProperty,
  };
}
