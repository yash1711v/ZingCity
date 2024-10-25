part of 'additional_cubit.dart';

abstract class AdditionalState extends Equatable {
  const AdditionalState();
}

class AdditionalInitial extends AdditionalState {
  @override
  List<Object> get props => [];
}

class AdditionAdded extends AdditionalState {
  final List<AdditionalInfoDto> additionalList;

  const AdditionAdded(this.additionalList);

  @override
  List<Object?> get props => [additionalList];
}

class AdditionRemoved extends AdditionalState {
  final List<AdditionalInfoDto> additionalList;

  const AdditionRemoved(this.additionalList);

  @override
  List<Object?> get props => [additionalList];
}
