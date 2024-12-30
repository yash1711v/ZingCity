

import 'package:equatable/equatable.dart';

final class SplashScreenState extends Equatable {
  final String? Token;

  const SplashScreenState({this.Token});


  SplashScreenState copyWith({String? Token}) {
    return SplashScreenState(Token: Token ?? this.Token);
  }



  @override
  List<Object> get props => [];
}
