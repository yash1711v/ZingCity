import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/logic/repository/auth_repository.dart';

import '../../../../data/model/home/home_data_model.dart';
import '../../../../presentation/router/route_packages_name.dart';
import '../../../repository/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());


  Repository _repository  = Repository();
  // final HomeRepository _homeRepository;
  HomeDataModel? homeModel;
  // HomeCubit(HomeRepository homeRepository)
  //     : _homeRepository = homeRepository,
  //       super(HomeLoadingState()) {
  //   getHomeData();
  // }
  //
  bool? isLoading = false;
  Future<void> getHomeData({required String lat, required String long}) async {
    try {
      emit(state.copyWith(isLoading: true)); // Set loading to true

      final result = await _repository.getHomeScreenData(lat: lat, long: long);

      var data = jsonDecode(result.body);
      log("${data}",name: "Data");
      if(data['status']) {
       log("${data}",name: "Data");
        homeModel = HomeDataModel.fromJson(data['data']);

       List<Properties> rentProperties = [];
       List<Properties> buyProperties = [];

       for (Properties property in (homeModel ?? HomeDataModel()).properties ?? []) {
         if (property.purpose?.toLowerCase() == "rent" ||
             property.purpose?.toLowerCase() == "for rent") {
           rentProperties.add(property);
         } else if (property.purpose?.toLowerCase() == "sale") {
           buyProperties.add(property);
         }
       }

        emit(state.copyWith(homeDataLoaded: homeModel, isLoading: false,rentProperties: rentProperties,buyProperties: buyProperties));
      } // Set loading to false after success
    } catch (e) {
      emit(state.copyWith(isLoading: false)); // Ensure loading is false on error
      // Optionally handle errors here
      log('Error: $e', name: 'getHomeData');
    }
  }


  void setListOfData(List<Properties> data){
    emit(state.copyWith(data: [],isLoading: true));
    emit(state.copyWith(data: data,isLoading: false));
  }
}
