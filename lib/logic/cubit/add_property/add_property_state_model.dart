import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../data/model/add_property_model.dart';
import '../../../data/model/agency/agency_details_model.dart';
import '../../../data/model/create_property/additional_info_dto.dart';
import '../../../data/model/create_property/edit_info/existing_slider.dart';
import '../../../data/model/create_property/nearest_location_dto.dart';
import '../../../data/model/create_property/property_images_dto.dart';
import '../../../data/model/create_property/property_location.dart';
import '../../../data/model/create_property/property_plan_dto.dart';
import '../../../data/model/create_property/property_video_dto.dart';
import '../../../data/model/home/home_data_model.dart';
import '../../../data/model/product/nearest_location_model.dart';
import '../../../state_inject_package_names.dart';
import 'add_property_cubit.dart';

class AddPropertyModel extends Equatable {
  final String title;
  final String slug;
  final String typeId;
  final String? possessionStatus;
  final String? propertyType;
  final String? propertyTypeId;
  final String type;
  final String purpose;
  final String rentPeriod;
  final String roomType;
  final String price;
  final String image;
  final String tempImage;
  final List<ExistingSlider> galleryImage;
  final List<File> sliderImages;
  final String thumbNailImage;
  final String totalArea;
  final String totalUnit;
  final String totalBedroom;
  final String totalBathroom;
  final String totalBalcony;
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
  final String cityId;
  final String stateId;
  final String categoryId;
  final List<String> distance;
  final List<String> nearestLocation;
  final PropertyImageDto propertyImageDto;
  final PropertyVideoDto propertyVideoDto;
  final PropertyLocationDto propertyLocationDto;
  final List<String> aminities;
  final List<NearestLocationDto> nearestLocationList;
  final List<Properties>? properties;

  final List<NearestLocationModel> locationModel;
  final List<AdditionalInfoDto> addtionalInfoList;
  final List<PropertyPlanDto> propertyPlanDto;
  final String seoTitle;
  final String seoMetaDescription;
  final AddPropertyState addState;
  final PropertyTypeResponse? staticInfo;
  final List<String>? sliderImagesApi;
  final String? thumbNailImageApi;
  final List<String>? additionalKeys;
  final List<String>? additionalValues;

  final String? furnished;
  final String? roomTypeId;
  final String? elevator;

  const AddPropertyModel({
    this.title = '',
    this.elevator = '',
    this.slug = '',
    this.typeId = '',
    this.possessionStatus = '',
    this.additionalKeys = const [],
    this.additionalValues = const [],
    this.furnished = '',
    this.roomType = '',
    this.roomTypeId = '',
    this.type = '',
    this.purpose = 'buy',
    this.rentPeriod = '',
    this.price = '',
    this.tempImage = '',
    this.image = '',
    this.galleryImage = const <ExistingSlider>[],
    this.totalArea = '',
    this.totalBalcony = '',
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
    this.state = 'Punjab',
    this.country = 'India',
    this.address = '',
    this.cityId = '',
    this.stateId = '20',
    this.categoryId = '',
    this.distance = const [],
    this.sliderImages = const [],
    this.thumbNailImage = '',
    this.properties = const [],
    this.nearestLocation = const [],
    this.propertyType,
    this.propertyTypeId,
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
    this.sliderImagesApi = const [],
    this.thumbNailImageApi = '',
  });

  AddPropertyModel copyWith({
    String? title,
    String? slug,
    String? typeId,
    String? possessionStatus,
    String? type,
    String? purpose,
    String? furnished,
    String? rentPeriod,
    String? price,
    String? image,
    String? tempImage,
    List<ExistingSlider>? galleryImage,
    String? totalArea,
    String? totalUnit,
    String? totalBedroom,
    String? totalBathroom,
    List<String>? additionalKeys,
    List<String>? additionalValues,
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
    List<String>? aminities,
    List<Properties>? properties,
    List<NearestLocationDto>? nearestLocationList,
    List<NearestLocationModel>? locationModel,
    List<AdditionalInfoDto>? addtionalInfoList,
    List<PropertyPlanDto>? propertyPlanDto,
    String? seoTitle,
    String? seoMetaDescription,
    AddPropertyState? addState,
    PropertyTypeResponse? staticInfo,
    String? city,
    String? elevator,
    String? state,
    String? country,
    String? address,
    String? roomType,
    String? roomTypeId,
    String? cityId,
    String? stateId,
    String? propertyType,
    String? propertyTypeId,
    String? categoryId,
    List<String>? distance,
    List<String>? nearestLocation,
    List<File>? sliderImages,
    String? thumbNailImage,
    List<String>? sliderImagesApi,
    String? thumbNailImageApi,
    String? totalBalcony,
  }) {
    return AddPropertyModel(
      title: title ?? this.title,
      slug: slug ?? this.slug,
      typeId: typeId ?? this.typeId,
      possessionStatus: possessionStatus ?? this.possessionStatus,
      roomTypeId: roomTypeId ?? this.roomTypeId,
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
      elevator: elevator ?? this.elevator,
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
      furnished: furnished ?? this.furnished,
      address: address ?? this.address,
      staticInfo: staticInfo ?? this.staticInfo,
      roomType: roomType ?? this.roomType,
      cityId: cityId ?? this.cityId,
      stateId: stateId ?? this.stateId,
      categoryId: categoryId ?? this.categoryId,
      distance: distance ?? this.distance,
      nearestLocation: nearestLocation ?? this.nearestLocation,
      sliderImages: sliderImages ?? this.sliderImages,
      thumbNailImage: thumbNailImage ?? this.thumbNailImage,
      properties: properties ?? this.properties,
      sliderImagesApi: sliderImagesApi ?? this.sliderImagesApi,
      thumbNailImageApi: thumbNailImageApi ?? this.thumbNailImageApi,
      propertyType: propertyType ?? this.propertyType,
      propertyTypeId: propertyTypeId ?? this.propertyTypeId,
      totalBalcony: totalBalcony ?? this.totalBalcony,
      additionalKeys: additionalKeys ?? this.additionalKeys,
      additionalValues: additionalValues ?? this.additionalValues,
    );
  }

  Map<String, String> toMap() {
    final result = <String, String>{};

    // Basic details
    result['title'] = title;
    result['slug'] = slug;
    result['property_type_id'] = typeId;
    result['purpose'] = purpose;
    result['rent_period'] = rentPeriod;
    result['price'] = price;
    result['total_area'] = totalArea;
    result['total_unit'] = totalUnit;
    result['total_bedroom'] = totalBedroom;
    result['total_bathroom'] = totalBathroom;
    result['total_garage'] = totalGarage;
    result['total_kitchen'] = totalKitchen;
    result['description'] = description;
    result['elevator'] = elevator ?? "";
    result['status'] = status;
    result['totalBalcony'] = isFeatured;
    result['roomTypeId'] = roomTypeId ?? "";

    // Property images and videos
    result['video_id'] = propertyVideoDto.videoId;
    result['video_description'] = propertyVideoDto.videoDescription;

    // Property location details
    result['city_id'] = cityId.toString();
    result['address'] = propertyLocationDto.address;
    result['address_description'] = propertyLocationDto.addressDescription;
    result['google_map'] = propertyLocationDto.googleMap;

    // Amenities
    for (var i = 0; i < aminities.length; i++) {
      result['aminities[$i]'] = aminities[i].toString();
    }

    // Nearest locations
    for (var i = 0; i < nearestLocationList.length; i++) {
      final location = nearestLocationList[i];
      if (location.id > 0) {
        // Existing nearest locations
        result['existing_nearest_ids[$i]'] = location.id.toString();
        result['existing_nearest_locations[$i]'] =
            location.locationId.toString();
        result['existing_distances[$i]'] = location.distances;
      } else if (location.locationId.toString().isNotEmpty &&
          location.distances.isNotEmpty) {
        // New nearest locations
        result['nearest_locations[$i]'] = location.locationId.toString();
        result['distances[$i]'] = location.distances;
      }
    }

    // Additional info
    for (var i = 0; i < addtionalInfoList.length; i++) {
      final info = addtionalInfoList[i];
      if (info.id > 0) {
        // Existing additional info
        result['existing_add_ids[$i]'] = info.id.toString();
        result['existing_add_keys[$i]'] = info.addKeys;
        result['existing_add_values[$i]'] = info.addValues;
      } else if (info.addKeys.isNotEmpty && info.addValues.isNotEmpty) {
        // New additional info
        result['add_keys[$i]'] = info.addKeys;
        result['add_values[$i]'] = info.addValues;
      }
    }

    // Property plans
    for (var i = 0; i < propertyPlanDto.length; i++) {
      final plan = propertyPlanDto[i];
      if (plan.id > 0) {
        // Existing property plans
        result['existing_plan_ids[$i]'] = plan.id.toString();
        result['existing_plan_titles[$i]'] = plan.planTitles;
        result['existing_plan_descriptions[$i]'] = plan.planDescriptions;
      } else if (plan.planTitles.isNotEmpty &&
          plan.planDescriptions.isNotEmpty) {
        // New property plans
        result['plan_titles[$i]'] = plan.planTitles;
        result['plan_descriptions[$i]'] = plan.planDescriptions;
      }
    }

    // SEO metadata
    result['seo_title'] = seoTitle;
    result['seo_meta_description'] = seoMetaDescription;
    result["possession_status"] = possessionStatus ?? "";

    return result;
  }

  factory AddPropertyModel.fromMap(Map<String, dynamic> map) {
    return AddPropertyModel(
      title: map['title'] ?? "",
      slug: map['slug'] ?? "",
      typeId: map['typeId'] as String,
      possessionStatus: map['possession_status'].toString(),
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
      roomTypeId: map['roomTypeId'] ?? "",
      isFeatured: map['is_featured'] ?? "",
      isTop: map['is_top'] ?? "",
      isUrgent: map['is_urgent'] ?? "",
      totalBalcony: map['totalBalcony'] ?? "",
      propertyImageDto: PropertyImageDto.fromMap(
          map['propertyImageDto'] as Map<String, dynamic>),
      propertyVideoDto: PropertyVideoDto.fromMap(
          map['propertyVideoDto'] as Map<String, dynamic>),
      propertyLocationDto: PropertyLocationDto.fromMap(
          map['propertyLocationDto'] as Map<String, dynamic>),
      aminities: List<String>.from((map['aminities'] as List<String>)),
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
      propertyType: map['propertyType'] as String,
      propertyTypeId: map['propertyTypeId'] as String,
      elevator: map['elevator'] as String,
      additionalKeys: List<String>.from(map['add_keys'] as List<String>),
      additionalValues: List<String>.from(map['add_values'] as List<String>),
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
      roomType,
      cityId,
      stateId,
      categoryId,
      distance,
      nearestLocation,
      sliderImages,
      thumbNailImage,
      properties,
      sliderImagesApi,
      propertyType,
      propertyTypeId,
      totalBalcony,
      furnished,
      elevator,
      roomTypeId,
      additionalKeys,
      additionalValues,
      possessionStatus
    ];
  }
}
