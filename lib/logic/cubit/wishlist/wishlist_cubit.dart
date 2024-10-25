import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/product/property_item_model.dart';
import '../../../data/model/wishlist/wishlist_model.dart';
import '../../bloc/login/login_bloc.dart';
import '../../repository/wishlist_repository.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final LoginBloc _loginBloc;
  final WishListRepository _wishListRepository;

  WishlistCubit({
    required LoginBloc loginBloc,
    required WishListRepository wishListRepository,
  })  : _loginBloc = loginBloc,
        _wishListRepository = wishListRepository,
        super(const WishlistInitial());

  List<PropertyItemModel> wishlist = [];

  Future<void> getWishListProperties() async {
    debugPrint('called-wishlist');
    if (_loginBloc.userInfo != null &&
        _loginBloc.userInfo!.accessToken.isNotEmpty) {
      emit(WishListLoading());
      final result = await _wishListRepository
          .getWishListProperties(_loginBloc.userInfo!.accessToken);
      result.fold((failure) {
        final error = WishListError(failure.message, failure.statusCode);
        emit(error);
      }, (success) {
        wishlist = success.properties!.data!;
        emit(WishListLoaded(success));
      });
    } else {
      const error = WishListError('UnAuthenticated', 401);
      emit(error);
    }
  }

  Future<void> addToWishlist(String id) async {
    if (_loginBloc.userInfo != null &&
        _loginBloc.userInfo!.accessToken.isNotEmpty) {
      emit(AddToWishlistLoading());
      final result = await _wishListRepository.addToWishlist(
          _loginBloc.userInfo!.accessToken, id);

      result.fold((failure) {
        final error = WishListError(failure.message, failure.statusCode);
        emit(error);
      }, (success) {
        emit(AddToWishlistLoad(success));
      });
    }
    //return result;
  }

  Future<void> removeFromWishlist(String id) async {
    emit(RemoveFromWishlistLoading());
    final result = await _wishListRepository.removeFromWishlist(
        _loginBloc.userInfo!.accessToken, id);

    result.fold((failure) {
      final error = WishListError(failure.message, failure.statusCode);
      emit(error);
      return false;
    }, (success) {
      wishlist.removeWhere((element) => element.id.toString() == id);
      emit(RemoveFromWishlistLoad(success));
      return true;
    });
    // return result;
  }
}
