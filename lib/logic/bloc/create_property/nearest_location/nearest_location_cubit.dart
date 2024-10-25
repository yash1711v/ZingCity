import 'package:equatable/equatable.dart';

import '../../../../data/model/create_property/nearest_location_dto.dart';
import '../../../../data/model/product/nearest_location_model.dart';
import '../../../../state_inject_package_names.dart';

part 'nearest_location_state.dart';

class NearestLocationCubit extends Cubit<NearestLocationState> {
  NearestLocationCubit()
      : super(const NearestLocationAdded(
            [NearestLocationDto(locationId: 0, distances: '')]));

  List<NearestLocationModel> nearestLocationModel = <NearestLocationModel>[];
  List<NearestLocationDto> locations = [
    const NearestLocationDto(locationId: 0, distances: ''),
  ];
  List<TextEditingController> distanceController = [
    TextEditingController(),
  ];

  void addLocation(NearestLocationDto location) {
    debugPrint('update-location-listening');
    final updatedLocations = List.of(locations)..add(location);
    final updatedControllers = List.of(distanceController)
      ..add(TextEditingController());
    locations = updatedLocations;
    distanceController = updatedControllers;
    emit(NearestLocationAdded(updatedLocations));
  }

  void removeLocation(int index) {
    debugPrint('update-location-listening-removed $index');
    if (index >= 0 && index < locations.length) {
      final updatedLocations = List.of(locations)..removeAt(index);
      final updatedControllers = List.of(distanceController);
      final removedController = updatedControllers.removeAt(index);
      removedController.dispose();
      locations = updatedLocations;
      distanceController = updatedControllers;

      emit(NearestLocationAdded(updatedLocations));
    }
  }

  void reset(int id) {
    //locations.first.locationId = id;
    nearestLocationModel = <NearestLocationModel>[
      NearestLocationModel(id: id, location: '', status: 0)
    ];
    distanceController = <TextEditingController>[TextEditingController()];
  }

  ///Nearest location is update from here
  // List<NearestLocationModel> exitModel = <NearestLocationModel>[];
  // List<int> exitLocationIds = <int>[];
  // List<String> exitDistances = <String>[];
}
