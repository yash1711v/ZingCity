part of 'home_cubit.dart';

 class HomeState extends Equatable {
   final HomeDataModel? homeDataLoaded;
   final bool? isLoading;
   final List<Properties>? rentProperties;
   final List<Properties>? buyProperties;
   final List<Properties>? data;
  const HomeState({this.homeDataLoaded,this.isLoading,this.rentProperties, this.buyProperties, this.data });


   HomeState copyWith({
     HomeDataModel? homeDataLoaded,
     bool? isLoading,
     List<Properties>? rentProperties,
      List<Properties>? buyProperties,
      List<Properties>? data,

   }) {
     return HomeState(
       homeDataLoaded: homeDataLoaded ?? this.homeDataLoaded,
       isLoading: isLoading ?? this.isLoading,
       rentProperties: rentProperties ?? this.rentProperties,
       buyProperties: buyProperties ?? this.buyProperties,
         data: data ?? this.data
     );
   }

   @override
  List<Object?> get props => [homeDataLoaded,isLoading,rentProperties,buyProperties,data];
}

// class HomeInitial extends HomeState {
//   HomeInitial(super.homeDataLoaded);
// }
//
// class HomeLoadingState extends HomeState {
//   HomeLoadingState(super.homeDataLoaded);
// }
//
// class HomeErrorState extends HomeState {
//   final String error;
//   const HomeErrorState(super.homeDataLoaded, {required this.error});
//
//   @override
//   List<Object> get props => [error];
// }
//
// class HomeDataLoaded extends HomeState {
//
//   const HomeDataLoaded(super.homeDataLoaded, );
//
//   @override
//   List<Object> get props => [];
// }
