import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/logic/bloc/login/login_bloc.dart';
import '../../../../data/model/auth/auth_error_model.dart';
import '../../../../data/model/create_property/additional_info_dto.dart';
import '../../../../data/model/create_property/edit_info/edit_info_model.dart';
import '../../../../data/model/create_property/nearest_location_dto.dart';
import '../../../../data/model/create_property/property_images_dto.dart';
import '../../../../data/model/create_property/property_location.dart';
import '../../../../data/model/create_property/property_plan_dto.dart';
import '../../../../data/model/create_property/property_video_dto.dart';
import '../../../repository/property_repository.dart';

part 'property_create_event.dart';
part 'property_create_state.dart';

class PropertyCreateBloc
    extends Bloc<PropertyCreateEvent, PropertyCreateModel> {
  final PropertyRepository _repository;
  final LoginBloc _loginBloc;
  PropertyImageDto? propertyImageDto;
  PropertyVideoDto? propertyVideoDto;
  PropertyLocationDto? propertyLocationDto;
  List<PropertyPlanDto> propertyPlanList = [];
  List<NearestLocationDto> nearestLocationList = [];
  List<AdditionalInfoDto> additionalItemList = [];
  EditInfoModel? editInfo;

  PropertyCreateBloc(PropertyRepository repository, LoginBloc loginBloc)
      : _repository = repository,
        _loginBloc = loginBloc,
        super(const PropertyCreateModel()) {
    on<PropertyPurposeEvent>((event, emit) {
      emit(state.copyWith(purpose: event.purpose));
    });
    on<PropertyTitleEvent>((event, emit) {
      emit(state.copyWith(title: event.title));
    });

    on<PropertySlugEvent>((event, emit) {
      emit(state.copyWith(slug: event.slug));
    });
    on<PropertyTypeEvent>((event, emit) {
      emit(state.copyWith(typeId: event.type));
    });

    on<PropertyRentPeriodEvent>((event, emit) {
      emit(state.copyWith(rentPeriod: event.rentPeriod));
    });
    on<PropertyPriceEvent>((event, emit) {
      emit(state.copyWith(price: event.price));
    });
    on<PropertyTotalAreaEvent>((event, emit) {
      emit(state.copyWith(totalArea: event.totalArea));
    });
    on<PropertyTotalUnitEvent>((event, emit) {
      emit(state.copyWith(totalUnit: event.totalUnit));
    });
    on<PropertyTotalBedroomEvent>((event, emit) {
      emit(state.copyWith(totalBedroom: event.totalBedroom));
    });
    on<PropertyTotalBathroomEvent>((event, emit) {
      emit(state.copyWith(totalBathroom: event.totalBathroom));
    });
    on<PropertyTotalGarageEvent>((event, emit) {
      emit(state.copyWith(totalGarage: event.totalGarage));
    });
    on<PropertyTotalKitchenEvent>((event, emit) {
      emit(state.copyWith(totalKitchen: event.totalKitchen));
    });
    on<PropertyDescriptionEvent>((event, emit) {
      emit(state.copyWith(description: event.description));
    });
    on<PropertyPropertyImageEvent>((event, emit) {
      emit(state.copyWith(propertyImageDto: event.propertyImage));
    });
    on<PropertyPropertyVideoEvent>((event, emit) {
      emit(state.copyWith(propertyVideoDto: event.propertyVideo));
    });
    on<PropertyPropertyLocationEvent>((event, emit) {
      emit(state.copyWith(propertyLocationDto: event.propertyLocation));
    });

    on<PropertyPropertyAminitiesEvent>((event, emit) {
      emit(state.copyWith(aminities: event.propertyAminities));
    });

    on<PropertyNearestLocationEvent>((event, emit) {
      print('add-new-locations ${event.nearestLocation.length}');
      emit(state.copyWith(nearestLocationList: event.nearestLocation));
    });

    on<PropertyAdditionalInfoEvent>((event, emit) {
      emit(state.copyWith(addtionalInfoList: event.additionalInfo));
    });

    on<PropertyPropertyPlanEvent>((event, emit) {
      emit(
        state.copyWith(
          propertyPlanDto: event.propertyPlan,
          propertyCreateState: const PropertyCreateInitial(),
        ),
      );
    });
    on<PropertySeoTitleEvent>((event, emit) {
      emit(state.copyWith(seoTitle: event.seoTitle));
    });
    on<PropertySeoMetaDescriptionEvent>((event, emit) {
      emit(state.copyWith(seoMetaDescription: event.seoMetaDescription));
    });

    /// added feature from provider start
    on<PropertyCreateEventTop>((event, emit) {
      emit(state.copyWith(isTop: event.isTop));
    });

    on<PropertyCreateEventFeature>((event, emit) {
      emit(state.copyWith(isFeatured: event.isFeatured));
    });

    on<PropertyCreateEventUrgent>((event, emit) {
      emit(state.copyWith(isUrgent: event.isUrgent));
    });

    /// added feature from provider end
    on<SubmitCreateProperty>(_submitRequestToCreateProperty);
    //on<SubmitUpdateProperty>(_submitRequestToUpdateProperty);
    on<PropertyEditInfoEvent>(_getPropertyEditInfo);
    on<PropertyStateReset>(_resetState);
  }

  Future<void> _submitRequestToCreateProperty(
      SubmitCreateProperty event, Emitter<PropertyCreateModel> emit) async {
    //log("Bloc", name: "${state.toMap()}");
    print('create-body ${state.toMap()}');
    emit(state.copyWith(propertyCreateState: const PropertyCreateLoading()));

    // final result = await _repository.createProperty(
    //     state, _loginBloc.userInfo!.accessToken);
    //
    // result.fold(
    //   (failure) {
    //     if (failure is InvalidAuthData) {
    //       final errorState = PropertyCreateInvalidError(failure.errors);
    //       emit(state.copyWith(propertyCreateState: errorState));
    //     } else {
    //       emit(state.copyWith(
    //           propertyCreateState: PropertyCreateError(failure.message)));
    //     }
    //   },
    //   (successData) {
    //     emit(state.copyWith(
    //         propertyCreateState: PropertyCreateSuccess(successData)));
    //     print('clearAll');
    //     //emit(state.copyWith(image: ''));
    //   },
    // );
  }

  Future<void> _getPropertyEditInfo(
      PropertyEditInfoEvent event, Emitter<PropertyCreateModel> emit) async {
    emit(state.copyWith(propertyCreateState: const PropertyEditInfoLoading()));

    final result = await _repository.getPropertyEditInfo(
        event.propertyId, _loginBloc.userInfo!.accessToken);
    result.fold(
      (failure) {
        final errors =
            PropertyEditInfoError(failure.message, failure.statusCode);
        emit(state.copyWith(propertyCreateState: errors));
      },
      (data) {
        editInfo = data;
        emit(state.copyWith(title: data.property.title));
        emit(state.copyWith(slug: data.property.slug));

        emit(state.copyWith(purpose: data.property.purpose));
        //print('purrrr ${data.property.purpose}');
        emit(state.copyWith(typeId: data.property.propertyTypeId.toString()));
        emit(state.copyWith(rentPeriod: data.property.rentPeriod));
        emit(state.copyWith(price: data.property.price.toString()));
        emit(state.copyWith(totalArea: data.property.totalArea.toString()));
        emit(state.copyWith(totalUnit: data.property.totalUnit.toString()));
        emit(state.copyWith(
            totalBedroom: data.property.totalBedroom.toString()));
        emit(state.copyWith(
            totalBathroom: data.property.totalBathroom.toString()));
        emit(state.copyWith(totalGarage: data.property.totalGarage.toString()));
        emit(state.copyWith(
            totalKitchen: data.property.totalKitchen.toString()));
        emit(state.copyWith(description: data.property.description));
        emit(state.copyWith(status: data.property.status));

        ///highlighted property
        emit(state.copyWith(isTop: data.property.isTop));
        emit(state.copyWith(isFeatured: data.property.isFeatured));
        emit(state.copyWith(isUrgent: data.property.isFeatured));
        // print('update-isTop: ${data.property.isTop}');
        // print('update-isFeature: ${data.property.isFeatured}');
        // print('update-isUrgent: ${data.property.isUrgent}');

        //placing thumbnail & sliders image in the state
        emit(state.copyWith(
            propertyImageDto: PropertyImageDto(
                thumbnailImage: data.property.thumbnailImage,
                isExistingThumb: true,
                sliderImages: data.existingSliders)));

        //placing video property in the state
        emit(state.copyWith(
            propertyVideoDto: PropertyVideoDto(
                videoThumbnail: data.property.videoThumbnail,
                videoId: data.property.videoId,
                videoDescription: data.property.videoDescription)));

        //placing location in the state
        emit(state.copyWith(
          propertyLocationDto: PropertyLocationDto(
              cityId: data.property.cityId,
              address: data.property.address,
              addressDescription: data.property.addressDescription,
              googleMap: data.property.googleMap),
        ));

        //placing amenities in the state
        final amenities = <int>[];
        for (var i = 0; i < data.existingAminities.length; i++) {
          data.aminities.map((e) {
            if (e.id == data.existingAminities[i].aminityId) {
              amenities.add(e.id);
            }
          }).toList();
        }
        emit(state.copyWith(aminities: amenities));

        //placing nearest locations image in the state
        nearestLocationList.clear();
        for (var i = 0; i < data.existingNearest.length; i++) {
          nearestLocationList.add(NearestLocationDto(
              id: data.existingNearest[i].id,
              locationId: data.existingNearest[i].nearestLocationId,
              distances: data.existingNearest[i].distance));
        }
        emit(state.copyWith(nearestLocationList: nearestLocationList));
        //print('total-existing-nearest-location ${data.existingNearest.length}');
        //debugPrint('properties ${state.propertyPlanDto}');
        //placing additional information in the state
        additionalItemList.clear();
        // print('total-existing-nearest-location ${data.existingNearest.length}');
        for (var i = 0; i < data.existingAddInfo.length; i++) {
          additionalItemList.add(AdditionalInfoDto(
              id: data.existingAddInfo[i].id,
              addKeys: data.existingAddInfo[i].addKey,
              addValues: data.existingAddInfo[i].addValue));
        }
        emit(state.copyWith(addtionalInfoList: additionalItemList));
        debugPrint('additionalItemList ${additionalItemList.length}');

        //placing property plan in the state
        propertyPlanList.clear();
        //print('property-list ${propertyPlanList.length}');
        for (var i = 0; i < data.existingPlan.length; i++) {
          propertyPlanList.add(PropertyPlanDto(
              id: data.existingPlan[i].id,
              planImages: data.existingPlan[i].image,
              planTitles: data.existingPlan[i].title,
              planDescriptions: data.existingPlan[i].description));
        }
        emit(state.copyWith(propertyPlanDto: propertyPlanList));
        debugPrint('property-list ${state.propertyPlanDto.length}');
        emit(state.copyWith(seoTitle: data.property.seoTitle));
        emit(state.copyWith(
            seoMetaDescription: data.property.seoMetaDescription));

        print("title ${state.title}");

        emit(state.copyWith(propertyCreateState: PropertyEditInfoLoaded(data)));
      },
    );
  }

  // Future<void> _submitRequestToUpdateProperty(
  //     SubmitUpdateProperty event, Emitter<PropertyCreateModel> emit) async {
  //   emit(state.copyWith(propertyCreateState: const PropertyUpdateLoading()));
  //   print('addition-info-data ${state.addtionalInfoList}');
  //   // print('nearest-location-data ${state.nearestLocationList}');
  //   print('update-state-body ${state.propertyPlanDto}');
  //   print('update-body ${state.aminities}');
  //   debugPrint('property-list ${state.propertyPlanDto.length}');
  //   final result = await _repository.updateProperty(
  //       event.propertyId, state, _loginBloc.userInfo!.accessToken);
  //
  //   result.fold(
  //     (failure) {
  //       if (failure is InvalidAuthData) {
  //         final errorState = PropertyUpdateInvalidError(failure.errors);
  //         emit(state.copyWith(propertyCreateState: errorState));
  //       } else {
  //         emit(state.copyWith(
  //             propertyCreateState: PropertyUpdateError(failure.message)));
  //       }
  //     },
  //     (successData) {
  //       emit(state.copyWith(
  //           propertyCreateState: PropertyUpdateSuccess(message: successData)));
  //       print('Status $successData');
  //     },
  //   );
  // }

  FutureOr<void> _resetState(
      PropertyStateReset event, Emitter<PropertyCreateModel> emit) {
    // propertyPlanList.clear();
    // nearestLocationList.clear();
    // additionalItemList.clear();
    emit(state.copyWith(title: ''));
    emit(state.copyWith(slug: ''));
    emit(state.copyWith(typeId: ''));
    emit(state.copyWith(rentPeriod: ''));
    emit(state.copyWith(price: ''));
    emit(state.copyWith(totalArea: ''));
    emit(state.copyWith(totalUnit: ''));
    emit(state.copyWith(totalBedroom: ''));
    emit(state.copyWith(totalBathroom: ''));
    emit(state.copyWith(totalGarage: ''));
    emit(state.copyWith(totalKitchen: ''));
    emit(state.copyWith(description: ''));

    emit(state.copyWith(
        propertyImageDto:
            const PropertyImageDto(thumbnailImage: '', sliderImages: [])));

    //placing video property in the state
    emit(state.copyWith(
        propertyVideoDto: const PropertyVideoDto(
            videoThumbnail: '', videoId: '', videoDescription: '')));

    //placing location in the state
    emit(state.copyWith(
        propertyLocationDto: const PropertyLocationDto(
            cityId: 0, address: '', addressDescription: '', googleMap: '')));

    emit(state.copyWith(aminities: []));
    emit(state.copyWith(nearestLocationList: []));
    emit(state.copyWith(addtionalInfoList: []));
    emit(state.copyWith(propertyPlanDto: []));
    emit(state.copyWith(seoTitle: ''));
    emit(state.copyWith(seoMetaDescription: ''));
    emit(state.copyWith(propertyCreateState: const PropertyCreateInitial()));
  }
}
