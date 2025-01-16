import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../data/model/add_property_model.dart';
import '../../../data/model/create_property/additional_info_dto.dart';
import '../../../data/model/create_property/edit_info/existing_slider.dart';
import '../../../data/model/create_property/nearest_location_dto.dart';
import '../../../data/model/create_property/property_images_dto.dart';
import '../../../data/model/create_property/property_location.dart';
import '../../../data/model/create_property/property_plan_dto.dart';
import '../../../data/model/create_property/property_video_dto.dart';
import '../../../data/model/product/nearest_location_model.dart';
import '../../../state_inject_package_names.dart';
import 'add_property_cubit.dart';

class AddPropertyModel extends Equatable {
  final String title;
  final String slug;
  final String typeId;
  final String type;
  final String purpose;
  final String rentPeriod;
  final String price;
  final String image;
  final String tempImage;
  final List<ExistingSlider> galleryImage;
  final String totalArea;
  final String totalUnit;
  final String totalBedroom;
  final String totalBathroom;
  final String totalGarage;
  final String totalKitchen;
  final String description;
  final String status;
  final String isFeatured;
  final String isTop;
  final String isUrgent;
  final String city;
  final String state;
  final String country;
  final String address;
  final PropertyImageDto propertyImageDto;
  final PropertyVideoDto propertyVideoDto;
  final PropertyLocationDto propertyLocationDto;
  final List<int> aminities;
  final List<NearestLocationDto> nearestLocationList;

  final List<NearestLocationModel> locationModel;
  final List<AdditionalInfoDto> addtionalInfoList;
  final List<PropertyPlanDto> propertyPlanDto;
  final String seoTitle;
  final String seoMetaDescription;
  final AddPropertyState addState;
  final PropertyTypeResponse? staticInfo;

  const AddPropertyModel({
    this.title = '',
    this.slug = '',
    this.typeId = '',
    this.type = '',
    this.purpose = '',
    this.rentPeriod = '',
    this.price = '',
    this.tempImage = '',
    this.image = '',
    this.galleryImage = const <ExistingSlider>[],
    this.totalArea = '',
    this.totalUnit = '',
    this.totalBedroom = '',
    this.totalBathroom = '',
    this.totalGarage = '',
    this.totalKitchen = '',
    this.description = '',
    this.status = '',
    this.isFeatured = '',
    this.isTop = '',
    this.isUrgent = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.address = '',
    this.propertyImageDto =
        const PropertyImageDto(sliderImages: [], thumbnailImage: ''),
    this.propertyVideoDto = const PropertyVideoDto(
        videoDescription: '', videoId: '', videoThumbnail: ''),
    this.propertyLocationDto = const PropertyLocationDto(
        cityId: 0, address: '', addressDescription: '', googleMap: ''),
    this.aminities = const [],
    this.nearestLocationList = const [],
    this.locationModel = const [],
    this.addtionalInfoList = const [],
    this.propertyPlanDto = const [],
    this.seoTitle = '',
    this.seoMetaDescription = '',
    this.addState = const AddPropertyInitial(),
    this.staticInfo,
  });

  AddPropertyModel copyWith({
    String? title,
    String? slug,
    String? typeId,
    String? type,
    String? purpose,
    String? rentPeriod,
    String? price,
    String? image,
    String? tempImage,
    List<ExistingSlider>? galleryImage,
    String? totalArea,
    String? totalUnit,
    String? totalBedroom,
    String? totalBathroom,
    String? totalGarage,
    String? totalKitchen,
    String? description,
    String? status,
    String? isFeatured,
    String? isTop,
    String? isUrgent,
    PropertyImageDto? propertyImageDto,
    PropertyVideoDto? propertyVideoDto,
    PropertyLocationDto? propertyLocationDto,
    List<int>? aminities,
    List<NearestLocationDto>? nearestLocationList,
    List<NearestLocationModel>? locationModel,
    List<AdditionalInfoDto>? addtionalInfoList,
    List<PropertyPlanDto>? propertyPlanDto,
    String? seoTitle,
    String? seoMetaDescription,
    AddPropertyState? addState,
    PropertyTypeResponse? staticInfo,
     String? city,
     String? state,
     String? country,
     String? address,
  }) {
    return AddPropertyModel(
      title: title ?? this.title,
      slug: slug ?? this.slug,
      typeId: typeId ?? this.typeId,
      type: type ?? this.type,
      purpose: purpose ?? this.purpose,
      rentPeriod: rentPeriod ?? this.rentPeriod,
      price: price ?? this.price,
      image: image ?? this.image,
      tempImage: tempImage ?? this.tempImage,
      galleryImage: galleryImage ?? this.galleryImage,
      totalArea: totalArea ?? this.totalArea,
      totalUnit: totalUnit ?? this.totalUnit,
      totalBedroom: totalBedroom ?? this.totalBedroom,
      totalBathroom: totalBathroom ?? this.totalBathroom,
      totalGarage: totalGarage ?? this.totalGarage,
      totalKitchen: totalKitchen ?? this.totalKitchen,
      description: description ?? this.description,
      status: status ?? this.status,
      isFeatured: isFeatured ?? this.isFeatured,
      isTop: isTop ?? this.isTop,
      isUrgent: isUrgent ?? this.isUrgent,
      propertyImageDto: propertyImageDto ?? this.propertyImageDto,
      propertyVideoDto: propertyVideoDto ?? this.propertyVideoDto,
      propertyLocationDto: propertyLocationDto ?? this.propertyLocationDto,
      aminities: aminities ?? this.aminities,
      nearestLocationList: nearestLocationList ?? this.nearestLocationList,
      locationModel: locationModel ?? this.locationModel,
      addtionalInfoList: addtionalInfoList ?? this.addtionalInfoList,
      propertyPlanDto: propertyPlanDto ?? this.propertyPlanDto,
      seoTitle: seoTitle ?? this.seoTitle,
      seoMetaDescription: seoMetaDescription ?? this.seoMetaDescription,
      addState: addState ?? this.addState,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      address: address ?? this.address,
      staticInfo: staticInfo ?? this.staticInfo,
    );
  }

  Map<String, String> toMap() {
    final result = <String, String>{};
    // return <String, dynamic>{
    result.addAll({'title': title});
    result.addAll({'slug': slug});
    result.addAll({'property_type_id': typeId});
    result.addAll({'purpose': purpose});
    result.addAll({'rent_period': rentPeriod});
    result.addAll({'price': price});
    result.addAll({'total_area': totalArea});
    result.addAll({'total_unit': totalUnit});
    result.addAll({'total_bedroom': totalBedroom});
    result.addAll({'total_bathroom': totalBathroom});
    result.addAll({'total_garage': totalGarage});
    result.addAll({'total_kitchen': totalKitchen});
    result.addAll({'description': description});
    result.addAll({'status': description});

    // if (isFeatured.isNotEmpty) {
    //   print('this is isFeatured $isFeatured');
    //   result.addAll({'is_featured': isFeatured});
    // }
    // if (isTop.isNotEmpty) {
    //   result.addAll({'is_top': isTop});
    // }
    // if (isUrgent.isNotEmpty) {
    //   result.addAll({'is_urgent': isUrgent});
    // }

    // result.addAll({'thumbnail_image': propertyImageDto!.toMap()});

    result.addAll({'video_id': propertyVideoDto.videoId});
    result.addAll({'video_description': propertyVideoDto.videoDescription});

    result.addAll({'city_id': propertyLocationDto.cityId.toString()});
    result.addAll({'address': propertyLocationDto.address});
    result.addAll(
        {'address_description': propertyLocationDto.addressDescription});
    result.addAll({'google_map': propertyLocationDto.googleMap});

    if (aminities.isNotEmpty) {
      for (var i = 0; i < aminities.length; i++) {
        result.addAll({'aminities[$i]': aminities[i].toString()});
      }
    }
    if (nearestLocationList.isNotEmpty) {
      for (var i = 0; i < nearestLocationList.length; i++) {
        // We are checking if ID exists or not to filter existing nearest data.
        if (nearestLocationList[i].id > 0) {
          debugPrint('old-location ${nearestLocationList[i]}');
          result.addAll({
            'existing_nearest_ids[$i]': nearestLocationList[i].id.toString()
          });
          result.addAll({
            'existing_nearest_locations[$i]':
                nearestLocationList[i].locationId.toString()
          });
          result.addAll(
              {'existing_distances[$i]': nearestLocationList[i].distances});
        } else {
          if (nearestLocationList[i].locationId.toString().isNotEmpty &&
              nearestLocationList[i].distances.isNotEmpty) {
            debugPrint('new-location ${nearestLocationList[i]}');
            result.addAll({
              'nearest_locations[$i]':
                  nearestLocationList[i].locationId.toString()
            });
            result.addAll({'distances[$i]': nearestLocationList[i].distances});
          }
        }
      }
    }

    if (addtionalInfoList.isNotEmpty) {
      for (var i = 0; i < addtionalInfoList.length; i++) {
        // We are checking if ID exists or not to filter Additional Info data.
        if (addtionalInfoList[i].id > 0) {
          result.addAll(
              {'existing_add_ids[$i]': addtionalInfoList[i].id.toString()});
          result
              .addAll({'existing_add_keys[$i]': addtionalInfoList[i].addKeys});
          result.addAll(
              {'existing_add_values[$i]': addtionalInfoList[i].addValues});
        } else {
          if (addtionalInfoList[i].addKeys.isNotEmpty &&
              addtionalInfoList[i].addValues.isNotEmpty) {
            result.addAll({'add_keys[$i]': addtionalInfoList[i].addKeys});
            result.addAll({'add_values[$i]': addtionalInfoList[i].addValues});
          }
        }
      }
    }

    if (propertyPlanDto.isNotEmpty) {
      for (var i = 0; i < propertyPlanDto.length; i++) {
        // We are checking if ID exists or not to filter Plan data.
        if (propertyPlanDto[i].id > 0) {
          final plan = propertyPlanDto[i];
          if (plan.id.toString().isNotEmpty) {
            result.addAll(
                {'existing_plan_ids[$i]': propertyPlanDto[i].id.toString()});
          }
          if (plan.planTitles.isNotEmpty) {
            result.addAll(
                {'existing_plan_titles[$i]': propertyPlanDto[i].planTitles});
          }

          if (plan.planDescriptions.isNotEmpty) {
            result.addAll({
              'existing_plan_descriptions[$i]':
                  propertyPlanDto[i].planDescriptions
            });
          }
        } else {
          if (propertyPlanDto[i].planTitles.isNotEmpty &&
              propertyPlanDto[i].planDescriptions.isNotEmpty) {
            result.addAll({'plan_titles[$i]': propertyPlanDto[i].planTitles});
            result.addAll(
                {'plan_descriptions[$i]': propertyPlanDto[i].planDescriptions});
            //result.addAll({'images[$i]': propertyPlanDto[i].planImages});
          }
        }
      }
    }

    result.addAll({'seo_title': seoTitle});
    result.addAll({'seo_meta_description': seoMetaDescription});
    return result;
  }

  factory AddPropertyModel.fromMap(Map<String, dynamic> map) {
    return AddPropertyModel(
      title: map['title'] ?? "",
      slug: map['slug'] ?? "",
      typeId: map['typeId'] as String,
      type: map['type'] as String,
      purpose: map['purpose'] ?? "",
      rentPeriod: map['rentPeriod'] ?? "",
      price: map['price'] ?? "",
      totalArea: map['totalArea'] as String,
      totalUnit: map['totalUnit'] as String,
      totalBedroom: map['totalBedroom'] as String,
      totalBathroom: map['totalBathroom'] as String,
      totalGarage: map['totalGarage'] as String,
      totalKitchen: map['totalKitchen'] as String,
      description: map['description'] ?? "",
      status: map['status'] ?? "",
      isFeatured: map['is_featured'] ?? "",
      isTop: map['is_top'] ?? "",
      isUrgent: map['is_urgent'] ?? "",
      propertyImageDto: PropertyImageDto.fromMap(
          map['propertyImageDto'] as Map<String, dynamic>),
      propertyVideoDto: PropertyVideoDto.fromMap(
          map['propertyVideoDto'] as Map<String, dynamic>),
      propertyLocationDto: PropertyLocationDto.fromMap(
          map['propertyLocationDto'] as Map<String, dynamic>),
      aminities: List<int>.from((map['aminities'] as List<int>)),
      nearestLocationList: List<NearestLocationDto>.from(
        (map['nearestLocationList'] as List<String>).map<NearestLocationDto>(
          (x) => NearestLocationDto.fromMap(x as Map<String, dynamic>),
        ),
      ),
      addtionalInfoList: List<AdditionalInfoDto>.from(
        (map['addtionalInfoList'] as List<String>).map<AdditionalInfoDto>(
          (x) => AdditionalInfoDto.fromMap(x as Map<String, dynamic>),
        ),
      ),
      propertyPlanDto: List<PropertyPlanDto>.from(
        (map['propertyPlanDto'] as List<String>).map<PropertyPlanDto>(
          (x) => PropertyPlanDto.fromMap(x as Map<String, dynamic>),
        ),
      ),
      seoTitle: map['seoTitle'] ?? "",
      seoMetaDescription: map['seoMetaDescription'] ?? "",
      staticInfo: map['staticInfo'] as PropertyTypeResponse,

    );
  }

  String toJson() => json.encode(toMap());

  factory AddPropertyModel.fromJson(String source) =>
      AddPropertyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      title,
      slug,
      typeId,
      type,
      purpose,
      rentPeriod,
      price,
      image,
      tempImage,
      galleryImage,
      totalArea,
      totalUnit,
      totalBedroom,
      totalBathroom,
      totalGarage,
      totalKitchen,
      description,
      status,
      isFeatured,
      isTop,
      isUrgent,
      propertyImageDto,
      propertyVideoDto,
      propertyLocationDto,
      aminities,
      nearestLocationList,
      locationModel,
      addtionalInfoList,
      propertyPlanDto,
      seoTitle,
      seoMetaDescription,
      addState,
      state,
      city,
      country,
      address,
      staticInfo,
    ];
  }
}
