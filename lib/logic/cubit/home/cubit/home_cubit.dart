import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/logic/repository/auth_repository.dart';

import '../../../../data/model/home/home_data_model.dart';
import '../../../../presentation/router/route_packages_name.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Repository _repository = Repository();

  // final HomeRepository _homeRepository;
  HomeDataModel? homeModel;

  // HomeCubit(HomeRepository homeRepository)
  //     : _homeRepository = homeRepository,
  //       super(HomeLoadingState()) {
  //   getHomeData();
  // }
  //
  bool? isLoading = false;



  Future<void> startLoader()async {
    emit(state.copyWith(isLoading: true));
  }
  Future<void> getHomeData({required String lat, required String long}) async {
    try {
      emit(state.copyWith(isLoading: true)); // Set loading to true

      final result = await _repository.getHomeScreenData(lat: lat, long: long);

      var data = jsonDecode(result.body);
      // log("${data}", name: "Data");
      if (data['status']) {
        log("${data}", name: "Home");
        homeModel = HomeDataModel.fromJson(data['data']);

        List<Properties> rentProperties = [];
        List<Properties> buyProperties = [];

        for (Properties property
            in (homeModel ?? HomeDataModel()).properties ?? []) {

          if (property.purpose?.toString().toLowerCase() == "2" ||
              property.purpose.toString().toLowerCase() == "for rent") {
            // log("${property.purpose?.toString()}", name: "rent");
            rentProperties.add(property);
          } else if (property.purpose?.toString().toLowerCase() == "1" ||
              property.purpose?.toString().toLowerCase() == "buy") {

            buyProperties.add(property);
          }
        }
        // log("${buyProperties.length?.toString()}", name: "sell");
        // log("${rentProperties.length?.toString()}", name: "rent");
        emit(state.copyWith(
            homeDataLoaded: homeModel,
            isLoading: false,
            rentProperties: rentProperties,
            buyProperties: buyProperties));
      } // Set loading to false after success
    } catch (e) {
      emit(
          state.copyWith(isLoading: false)); // Ensure loading is false on error
      // Optionally handle errors here
      log('Error: $e', name: 'getHomeData');
    }
  }

  void setListOfData(List<Properties> data) {
    emit(state.copyWith(data: [], isLoading: true));
    emit(state.copyWith(data: data, isLoading: false, searchedProperties: []));
  }

  Future<void> getFilterList(
      {required String maxPrice,
      required String minPrice,
      required String roomType,
      required String city,
      required String possession,
      required String maxArea,
      required String purpose,
      required String type,
      required String possessionStatus,
      required String categoryId,
      required String minArea}) async {
    try {
      emit(state.copyWith(isLoading: true)); // Set loading to true

      final result = await _repository.filter(
          maxPrice: maxPrice,
          minPrice: minPrice,
          roomType: roomType,
          city: city,
          possession: possession,
          maxArea: maxArea,
          purpose: purpose,
          type: type,
          minArea: minArea,
          possessionStatus: possessionStatus,
        categoryId: categoryId
      );

      var data = result;
      //log("${data}", name: "Data");
      if (data['status'] == true) {
        // log("${data}", name: "Data");
        // homeModel = HomeDataModel.fromJson(data['data']);
        //
        List<Properties> searchList = data['properties']
            .map<Properties>((e) => Properties.fromJson(e))
            .toList();
        // List<Properties> buyProperties = [];
        //
        // for (Properties property
        //     in (homeModel ?? HomeDataModel()).properties ?? []) {
        //   if (property.purpose?.toLowerCase() == "rent" ||
        //       property.purpose?.toLowerCase() == "for rent") {
        //     rentProperties.add(property);
        //   } else if (property.purpose?.toLowerCase() == "sale" ||
        //       property.purpose?.toLowerCase() == "buy") {
        //     buyProperties.add(property);
        //   }
        // }

        emit(state.copyWith(
          searchedProperties: searchList,
          isLoading: false,
        ));
      } else {
        ScaffoldMessenger.of(state.context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
          ),
        );
        emit(state.copyWith(
          searchedProperties: [],
          isLoading: false,
        ));
      } // Set loading to false after success
    } catch (e) {
      emit(
          state.copyWith(isLoading: false)); // Ensure loading is false on error
      // Optionally handle errors here
      log('Error: $e', name: 'searchData');
    }
  }
}

extension on HomeState {
  BuildContext get context => this.context;
}
