import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:real_estate/logic/cubit/agency/agency_cubit.dart';

import '/logic/cubit/agent/agent_cubit.dart';

class AgencyStateModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String designation;
  final String address;
  final String aboutMe;
  final String image;
  final String tempImage;
  final String instagram;
  final String twitter;
  final String linkedin;
  final String password;
  final String passwordConfirmation;
  final String agentEmail;
  final String subject;
  final String message;
  final String status;
  final AgencyState agencyState;

  const AgencyStateModel({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.designation = '',
    this.address = '',
    this.aboutMe = '',
    this.image = '',
    this.tempImage = '',
    this.instagram = '',
    this.twitter = '',
    this.linkedin = '',
    this.password = '',
    this.passwordConfirmation = '',
    this.agentEmail = '',
    this.subject = '',
    this.message = '',
    this.status = '',
    this.agencyState = const AgencyInitial(),
  });

  AgencyStateModel copyWith({
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
    String? password,
    String? passwordConfirmation,
    String? agentEmail,
    String? subject,
    String? message,
    String? status,
    AgencyState? agencyState,
  }) {
    return AgencyStateModel(
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
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      agentEmail: agentEmail ?? this.agentEmail,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      status: status ?? this.status,
      agencyState: agencyState ?? this.agencyState,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'name': name,
      'email': email,
      'phone': phone,
      'designation': designation,
      'address': address,
      'about_me': aboutMe,
      'image': image,
      'instagram': instagram,
      'twitter': twitter,
      'linkedin': linkedin,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'agent_email': agentEmail,
      'subject': subject,
      'message': message,
      'status': status,
    };
  }

  AgencyStateModel clear() {
    return const AgencyStateModel(
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
      password: '',
      passwordConfirmation: '',
      agentEmail: '',
      subject: '',
      message: '',
      status: '',
      agencyState: AgencyInitial(),
    );
  }

  factory AgencyStateModel.fromMap(Map<String, dynamic> map) {
    return AgencyStateModel(
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      designation: map['designation'] as String,
      address: map['address'] as String,
      aboutMe: map['about_me'] as String,
      image: map['image'] as String,
      instagram: map['instagram'] as String,
      twitter: map['twitter'] as String,
      linkedin: map['linkedin'] as String,
      password: map['password'] as String,
      passwordConfirmation: map['passwordConfirmation'] as String,
      agentEmail: map['agentEmail'] as String,
      subject: map['subject'] as String,
      message: map['message'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AgencyStateModel.fromJson(String source) =>
      AgencyStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

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
      password,
      passwordConfirmation,
      agentEmail,
      subject,
      message,
      status,
      agencyState,
    ];
  }
}
