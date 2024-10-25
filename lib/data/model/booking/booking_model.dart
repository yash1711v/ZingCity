// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../logic/cubit/booking/booking_cubit.dart';
import '../product/property_item_model.dart';

class BookingModel extends Equatable {
  final int id;
  final int propertyId;
  final int agentId;
  final int userId;
  final String bookingDate;
  final String bookingTime;
  final int guests;
  final String tempGuests;
  final String name;
  final String country;
  final String city;
  final String state;
  final String zipCode;
  final String email;
  final String phone;
  final String comment;
  final int status;
  int initialPage;
  bool isListEmpty;
  int initialPage2;
  bool isListEmpty2;
  bool isLoading;
  final List<int> tempComId;
  final PropertyItemModel? property;
  final BookingState bookState;

  BookingModel({
    required this.id,
    required this.propertyId,
    required this.agentId,
    required this.userId,
    required this.bookingDate,
    required this.bookingTime,
    required this.guests,
    required this.tempGuests,
    required this.name,
    required this.country,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.email,
    required this.phone,
    required this.comment,
    required this.status,
    required this.property,
    this.initialPage = 1,
    this.isListEmpty = false,
    this.initialPage2 = 1,
    this.isListEmpty2 = false,
    this.isLoading = true,
    this.tempComId = const <int>[],
    this.bookState = const BookingInitial(),
  });

  BookingModel copyWith({
    int? id,
    int? propertyId,
    int? agentId,
    int? userId,
    String? bookingDate,
    String? bookingTime,
    int? guests,
    String? tempGuests,
    String? name,
    String? country,
    String? city,
    String? state,
    String? zipCode,
    String? email,
    String? phone,
    String? comment,
    int? status,
    int? initialPage,
    bool? isListEmpty,
    int? initialPage2,
    bool? isListEmpty2,
    bool? isLoading,
    List<int>? tempComId,
    PropertyItemModel? property,
    BookingState? bookState,
  }) {
    return BookingModel(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      agentId: agentId ?? this.agentId,
      userId: userId ?? this.userId,
      bookingDate: bookingDate ?? this.bookingDate,
      bookingTime: bookingTime ?? this.bookingTime,
      guests: guests ?? this.guests,
      tempGuests: tempGuests ?? this.tempGuests,
      name: name ?? this.name,
      country: country ?? this.country,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      comment: comment ?? this.comment,
      status: status ?? this.status,
      initialPage: initialPage ?? this.initialPage,
      isListEmpty: isListEmpty ?? this.isListEmpty,
      initialPage2: initialPage2 ?? this.initialPage2,
      isListEmpty2: isListEmpty2 ?? this.isListEmpty2,
      isLoading: isLoading ?? this.isLoading,
      tempComId: tempComId ?? this.tempComId,
      property: property ?? this.property,
      bookState: bookState ?? this.bookState,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'property_id': state,
      'booking_date': bookingDate,
      'booking_time': bookingTime,
      'guests': tempGuests,
      'name': name,
      'city': city,
      'zip_code': zipCode,
      'phone': phone,
      'comment': comment,
    };
  }

  static BookingModel init() {
    return BookingModel(
      id: 0,
      propertyId: 0,
      agentId: 0,
      userId: 0,
      bookingDate: '',
      bookingTime: '',
      guests: 0,
      tempGuests: '',
      name: '',
      country: '',
      city: '',
      state: '',
      zipCode: '',
      email: '',
      phone: '',
      comment: '',
      status: 0,
      property: null,
      initialPage: 1,
      isListEmpty: false,
      initialPage2: 1,
      isListEmpty2: true,
      isLoading: false,
      tempComId: const <int>[],
      bookState: const BookingInitial(),
    );
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] ?? '',
      propertyId: map['property_id'] != null
          ? int.parse(map['property_id'].toString())
          : 0,
      agentId:
          map['agent_id'] != null ? int.parse(map['agent_id'].toString()) : 0,
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      bookingDate: map['booking_date'] ?? '',
      bookingTime: map['booking_time'] ?? '',
      guests: map['guests'] != null ? int.parse(map['guests'].toString()) : 0,
      name: map['name'] ?? '',
      tempGuests: map['temp_guests'] ?? '',
      country: map['country'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      zipCode: map['zip_code'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      comment: map['comment'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      property: map['property'] != null
          ? PropertyItemModel.fromMap(map['property'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      propertyId,
      agentId,
      userId,
      bookingDate,
      bookingTime,
      guests,
      tempGuests,
      name,
      country,
      city,
      state,
      zipCode,
      email,
      phone,
      comment,
      status,
      initialPage,
      isListEmpty,
      initialPage2,
      isListEmpty2,
      isLoading,
      tempComId,
      // property!,
      bookState,
    ];
  }
}
