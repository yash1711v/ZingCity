import 'dart:convert';

class UserProfileModel {
  final int id;
  final String name;
  final String email;
  final String image;
  final String phone;
  final String address;
  final int status;
  final String aboutMe;

  UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.phone,
    required this.address,
    required this.status,
    required this.aboutMe,
  });

  // Factory to map from a JSON object
  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      image: map['image'],
      phone: map['phone'],
      address: map['address'],
      status: map['status'],
      aboutMe: map['about_me'],
    );
  }

  // Factory to map from a JSON string
  factory UserProfileModel.fromJson(Map<String, dynamic> source) {
    // final Map<String, dynamic> data = jsonDecode(source);

    if (source.containsKey('user')) {
      return UserProfileModel.fromMap(source['user']);
    } else {
      throw FormatException('Key "user" not found in JSON');
    }
  }
}
