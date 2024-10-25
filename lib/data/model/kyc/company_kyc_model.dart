// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';



class KycListModel extends Equatable {
  final int id;
  final String name;
  final int status;
  final String createdAt;
  final String updatedAt;
  const KycListModel({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  KycListModel copyWith({
    int? id,
    String? name,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return KycListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory KycListModel.fromMap(Map<String, dynamic> map) {
    return KycListModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      status: map['status'] != null ? int.parse( map['status'].toString()) : 0,
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory KycListModel.fromJson(String source) => KycListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
