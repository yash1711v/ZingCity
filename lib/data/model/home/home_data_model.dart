import '../product/aminit_model.dart';
import '../product/slider_image_model.dart';

class HomeDataModel {
  PropertyType? propertyType;
  List<BannerImage>? bannerImage;
  List<PropertyFeatured>? propertyFeatured;
  List<LatestProperties>? latestProperties;
  List<Properties>? properties;

  HomeDataModel(
      {this.propertyType,
        this.bannerImage,
        this.propertyFeatured,
        this.latestProperties,
        this.properties});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    propertyType = json['property_type'] != null
        ? new PropertyType.fromJson(json['property_type'])
        : null;
    if (json['banner_image '] != null) {
      bannerImage = <BannerImage>[];
      json['banner_image '].forEach((v) {
        bannerImage!.add(new BannerImage.fromJson(v));
      });
    }
    if (json['property_featured'] != null) {
      propertyFeatured = <PropertyFeatured>[];
      json['property_featured'].forEach((v) {
        propertyFeatured!.add(new PropertyFeatured.fromJson(v));
      });
    }
    if (json['latestProperties'] != null) {
      latestProperties = <LatestProperties>[];
      json['latestProperties'].forEach((v) {
        latestProperties!.add(new LatestProperties.fromJson(v));
      });
    }
    if (json['properties'] != null) {
      properties = <Properties>[];
      json['properties'].forEach((v) {
        properties!.add(new Properties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.propertyType != null) {
      data['property_type'] = this.propertyType!.toJson();
    }
    if (this.bannerImage != null) {
      data['banner_image '] = this.bannerImage!.map((v) => v.toJson()).toList();
    }
    if (this.propertyFeatured != null) {
      data['property_featured'] =
          this.propertyFeatured!.map((v) => v.toJson()).toList();
    }
    if (this.latestProperties != null) {
      data['latestProperties'] =
          this.latestProperties!.map((v) => v.toJson()).toList();
    }
    if (this.properties != null) {
      data['properties'] = this.properties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PropertyType {
  String? buy;
  String? rent;

  PropertyType({this.buy, this.rent});

  PropertyType.fromJson(Map<String, dynamic> json) {
    buy = json['buy'];
    rent = json['rent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buy'] = this.buy;
    data['rent'] = this.rent;
    return data;
  }
}

class BannerImage {
  int? id;
  String? location;
  int? imageType;
  String? image;
  String? createdAt;
  String? updatedAt;

  BannerImage(
      {this.id,
        this.location,
        this.imageType,
        this.image,
        this.createdAt,
        this.updatedAt});

  BannerImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    imageType = json['image_type'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location'] = this.location;
    data['image_type'] = this.imageType;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PropertyFeatured {
  int? id;
  int? agentId;
  int? propertyTypeId;
  String? categoryId;
  int? stateId;
  String? title;
  String? slug;
  String? purpose;
  String? rentPeriod;
  int? price;
  String? thumbnailImage;
  String? description;
  String? videoDescription;
  String? videoThumbnail;
  String? videoId;
  String? address;
  String? addressDescription;
  String? googleMap;
  String? totalArea;
  String? totalUnit;
  String? totalBedroom;
  String? totalBathroom;
  String? totalGarage;
  String? totalKitchen;
  String? isFeatured;
  String? isTop;
  String? isUrgent;
  String? status;
  String? bhkType;
  String? expiredDate;
  String? seoTitle;
  String? seoMetaDescription;
  int? serial;
  String? showSlider;
  String? approveByAdmin;
  String? createdAt;
  String? updatedAt;
  String? dateFrom;
  String? dateTo;
  String? timeFrom;
  String? timeTo;
  int? countryId;
  String? lat;
  String? lon;
  int? possessionStatus;
  int? cityId;
  int? totalRating;
  List<SliderImage>? sliders;
  String? ratingAvarage;
  List<AminityItemDto>? aminityItemDto;

  PropertyFeatured(
      {this.id,
        this.agentId,
        this.propertyTypeId,
        this.stateId,
        this.title,
        this.slug,
        this.categoryId,
        this.purpose,
        this.rentPeriod,
        this.price,
        this.thumbnailImage,
        this.description,
        this.videoDescription,
        this.videoThumbnail,
        this.videoId,
        this.address,
        this.addressDescription,
        this.googleMap,
        this.totalArea,
        this.totalUnit,
        this.totalBedroom,
        this.totalBathroom,
        this.totalGarage,
        this.totalKitchen,
        this.isFeatured,
        this.isTop,
        this.isUrgent,
        this.status,
        this.bhkType,
        this.expiredDate,
        this.seoTitle,
        this.seoMetaDescription,
        this.serial,
        this.showSlider,
        this.approveByAdmin,
        this.createdAt,
        this.updatedAt,
        this.dateFrom,
        this.dateTo,
        this.timeFrom,
        this.timeTo,
        this.countryId,
        this.lat,
        this.lon,
        this.possessionStatus,
        this.cityId,
        this.totalRating,
        this.sliders,
        this.aminityItemDto,
        this.ratingAvarage});

  PropertyFeatured.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agentId = json['agent_id'];
    propertyTypeId = json['property_type_id'];
    stateId = json['state_id'];
    title = json['title'];
    slug = json['slug'];
    purpose = json['purpose'];
    categoryId = json['category_id'].toString();
    rentPeriod = json['rent_period'];
    price = json['price'];
    thumbnailImage = json['thumbnail_image'];
    description = json['description'];
    videoDescription = json['video_description'];
    videoThumbnail = json['video_thumbnail'];
    videoId = json['video_id'];
    address = json['address'];
    addressDescription = json['address_description'];
    googleMap = json['google_map'];
    totalArea = json['total_area'];
    totalUnit = json['total_unit'];
    totalBedroom = json['total_bedroom'];
    totalBathroom = json['total_bathroom'];
    totalGarage = json['total_garage'];
    totalKitchen = json['total_kitchen'];
    isFeatured = json['is_featured'];
    isTop = json['is_top'];
    isUrgent = json['is_urgent'];
    status = json['status'];
    bhkType = json['bhk_type'];
    expiredDate = json['expired_date'];
    seoTitle = json['seo_title'];
    seoMetaDescription = json['seo_meta_description'];
    serial = json['serial'];
    showSlider = json['show_slider'];
    approveByAdmin = json['approve_by_admin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    countryId = json['country_id'];
    lat = json['lat'];
    lon = json['lon'];
    possessionStatus = json['possession_status'];
    cityId = json['city_id'];
    totalRating = json['totalRating'];
    ratingAvarage = json['ratingAvarage'];
    sliders = json['slider_image'] != null
        ? (json['slider_image'] as List)
        .map((i) => i is Map<String,dynamic>?SliderImage.fromMap(i):SliderImage.fromJson(i))
        .toList()
        : [];
    if (json['aminities'] != null) {
      aminityItemDto = <AminityItemDto>[];
      json['aminities'].forEach((v) {
        aminityItemDto!.add(new AminityItemDto.fromMap(v));
      });
    } else {
      aminityItemDto = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['agent_id'] = this.agentId;
    data['property_type_id'] = this.propertyTypeId;
    data['state_id'] = this.stateId;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['purpose'] = this.purpose;
    data['rent_period'] = this.rentPeriod;
    data['price'] = this.price;
    data['thumbnail_image'] = this.thumbnailImage;
    data['description'] = this.description;
    data['video_description'] = this.videoDescription;
    data['video_thumbnail'] = this.videoThumbnail;
    data['video_id'] = this.videoId;
    data['address'] = this.address;
    data['address_description'] = this.addressDescription;
    data['google_map'] = this.googleMap;
    data['total_area'] = this.totalArea;
    data['total_unit'] = this.totalUnit;
    data['total_bedroom'] = this.totalBedroom;
    data['total_bathroom'] = this.totalBathroom;
    data['total_garage'] = this.totalGarage;
    data['total_kitchen'] = this.totalKitchen;
    data['is_featured'] = this.isFeatured;
    data['is_top'] = this.isTop;
    data['is_urgent'] = this.isUrgent;
    data['status'] = this.status;
    data['bhk_type'] = this.bhkType;
    data['expired_date'] = this.expiredDate;
    data['seo_title'] = this.seoTitle;
    data['seo_meta_description'] = this.seoMetaDescription;
    data['serial'] = this.serial;
    data['show_slider'] = this.showSlider;
    data['approve_by_admin'] = this.approveByAdmin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['date_from'] = this.dateFrom;
    data['date_to'] = this.dateTo;
    data['time_from'] = this.timeFrom;
    data['category_id'] =  this.categoryId;
    data['time_to'] = this.timeTo;
    data['country_id'] = this.countryId;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['possession_status'] = this.possessionStatus;
    data['city_id'] = this.cityId;
    data['totalRating'] = this.totalRating;
    data['ratingAvarage'] = this.ratingAvarage;
    data["slider_image"] = this.sliders!.map((e) => e.toJson()).toList();
    if (this.aminityItemDto != null) {
      data['aminityItemDto'] =
          this.aminityItemDto!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LatestProperties {
  int? id;
  int? agentId;
  int? propertyTypeId;
  int? stateId;
  String? title;
  String? categoryId;
  String? slug;
  String? purpose;
  String? rentPeriod;
  int? price;
  String? thumbnailImage;
  String? description;
  String? videoDescription;
  String? videoThumbnail;
  String? videoId;
  String? address;
  String? addressDescription;
  String? googleMap;
  String? totalArea;
  String? totalUnit;
  String? totalBedroom;
  String? totalBathroom;
  String? totalGarage;
  String? totalKitchen;
  String? isFeatured;
  String? isTop;
  String? isUrgent;
  String? status;
  String? bhkType;
  String? expiredDate;
  String? seoTitle;
  String? seoMetaDescription;
  int? serial;
  String? showSlider;
  String? approveByAdmin;
  String? createdAt;
  String? updatedAt;
  String? dateFrom;
  List<SliderImage>? sliders;
  String? dateTo;
  String? timeFrom;
  String? timeTo;
  int? countryId;
  String? lat;
  String? lon;
  int? possessionStatus;
  int? cityId;
  int? totalRating;
  String? ratingAvarage;
  List<AminityItemDto>? aminityItemDto;

  LatestProperties(
      {this.id,
        this.agentId,
        this.propertyTypeId,
        this.stateId,
        this.title,
        this.sliders,
        this.categoryId,
        this.slug,
        this.purpose,
        this.rentPeriod,
        this.price,
        this.thumbnailImage,
        this.description,
        this.videoDescription,
        this.videoThumbnail,
        this.videoId,
        this.address,
        this.addressDescription,
        this.googleMap,
        this.totalArea,
        this.totalUnit,
        this.totalBedroom,
        this.totalBathroom,
        this.totalGarage,
        this.totalKitchen,
        this.isFeatured,
        this.isTop,
        this.isUrgent,
        this.status,
        this.bhkType,
        this.expiredDate,
        this.seoTitle,
        this.seoMetaDescription,
        this.serial,
        this.showSlider,
        this.approveByAdmin,
        this.createdAt,
        this.updatedAt,
        this.dateFrom,
        this.dateTo,
        this.timeFrom,
        this.timeTo,
        this.countryId,
        this.lat,
        this.lon,
        this.possessionStatus,
        this.cityId,
        this.totalRating,
        this.aminityItemDto,
        this.ratingAvarage});

  LatestProperties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agentId = json['agent_id'];
    propertyTypeId = json['property_type_id'];
    stateId = json['state_id'];
    title = json['title'];
    slug = json['slug'];
    purpose = json['purpose'];
    rentPeriod = json['rent_period'];
    price = json['price'];
    thumbnailImage = json['thumbnail_image'];
    description = json['description'];
    videoDescription = json['video_description'];
    videoThumbnail = json['video_thumbnail'];
    videoId = json['video_id'];
    address = json['address'];
    addressDescription = json['address_description'];
    googleMap = json['google_map'];
    totalArea = json['total_area'];
    totalUnit = json['total_unit'];
    totalBedroom = json['total_bedroom'];
    totalBathroom = json['total_bathroom'];
    totalGarage = json['total_garage'];
    totalKitchen = json['total_kitchen'];
    isFeatured = json['is_featured'];
    isTop = json['is_top'];
    isUrgent = json['is_urgent'];
    status = json['status'];
    bhkType = json['bhk_type'];
    expiredDate = json['expired_date'];
    seoTitle = json['seo_title'];
    seoMetaDescription = json['seo_meta_description'];
    serial = json['serial'];
    showSlider = json['show_slider'];
    approveByAdmin = json['approve_by_admin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    countryId = json['country_id'];
    lat = json['lat'];
    lon = json['lon'];
    possessionStatus = json['possession_status'];
    cityId = json['city_id'];
    categoryId = json['category_id'].toString();
    totalRating = json['totalRating'];
        sliders = json['slider_image'] != null
        ? (json['slider_image'] as List)
        .map((i) => i is Map<String,dynamic>?SliderImage.fromMap(i):SliderImage.fromJson(i))
        .toList()
        : [];
    if (json['aminities'] != null) {
      aminityItemDto = <AminityItemDto>[];
      json['aminities'].forEach((v) {
        aminityItemDto!.add(new AminityItemDto.fromMap(v));
      });
    } else {
      aminityItemDto = [];
    }
    ratingAvarage = json['ratingAvarage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['agent_id'] = this.agentId;
    data['property_type_id'] = this.propertyTypeId;
    data['state_id'] = this.stateId;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['purpose'] = this.purpose;
    data['rent_period'] = this.rentPeriod;
    data['price'] = this.price;
    data['thumbnail_image'] = this.thumbnailImage;
    data['description'] = this.description;
    data['video_description'] = this.videoDescription;
    data['video_thumbnail'] = this.videoThumbnail;
    data['video_id'] = this.videoId;
    data['address'] = this.address;
    data['address_description'] = this.addressDescription;
    data['google_map'] = this.googleMap;
    data['total_area'] = this.totalArea;
    data['total_unit'] = this.totalUnit;
    data['total_bedroom'] = this.totalBedroom;
    data['total_bathroom'] = this.totalBathroom;
    data['total_garage'] = this.totalGarage;
    data['total_kitchen'] = this.totalKitchen;
    data['is_featured'] = this.isFeatured;
    data['is_top'] = this.isTop;
    data['is_urgent'] = this.isUrgent;
    data['status'] = this.status;
    data['bhk_type'] = this.bhkType;
    data['expired_date'] = this.expiredDate;
    data['seo_title'] = this.seoTitle;
    data['seo_meta_description'] = this.seoMetaDescription;
    data['serial'] = this.serial;
    data['show_slider'] = this.showSlider;
    data['approve_by_admin'] = this.approveByAdmin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['date_from'] = this.dateFrom;
    data['date_to'] = this.dateTo;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['country_id'] = this.countryId;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['category_id'] = this.categoryId;
    data['possession_status'] = this.possessionStatus;
    data['city_id'] = this.cityId;
    data['totalRating'] = this.totalRating;
    data['ratingAvarage'] = this.ratingAvarage;
    data["slider_image"] = this.sliders!.map((e) => e.toJson()).toList();
    if (this.aminityItemDto != null) {
      data['aminities'] =
          this.aminityItemDto!.map((v) => (v).toJson()).toList();
    }
    return data;
  }
}

class Properties {
  int? id;
  int? agentId;
  String? categoryId;
  int? propertyTypeId;
  int? stateId;
  String? title;
  String? slug;
  String? purpose;
  String? rentPeriod;
  int? price;
  String? thumbnailImage;
  String? description;
  String? videoDescription;
  String? videoThumbnail;
  String? videoId;
  String? address;
  String? addressDescription;
  String? googleMap;
  String? totalArea;
  String? totalUnit;
  String? totalBedroom;
  String? totalBathroom;
  String? totalGarage;
  String? totalKitchen;
  String? isFeatured;
  String? isTop;
  String? isUrgent;
  String? status;
  String? bhkType;
  String? expiredDate;
  String? seoTitle;
  String? seoMetaDescription;
  int? serial;
  String? showSlider;
  String? approveByAdmin;
  String? createdAt;
  String? updatedAt;
  List<SliderImage>? sliders;
  String? dateFrom;
  String? dateTo;
  String? timeFrom;
  String? timeTo;
  int? countryId;
  String? lat;
  String? lon;
  int? possessionStatus;
  int? cityId;
  double? distance;
  int? totalRating;
  String? ratingAvarage;
  List<AminityItemDto>? aminityItemDto;

  Properties(
      {this.id,
        this.agentId,
        this.propertyTypeId,
        this.stateId,
        this.title,
        this.slug,
        this.purpose,
        this.categoryId,
        this.rentPeriod,
        this.price,
        this.thumbnailImage,
        this.description,
        this.videoDescription,
        this.videoThumbnail,
        this.videoId,
        this.address,
        this.addressDescription,
        this.googleMap,
        this.totalArea,
        this.totalUnit,
        this.totalBedroom,
        this.totalBathroom,
        this.totalGarage,
        this.totalKitchen,
        this.isFeatured,
        this.isTop,
        this.isUrgent,
        this.status,
        this.bhkType,
        this.expiredDate,
        this.seoTitle,
        this.seoMetaDescription,
        this.serial,
        this.showSlider,
        this.approveByAdmin,
        this.createdAt,
        this.updatedAt,
        this.dateFrom,
        this.dateTo,
        this.timeFrom,
        this.timeTo,
        this.countryId,
        this.lat,
        this.lon,
        this.possessionStatus,
        this.cityId,
        this.distance,
        this.totalRating,
        this.aminityItemDto,
        this.sliders,
        this.ratingAvarage});

  Properties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agentId = json['agent_id'];
    propertyTypeId = json['property_type_id'];
    stateId = json['state_id'];
    title = json['title'];
    slug = json['slug'];
    purpose = json['purpose'];
    categoryId = json['category_id'].toString();
    rentPeriod = json['rent_period'];
    price = json['price'];
    thumbnailImage = json['thumbnail_image'];
    description = json['description'];
    videoDescription = json['video_description'];
    videoThumbnail = json['video_thumbnail'];
    videoId = json['video_id'];
    address = json['address'];
    addressDescription = json['address_description'];
    googleMap = json['google_map'];
    totalArea = json['total_area'];
    totalUnit = json['total_unit'];
    totalBedroom = json['total_bedroom'];
    totalBathroom = json['total_bathroom'];
    totalGarage = json['total_garage'];
    totalKitchen = json['total_kitchen'];
    isFeatured = json['is_featured'];
    isTop = json['is_top'];
    isUrgent = json['is_urgent'];
    status = json['status'];
    bhkType = json['bhk_type'];
    expiredDate = json['expired_date'];
    seoTitle = json['seo_title'];
    seoMetaDescription = json['seo_meta_description'];
    serial = json['serial'];
    showSlider = json['show_slider'];
    approveByAdmin = json['approve_by_admin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dateFrom = json['date_from'];
    dateTo = json['date_to'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    countryId = json['country_id'];
    lat = json['lat'];
    lon = json['lon'];
    possessionStatus = json['possession_status'];
    cityId = json['city_id'];
    distance = json['distance'];
    totalRating = json['totalRating'];
    ratingAvarage = json['ratingAvarage'];
        sliders = json['slider_image'] != null
        ? (json['slider_image'] as List)
        .map((i) => i is Map<String,dynamic>?SliderImage.fromMap(i):SliderImage.fromJson(i))
        .toList()
        : [];
    if (json['aminities'] != null) {
      aminityItemDto = <AminityItemDto>[];
      json['aminities'].forEach((v) {
        aminityItemDto!.add(v is Map<String,dynamic>?new AminityItemDto.fromMap(v):AminityItemDto.fromJson(v));
      });
    } else {
      aminityItemDto = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['agent_id'] = this.agentId;
    data['property_type_id'] = this.propertyTypeId;
    data['state_id'] = this.stateId;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['purpose'] = this.purpose;
    data['category_id'] = this.categoryId;
    data['rent_period'] = this.rentPeriod;
    data['price'] = this.price;
    data['thumbnail_image'] = this.thumbnailImage;
    data['description'] = this.description;
    data['video_description'] = this.videoDescription;
    data['video_thumbnail'] = this.videoThumbnail;
    data['video_id'] = this.videoId;
    data['address'] = this.address;
    data['address_description'] = this.addressDescription;
    data['google_map'] = this.googleMap;
    data['total_area'] = this.totalArea;
    data['total_unit'] = this.totalUnit;
    data['total_bedroom'] = this.totalBedroom;
    data['total_bathroom'] = this.totalBathroom;
    data['total_garage'] = this.totalGarage;
    data['total_kitchen'] = this.totalKitchen;
    data['is_featured'] = this.isFeatured;
    data['is_top'] = this.isTop;
    data['is_urgent'] = this.isUrgent;
    data['status'] = this.status;
    data['bhk_type'] = this.bhkType;
    data['expired_date'] = this.expiredDate;
    data['seo_title'] = this.seoTitle;
    data['seo_meta_description'] = this.seoMetaDescription;
    data['serial'] = this.serial;
    data['show_slider'] = this.showSlider;
    data['approve_by_admin'] = this.approveByAdmin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['date_from'] = this.dateFrom;
    data['date_to'] = this.dateTo;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['country_id'] = this.countryId;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['possession_status'] = this.possessionStatus;
    data['city_id'] = this.cityId;
    data['distance'] = this.distance;
    data['totalRating'] = this.totalRating;
    data['ratingAvarage'] = this.ratingAvarage;
    data["slider_image"] = this.sliders!.map((e) => e.toJson()).toList();
    if (this.aminityItemDto != null) {
      data['aminities'] =
          this.aminityItemDto!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}