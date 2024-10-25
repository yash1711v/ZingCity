part of 'nearest_location_cubit.dart';

abstract class NearestLocationState extends Equatable {
  const NearestLocationState();

  @override
  List<Object> get props => [];
}

class NearestLocationInitial extends NearestLocationState {}

class NearestLocationAdded extends NearestLocationState {
  final List<NearestLocationDto> nearestLocation;

  // final List<TextEditingController> nearestLocation;

  const NearestLocationAdded(this.nearestLocation);

  @override
  List<Object> get props => [nearestLocation];
}

class NearestLocationRemoved extends NearestLocationState {
  final List<NearestLocationDto> nearestLocation;

  // final List<TextEditingController> nearestLocation;
  const NearestLocationRemoved(this.nearestLocation);

  @override
  List<Object> get props => [nearestLocation];
}

// class ExistingLocationAdded extends NearestLocationState {
//   final List<ExistingNearestModel> exitingNearest;
//
//   const ExistingLocationAdded(this.exitingNearest);
//
//   @override
//   List<Object> get props => [exitingNearest];
// }
//
// class ExistingLocationRemoved extends NearestLocationState {
//   final List<ExistingNearestModel> exitingNearest;
//
//   const ExistingLocationRemoved(this.exitingNearest);
//
//   @override
//   List<Object> get props => [exitingNearest];
// }

class UpdateNearestLocationState extends Equatable {
  final List<NearestLocationDto> locations;

  const UpdateNearestLocationState(this.locations);

  @override
  List<Object?> get props => [locations];
}
