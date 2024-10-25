import 'dart:convert';
import 'package:equatable/equatable.dart';

class AgencyListModel extends Equatable {
  final int id;
  final String name;
  final String userName;
  final String email;
  final String emailVerifiedAt;
  final String forgetPasswordToken;
  final String forgetPasswordOtp;
  final int status;
  final String providerId;
  final String provider;
  final String providerAvatar;
  final String image;
  final String phone;
  final String address;
  final String verifyToken;
  final String otpMailVerifyToken;
  final int emailVerified;
  final String designation;
  final String aboutMe;
  final String facebook;
  final String twitter;
  final String linkedin;
  final String instagram;
  final String createdAt;
  final String updatedAt;
  final int kycStatus;
  final int isAgency;
  final int ownerId;
  final Profile? profile;
  const AgencyListModel({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.emailVerifiedAt,
    required this.forgetPasswordToken,
    required this.forgetPasswordOtp,
    required this.status,
    required this.providerId,
    required this.provider,
    required this.providerAvatar,
    required this.image,
    required this.phone,
    required this.address,
    required this.verifyToken,
    required this.otpMailVerifyToken,
    required this.emailVerified,
    required this.designation,
    required this.aboutMe,
    required this.facebook,
    required this.twitter,
    required this.linkedin,
    required this.instagram,
    required this.createdAt,
    required this.updatedAt,
    required this.kycStatus,
    required this.isAgency,
    required this.ownerId,
    this.profile,
  });

  AgencyListModel copyWith({
    int? id,
    String? name,
    String? userName,
    String? email,
    String? emailVerifiedAt,
    String? forgetPasswordToken,
    String? forgetPasswordOtp,
    int? status,
    String? providerId,
    String? provider,
    String? providerAvatar,
    String? image,
    String? phone,
    String? address,
    String? verifyToken,
    String? otpMailVerifyToken,
    int? emailVerified,
    String? designation,
    String? aboutMe,
    String? facebook,
    String? twitter,
    String? linkedin,
    String? instagram,
    String? createdAt,
    String? updatedAt,
    int? kycStatus,
    int? isAgency,
    int? ownerId,
    Profile? profile,
  }) {
    return AgencyListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      forgetPasswordToken: forgetPasswordToken ?? this.forgetPasswordToken,
      forgetPasswordOtp: forgetPasswordOtp ?? this.forgetPasswordOtp,
      status: status ?? this.status,
      providerId: providerId ?? this.providerId,
      provider: provider ?? this.provider,
      providerAvatar: providerAvatar ?? this.providerAvatar,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      verifyToken: verifyToken ?? this.verifyToken,
      otpMailVerifyToken: otpMailVerifyToken ?? this.otpMailVerifyToken,
      emailVerified: emailVerified ?? this.emailVerified,
      designation: designation ?? this.designation,
      aboutMe: aboutMe ?? this.aboutMe,
      facebook: facebook ?? this.facebook,
      twitter: twitter ?? this.twitter,
      linkedin: linkedin ?? this.linkedin,
      instagram: instagram ?? this.instagram,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      kycStatus: kycStatus ?? this.kycStatus,
      isAgency: isAgency ?? this.isAgency,
      ownerId: ownerId ?? this.ownerId,
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'userName': userName,
      'email': email,
      'emailVerifiedAt': emailVerifiedAt,
      'forgetPasswordToken': forgetPasswordToken,
      'forgetPasswordOtp': forgetPasswordOtp,
      'status': status,
      'providerId': providerId,
      'provider': provider,
      'providerAvatar': providerAvatar,
      'image': image,
      'phone': phone,
      'address': address,
      'verifyToken': verifyToken,
      'otpMailVerifyToken': otpMailVerifyToken,
      'emailVerified': emailVerified,
      'designation': designation,
      'aboutMe': aboutMe,
      'facebook': facebook,
      'twitter': twitter,
      'linkedin': linkedin,
      'instagram': instagram,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'kycStatus': kycStatus,
      'isAgency': isAgency,
      'ownerId': ownerId,
      'profile': profile?.toMap(),
    };
  }

  factory AgencyListModel.fromMap(Map<String, dynamic> map) {
    return AgencyListModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      userName: map['user_name'] ?? '',
      email: map['email'] ?? '',
      emailVerifiedAt: map['email_verified_at'] ?? '',
      forgetPasswordToken: map['forget_password_token'] ?? '',
      forgetPasswordOtp: map['forget_password_otp'] ?? '',
      status: map['status'] ?? 0,
      providerId: map['provider_id'] ?? '',
      provider: map['provider'] ?? '',
      providerAvatar: map['provider_avatar'] ?? '',
      image: map['image'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      verifyToken: map['verify_token'] ?? '',
      otpMailVerifyToken: map['otp_mail_verify_token'] ?? '',
      emailVerified: map['email_verified'] ?? 0,
      designation: map['designation'] ?? '',
      aboutMe: map['about_me'] ?? '',
      facebook: map['facebook'] ?? '',
      twitter: map['twitter'] ?? '',
      linkedin: map['linkedin'] ?? '',
      instagram: map['instagram'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      kycStatus: map['kyc_status'] ?? 0,
      isAgency: map['is_agency'] ?? 0,
      ownerId: map['owner_id'] ?? 0,
      profile: map['profile'] != null ? Profile.fromMap(map['profile'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AgencyListModel.fromJson(String source) => AgencyListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      userName,
      email,
      emailVerifiedAt,
      forgetPasswordToken,
      forgetPasswordOtp,
      status,
      providerId,
      provider,
      providerAvatar,
      image,
      phone,
      address,
      verifyToken,
      otpMailVerifyToken,
      emailVerified,
      designation,
      aboutMe,
      facebook,
      twitter,
      linkedin,
      instagram,
      createdAt,
      updatedAt,
      kycStatus,
      isAgency,
      ownerId,
      profile,
    ];
  }
}

class Profile extends Equatable {
  final int id;
  final int userId;
  final String companyName;
  final String tagLine;
  final String aboutUs;
  final String email;
  final String phone;
  final String image;
  final String facebook;
  final String twitter;
  final String linkedin;
  final String instagram;
  final String createdAt;
  final String updatedAt;
  final int isApproved;
  final String address;
  final int kycId;
  final String file;
  final String message;
  const Profile({
    required this.id,
    required this.userId,
    required this.companyName,
    required this.tagLine,
    required this.aboutUs,
    required this.email,
    required this.phone,
    required this.image,
    required this.facebook,
    required this.twitter,
    required this.linkedin,
    required this.instagram,
    required this.createdAt,
    required this.updatedAt,
    required this.isApproved,
    required this.address,
    required this.kycId,
    required this.file,
    required this.message,
  });

  Profile copyWith({
    int? id,
    int? userId,
    String? companyName,
    String? tagLine,
    String? aboutUs,
    String? email,
    String? phone,
    String? image,
    String? facebook,
    String? twitter,
    String? linkedin,
    String? instagram,
    String? createdAt,
    String? updatedAt,
    int? isApproved,
    String? address,
    int? kycId,
    String? file,
    String? message,
  }) {
    return Profile(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      companyName: companyName ?? this.companyName,
      tagLine: tagLine ?? this.tagLine,
      aboutUs: aboutUs ?? this.aboutUs,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      facebook: facebook ?? this.facebook,
      twitter: twitter ?? this.twitter,
      linkedin: linkedin ?? this.linkedin,
      instagram: instagram ?? this.instagram,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isApproved: isApproved ?? this.isApproved,
      address: address ?? this.address,
      kycId: kycId ?? this.kycId,
      file: file ?? this.file,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'company_name': companyName,
      'tag_line': tagLine,
      'about_us': aboutUs,
      'email': email,
      'phone': phone,
      'image': image,
      'facebook': facebook,
      'twitter': twitter,
      'linkedin': linkedin,
      'instagram': instagram,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'is_approved': isApproved,
      'address': address,
      'kyc_id': kycId,
      'file': file,
      'message': message,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'] ?? 0,
      userId: map['user_id'] ?? 0,
      companyName: map['company_name'] ?? '',
      tagLine: map['tag_line'] ?? '',
      aboutUs: map['about_us'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      image: map['image'] ?? '',
      facebook: map['facebook'] ?? '',
      twitter: map['twitter'] ?? '',
      linkedin: map['linkedin'] ?? '',
      instagram: map['instagram'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      isApproved: map['is_approved'] ?? 0,
      address: map['address'] ?? '',
      kycId: map['kyc_id'] ?? 0,
      file: map['file'] ?? '',
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) => Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      userId,
      companyName,
      tagLine,
      aboutUs,
      email,
      phone,
      image,
      facebook,
      twitter,
      linkedin,
      instagram,
      createdAt,
      updatedAt,
      isApproved,
      address,
      kycId,
      file,
      message,
    ];
  }
}
