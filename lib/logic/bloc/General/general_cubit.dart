import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:real_estate/data/model/auth/user_login_response_model.dart';

part 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(const GeneralState());


  void setUser(UserModel? user) {
    emit(state.copyWith(userModel: user));
  }
}
