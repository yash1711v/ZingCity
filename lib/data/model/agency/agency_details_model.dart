import 'dart:convert';
import 'package:equatable/equatable.dart';

import 'agency_list_model.dart';

class AgencyDetailsModel extends Equatable {
  final AgencyListModel? agency;
  final List<AgencyListModel>? agents;
  final List<Properties>? properties;
  final int totalProperty;

  const AgencyDetailsModel({
    this.agency,
    this.agents,
    this.properties,
    required this.totalProperty,
  });

  AgencyDetailsModel copyWith({
    AgencyListModel? agency,
    List<AgencyListModel>? agents,
    List<Properties>? properties,
    int? totalProperty,
  }) {
    return AgencyDetailsModel(
      agency: agency ?? this.agency,
      agents: agents ?? this.agents,
      properties: properties ?? this.properties,
      totalProperty: totalProperty ?? this.totalProperty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'agency': agency?.toMap(),
      'agents': agents!.map((x) => x.toMap()).toList(),
      'properties':  properties!.map((x) => x.toMap()).toList(),
      'totalProperty': totalProperty,
    };
  }

  factory AgencyDetailsModel.fromMap(Map<String, dynamic> map) {
    return AgencyDetailsModel(
      agency: map['agency'] != null
          ? AgencyListModel.fromMap(map['agency'] as Map<String, dynamic>)
          : null,
      agents: map['agents']['data'] != null
          ? List<AgencyListModel>.from(
        (map['agents']['data'] as List<dynamic>)
            .map<AgencyListModel?>(
              (x) => AgencyListModel.fromMap(x as Map<String, dynamic>),
        ),
      )
          : [],
      properties: map['properties']['data'] != null
          ? List<Properties>.from(
        (map['properties']['data'] as List<dynamic>)
            .map<Properties?>(
              (x) => Properties.fromMap(x as Map<String, dynamic>),
        ),
      )
          : [],
      totalProperty: map['total_property'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AgencyDetailsModel.fromJson(String source) =>
      AgencyDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [agency!, agents!, properties!, totalProperty];
}

class Properties extends Equatable {
  final int id;
  final int agentId;
  final String title;
  final String slug;
  final String purpose;
  final String rentPeriod;
  final String price;
  final String thumbnailImage;
  final String address;
  final String totalBedroom;
  final String totalBathroom;
  final String totalArea;
  final String status;
  final String isFeatured;
  final int totalRating;
  final String ratingAvarage;
  final Agent agent;

  const Properties({
    required this.id,
    required this.agentId,
    required this.title,
    required this.slug,
    required this.purpose,
    required this.rentPeriod,
    required this.price,
    required this.thumbnailImage,
    required this.address,
    required this.totalBedroom,
    required this.totalBathroom,
    required this.totalArea,
    required this.status,
    required this.isFeatured,
    required this.totalRating,
    required this.ratingAvarage,
    required this.agent,
  });

  Properties copyWith({
    int? id,
    int? agentId,
    String? title,
    String? slug,
    String? purpose,
    String? rentPeriod,
    String? price,
    String? thumbnailImage,
    String? address,
    String? totalBedroom,
    String? totalBathroom,
    String? totalArea,
    String? status,
    String? isFeatured,
    int? totalRating,
    String? ratingAvarage,
    Agent? agent,
  }) {
    return Properties(
      id: id ?? this.id,
      agentId: agentId ?? this.agentId,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      purpose: purpose ?? this.purpose,
      rentPeriod: rentPeriod ?? this.rentPeriod,
      price: price ?? this.price,
      thumbnailImage: thumbnailImage ?? this.thumbnailImage,
      address: address ?? this.address,
      totalBedroom: totalBedroom ?? this.totalBedroom,
      totalBathroom: totalBathroom ?? this.totalBathroom,
      totalArea: totalArea ?? this.totalArea,
      status: status ?? this.status,
      isFeatured: isFeatured ?? this.isFeatured,
      totalRating: totalRating ?? this.totalRating,
      ratingAvarage: ratingAvarage ?? this.ratingAvarage,
      agent: agent ?? this.agent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'agentId': agentId,
      'title': title,
      'slug': slug,
      'purpose': purpose,
      'rentPeriod': rentPeriod,
      'price': price,
      'thumbnailImage': thumbnailImage,
      'address': address,
      'totalBedroom': totalBedroom,
      'totalBathroom': totalBathroom,
      'totalArea': totalArea,
      'status': status,
      'isFeatured': isFeatured,
      'totalRating': totalRating,
      'ratingAvarage': ratingAvarage,
      'agent': agent.toMap(),
    };
  }

  factory Properties.fromMap(Map<String, dynamic> map) {
    return Properties(
      id: map['id'] ?? 0,
      agentId: map['agent_id'] ?? 0,
      title: map['title'] ?? '',
      slug: map['slug'] ?? '',
      purpose: map['purpose'] ?? '',
      rentPeriod: map['rent_period'] ?? '',
      price: map['price'] ?? '',
      thumbnailImage: map['thumbnail_image'] ?? '',
      address: map['address'] ?? '',
      totalBedroom: map['total_bedroom'] ?? '',
      totalBathroom: map['total_bathroom'] ?? '',
      totalArea: map['total_area'] ?? '',
      status: map['status'] ?? '',
      isFeatured: map['is_featured'] ?? '',
      totalRating: map['totalRating'] ?? 0,
      ratingAvarage: map['ratingAvarage'] ?? '',
      agent: Agent.fromMap(map['agent'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Properties.fromJson(String source) =>
      Properties.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      agentId,
      title,
      slug,
      purpose,
      rentPeriod,
      price,
      thumbnailImage,
      address,
      totalBedroom,
      totalBathroom,
      totalArea,
      status,
      isFeatured,
      totalRating,
      ratingAvarage,
      agent,
    ];
  }
}

class Agent extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String designation;
  final String image;
  final String userName;

  const Agent({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.designation,
    required this.image,
    required this.userName,
  });

  Agent copyWith({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? designation,
    String? image,
    String? userName,
  }) {
    return Agent(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      designation: designation ?? this.designation,
      image: image ?? this.image,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'designation': designation,
      'image': image,
      'userName': userName,
    };
  }

  factory Agent.fromMap(Map<String, dynamic> map) {
    return Agent(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      designation: map['designation'] ?? '',
      image: map['image'] ?? '',
      userName: map['user_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Agent.fromJson(String source) =>
      Agent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      phone,
      email,
      designation,
      image,
      userName,
    ];
  }
}
