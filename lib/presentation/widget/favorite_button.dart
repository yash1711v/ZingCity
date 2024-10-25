import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/data/model/booking/booking_model.dart';
import 'package:real_estate/logic/cubit/booking/booking_cubit.dart';

import '/presentation/utils/utils.dart';
import '../../data/model/product/property_item_model.dart';
import '../../logic/bloc/login/login_bloc.dart';
import '../../logic/cubit/wishlist/wishlist_cubit.dart';
import '../utils/constraints.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key, required this.id});

  final String id;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final _className = "FavoriteButton";

  late Set<PropertyItemModel> wishlist;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    wishlist = <PropertyItemModel>{};
    loadWishlist();
  }

  loadWishlist() {
    final item = context.read<WishlistCubit>().wishlist;
    final i =
        item.where((element) => element.id.toString() == widget.id).toSet();
    if (i.isNotEmpty) {
      setState(() {
        isFavorite = true;
        wishlist = i;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final wishlistCubit = context.read<WishlistCubit>();
    final loginBloc = context.read<LoginBloc>();
    return BlocConsumer<WishlistCubit, WishlistState>(
      listener: (context, state) {
        //final wishlist = state.wishlistState;
        if (state is WishListLoading) {
          log(_className, name: state.toString());
        } else if (state is WishListError) {
          Utils.errorSnackBar(context, state.message);
        } else if (state is AddToWishlistLoad) {
          Utils.showSnackBar(context, state.message);
        } else if (state is RemoveFromWishlistLoad) {
          Utils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is WishListLoaded) {
          wishlist = state.wishlist.properties!.data!
              .where((element) => element.id.toString() == widget.id)
              .toSet();
        }
        return GestureDetector(
          onTap: () async {
            if (loginBloc.userInfo != null &&
                loginBloc.userInfo!.accessToken.isNotEmpty) {
              if (isFavorite) {
                wishlistCubit.removeFromWishlist(widget.id);
              } else {
                wishlistCubit.addToWishlist(widget.id);
              }
              setState(() => isFavorite = !isFavorite);
            } else {
              Utils.showSnackBarWithLogin(context);
            }

            // if (wishlist.isNotEmpty) {
            //   print('isFavorite $isFavorite');
            //   wishlistCubit.removeFromWishlist(widget.id);
            //   // final r = await context
            //   //     .read<WishlistCubit>()
            //   //     .removeFromWishlist(wishlist.first.id.toString());
            //   // r.fold((failure) {}, (success) {});
            // }
            //   print('isFavorite $isFavorite');
            //   wishlistCubit.removeFromWishlist(widget.id);
            // } else {
            //   print('removeFromWishlist');
            //   print('isFavorite $isFavorite');
            //   wishlistCubit.addToWishlist(widget.id);
            // }
            // setState(() => isFavorite = !isFavorite);
          },
          child: CircleAvatar(
            backgroundColor: borderColor,
            minRadius: 14.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: primaryColor, size: 18.0),
            ),
          ),
        );
      },
    );
  }
}

class AddToCompare extends StatelessWidget {
  const AddToCompare({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    return BlocConsumer<BookingCubit, BookingModel>(
      listener: (context, book) {
        final state = book.bookState;
        if (state is CompareError) {
          Utils.errorSnackBar(context, state.message);
        } else if (state is CompareAddRemoved) {
          context.read<BookingCubit>().addSingComId(int.parse(id));
          context.read<BookingCubit>().getCompareList();
          Utils.showSnackBar(context, state.message);
        }
      },
      builder: (context, book) {
        final state = book.bookState;
        final pId = book.tempComId.contains(int.parse(id));
        return GestureDetector(
          onTap: () async {
            if (loginBloc.userInfo != null &&
                loginBloc.userInfo!.accessToken.isNotEmpty) {
              if (pId) {
                context.read<BookingCubit>().compareAddOrRemove(id, false);
              } else {
                context.read<BookingCubit>().compareAddOrRemove(id);
              }
            } else {
              Utils.showSnackBarWithLogin(context);
            }
          },
          child: CircleAvatar(
            backgroundColor: borderColor,
            minRadius: 14.0,
            child: Padding(
              padding: Utils.only(top: 2.0),
              child: Icon(
                pId ? Icons.shuffle_on_outlined : Icons.shuffle,
                color: primaryColor,
                size: 18.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
