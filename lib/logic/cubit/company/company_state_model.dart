import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:real_estate/data/model/kyc/company_kyc_model.dart';
import 'package:real_estate/logic/cubit/agency/agency_cubit.dart';

import '/logic/cubit/agent/agent_cubit.dart';
import 'company_state.dart';

class CompanyStateModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String tagLine;
  final String designation;
  final String address;
  final String aboutMe;
  final String image;
  final String file;
  final String tempFile;
  final String tempImage;
  final String instagram;
  final String twitter;
  final String linkedin;
  final String kycId;
  final String message;
  final CompanyState companyState;

  const CompanyStateModel({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.tagLine = '',
    this.file = '',
    this.tempFile = '',
    this.designation = '',
    this.address = '',
    this.aboutMe = '',
    this.image = '',
    this.tempImage = '',
    this.instagram = '',
    this.twitter = '',
    this.linkedin = '',
    this.kycId = '',
    this.message = '',
    this.companyState = const CompanyInitial(),
  });

  CompanyStateModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? designation,
    String? address,
    String? aboutMe,
    String? image,
    String? tempImage,
    String? instagram,
    String? twitter,
    String? linkedin,
    String? tagLine,
    String? file,
    String? tempFile,
    String? kycId,
    String? message,

    CompanyState? companyState,
  }) {
    return CompanyStateModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      designation: designation ?? this.designation,
      address: address ?? this.address,
      aboutMe: aboutMe ?? this.aboutMe,
      image: image ?? this.image,
      tempImage: tempImage ?? this.tempImage,
      instagram: instagram ?? this.instagram,
      twitter: twitter ?? this.twitter,
      linkedin: linkedin ?? this.linkedin,
      tagLine: tagLine ?? this.tagLine,
      file: file ?? this.file,
      tempFile: tempFile ?? this.tempFile,
      kycId: kycId ?? this.kycId,
      companyState: companyState ?? this.companyState,
      message: message ?? this.message,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'name': name,
      'email': email,
      'phone': phone,
      'designation': designation,
      'address': address,
      'about_us': aboutMe,
      'image': image,
      'instagram': instagram,
      'twitter': twitter,
      'linkedin': linkedin,
      'tag_line': tagLine,
      'file': file,
      'kyc_id': kycId,
      'message': message,
    };
  }

  CompanyStateModel clear() {
    return const CompanyStateModel(
      name: '',
      email: '',
      phone: '',
      designation: '',
      address: '',
      aboutMe: '',
      image: '',
      instagram: '',
      twitter: '',
      linkedin: '',
      tagLine: '',
      file: '',
      kycId: '',
      message: '',
      companyState: CompanyInitial(),
    );
  }

  factory CompanyStateModel.fromMap(Map<String, dynamic> map) {
    return CompanyStateModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      designation: map['designation'] as String,
      address: map['address'] as String,
      aboutMe: map['about_us'] as String,
      image: map['image'] as String,
      instagram: map['instagram'] as String,
      twitter: map['twitter'] as String,
      linkedin: map['linkedin'] as String,

    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyStateModel.fromJson(String source) =>
      CompanyStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      name,
      email,
      phone,
      designation,
      address,
      aboutMe,
      image,
      tempImage,
      instagram,
      twitter,
      linkedin,
      tagLine,
      file,
      tempFile,
      kycId,
      message,
      companyState,
    ];
  }
}
