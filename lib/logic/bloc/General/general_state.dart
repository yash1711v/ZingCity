part of 'general_cubit.dart';

final  class GeneralState extends Equatable {
 final UserModel? userModel;
  const GeneralState({this.userModel});


  GeneralState copyWith({
    UserModel? userModel,
  }) {
    return GeneralState(
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

