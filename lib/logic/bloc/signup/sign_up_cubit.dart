import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate/logic/bloc/signup/sign_up_state.dart';


class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState());
}
