import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'user_profile_model.dart';

class UserLoginResponseModel extends Equatable {
  final UserProfileModel user;
  final String accessToken;
  final int expiresIn;
  final String tokenType;
  const UserLoginResponseModel({
    required this.user,
    required this.accessToken,
    required this.expiresIn,
    required this.tokenType,
  });

  UserLoginResponseModel copyWith({
    UserProfileModel? user,
    String? accessToken,
    int? expiresIn,
    String? tokenType,
  }) {
    return UserLoginResponseModel(
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      expiresIn: expiresIn ?? this.expiresIn,
      tokenType: tokenType ?? this.tokenType,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    // result.addAll({'user': user.toMap()});
    result.addAll({'access_token': accessToken});
    result.addAll({'expires_in': expiresIn});
    result.addAll({'token_type': tokenType});

    return result;
  }

  factory UserLoginResponseModel.fromMap(Map<String, dynamic> map) {
    return UserLoginResponseModel(
      user: UserProfileModel.fromMap(map['user']),
      accessToken: map['access_token'] ?? '',
      expiresIn: map['expires_in'] ?? '',
      tokenType: map['token_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLoginResponseModel.fromJson(String source) =>
      UserLoginResponseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserLoginResponseModel(user: $user, access_token: $accessToken, expires_in: $expiresIn, token_type: $tokenType)';
  }

  @override
  List<Object> get props => [
        user,
        expiresIn,
        tokenType,
        accessToken,
      ];
}


class UserModel {
  final int? id;
  final String? name;
  final String? userName;
  final String? email;
  final String? emailVerifiedAt;
  final String? forgetPasswordToken;
  final String? forgetPasswordOtp;
  final dynamic status;
  final String? providerId;
  final String? provider;
  final String? providerAvatar;
  final String? image;
  final String? phone;
  final String? address;
    String? verifyToken;
  final String? otpMailVerifyToken;
  final int? emailVerified;
  final String? designation;
  final String? aboutMe;
  // final String? facebook;
  final String? twitter;
  final String? linkedin;
  final String? instagram;
  final String? createdAt;
  final String? updatedAt;
  final int? kycStatus;
  final int? isAgency;
  final int? ownerId;

  UserModel({
    this.id,
    this.name,
    this.userName,
    this.email,
    this.emailVerifiedAt,
    this.forgetPasswordToken,
    this.forgetPasswordOtp,
    this.status,
    this.providerId,
    this.provider,
    this.providerAvatar,
    this.image,
    this.phone,
    this.address,
    this.verifyToken,
    this.otpMailVerifyToken,
    this.emailVerified,
    this.designation,
    this.aboutMe,
    // this.facebook,
    this.twitter,
    this.linkedin,
    this.instagram,
    this.createdAt,
    this.updatedAt,
    this.kycStatus,
    this.isAgency,
    this.ownerId,
  });

  // Factory method to create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      userName: json['user_name'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['email_verified_at'] as String?,
      forgetPasswordToken: json['forget_password_token'] as String?,
      forgetPasswordOtp: json['forget_password_otp'] as String?,
      status: json['status'],
      providerId: json['provider_id'] as String?,
      provider: json['provider'] as String?,
      providerAvatar: json['provider_avatar'] as String?,
      image: json['image'] as String?,
      phone: json['phone']?.toString(),
      address: json['address'] as String?,
      verifyToken: json['verify_token'] as String?,
      otpMailVerifyToken: json['otp_mail_verify_token'] as String?,
      emailVerified: json['email_verified'] as int?,
      designation: json['designation'] as String?,
      aboutMe: json['about_me'] as String?,
      // facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      linkedin: json['linkedin'] as String?,
      instagram: json['instagram'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      kycStatus: json['kyc_status'] as int?,
      isAgency: json['is_agency'] as int?,
      ownerId: json['owner_id'] as int?,
    );
  }

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'user_name': userName,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'forget_password_token': forgetPasswordToken,
      'forget_password_otp': forgetPasswordOtp,
      'status': status,
      'provider_id': providerId,
      'provider': provider,
      'provider_avatar': providerAvatar,
      'image': image,
      'phone': phone,
      'address': address,
      'verify_token': verifyToken,
      'otp_mail_verify_token': otpMailVerifyToken,
      'email_verified': emailVerified,
      'designation': designation,
      'about_me': aboutMe,
      // 'facebook': facebook,
      'twitter': twitter,
      'linkedin': linkedin,
      'instagram': instagram,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'kyc_status': kycStatus,
      'is_agency': isAgency,
      'owner_id': ownerId,
    };
  }
}

