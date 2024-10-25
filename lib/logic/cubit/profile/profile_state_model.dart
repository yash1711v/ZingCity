// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'profile_cubit.dart';

class ProfileStateModel extends Equatable {
  final String name;
  final String phone;
  final String address;
  final String image;
  final String designation;
  final String aboutMe;
  final String facebook;
  final String twitter;
  final String linkedin;
  final String instagram;
  final String currentPassword;
  final bool showPassword;
  String amount;
  double rate;
  int year;
  double result;
  final ProfileState profileState;

  ProfileStateModel({
    this.name = '',
    this.phone = '',
    this.address = '',
    this.image = '',
    this.designation = '',
    this.aboutMe = '',
    this.facebook = '',
    this.twitter = '',
    this.linkedin = '',
    this.instagram = '',
    this.currentPassword = '',
    this.showPassword = false,
    this.amount = '0',
    this.rate = 0.0,
    this.year = 0,
    this.result = 0.0,
    this.profileState = const ProfileInitial(),
  });

  ProfileStateModel copyWith({
    String? name,
    String? phone,
    String? address,
    String? image,
    String? designation,
    String? aboutMe,
    String? facebook,
    String? twitter,
    String? linkedin,
    String? instagram,
    String? currentPassword,
    bool? showPassword,
    String? amount,
    double? rate,
    int? year,
    double? result,
    ProfileState? profileState,
  }) {
    return ProfileStateModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      image: image ?? this.image,
      designation: designation ?? this.designation,
      aboutMe: aboutMe ?? this.aboutMe,
      facebook: facebook ?? this.facebook,
      twitter: twitter ?? this.twitter,
      linkedin: linkedin ?? this.linkedin,
      instagram: instagram ?? this.instagram,
      currentPassword: currentPassword ?? this.currentPassword,
      showPassword: showPassword ?? this.showPassword,
      amount: amount ?? this.amount,
      rate: rate ?? this.rate,
      year: year ?? this.year,
      result: result ?? this.result,
      profileState: profileState ?? this.profileState,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'name': name,
      'phone': phone,
      'address': address,
      //'image': image,
      'designation': designation,
      'about_me': aboutMe,
      'facebook': facebook,
      'twitter': twitter,
      'linkedin': linkedin,
      'instagram': instagram,
      'current_password': currentPassword,
    };
  }

  ProfileStateModel clear() {
    return ProfileStateModel(
      name: '',
      phone: '',
      address: '',
      image: '',
      designation: '',
      aboutMe: '',
      facebook: '',
      twitter: '',
      linkedin: '',
      currentPassword: '',
      showPassword: false,
      instagram: '',
    );
  }

  factory ProfileStateModel.fromMap(Map<String, dynamic> map) {
    return ProfileStateModel(
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      designation: map['designation'] as String,
      aboutMe: map['aboutMe'] as String,
      facebook: map['facebook'] as String,
      twitter: map['twitter'] as String,
      linkedin: map['linkedin'] as String,
      instagram: map['instagram'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileStateModel.fromJson(String source) =>
      ProfileStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      name,
      phone,
      address,
      image,
      designation,
      aboutMe,
      facebook,
      twitter,
      linkedin,
      instagram,
      currentPassword,
      showPassword,
      amount,
      rate,
      year,
      result,
      profileState,
    ];
  }
}
