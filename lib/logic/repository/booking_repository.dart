import 'package:dartz/dartz.dart';
import 'package:real_estate/data/model/booking/booking_model.dart';

import '../../data/model/product/details_property_item.dart';
import '/presentation/error/failure.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../presentation/error/exception.dart';

abstract class BookingRepository {
  Future<Either<Failure, List<BookingModel>>> getBookings(
      String token, String page);

  Future<Either<Failure, List<BookingModel>>> bookingReq(
      String token, String page);

  Future<Either<Failure, BookingModel>> bookingReqDetails(
      String token, String id);

  Future<Either<Failure, String>> bookingStatusUpdate(
      String token, String id, BookingModel body);

  Future<Either<Failure, String>> createBooking(
      String token, BookingModel body);

  Future<Either<Failure, List<DetailsPropertyItem>>> getCompareList(String token);

  Future<Either<Failure, String>> addToCompare(String token, String id);

  Future<Either<Failure, String>> removeCompare(String token, String id);
}

class BookingRepositoryImpl implements BookingRepository {
  final RemoteDataSource remoteDataSource;

  const BookingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<BookingModel>>> bookingReq(
      String token, String page) async {
    try {
      final result = await remoteDataSource.bookingReq(token, page);
      final book = result['bookings']['data'] as List;
      final data =
          List<BookingModel>.from(book.map((b) => BookingModel.fromMap(b)))
              .toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, BookingModel>> bookingReqDetails(
      String token, String id) async {
    try {
      final result = await remoteDataSource.bookingReqDetails(token, id);
      final data = BookingModel.fromMap(result['booking']);
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> bookingStatusUpdate(
      String token, String id, BookingModel body) async {
    try {
      final result =
          await remoteDataSource.bookingStatusUpdate(token, id, body);
      return Right(result['message']);
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> createBooking(
      String token, BookingModel body) async {
    try {
      final result = await remoteDataSource.createBooking(token, body);
      return Right(result['message']);
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<BookingModel>>> getBookings(
      String token, String page) async {
    try {
      final result = await remoteDataSource.getBookings(token, page);
      final book = result['bookings']['data'] as List;
      final data =
          List<BookingModel>.from(book.map((b) => BookingModel.fromMap(b)))
              .toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> addToCompare(String token, String id) async {
    try {
      final result = await remoteDataSource.addToCompare(token, id);
      return Right(result['message']);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<DetailsPropertyItem>>> getCompareList(
      String token) async {
    try {
      final result = await remoteDataSource.compareList(token);
      final book = result['properties'] as List;
      final data = List<DetailsPropertyItem>.from(
          book.map((b) => DetailsPropertyItem.fromMap(b))).toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> removeCompare(String token, String id) async {
    try {
      final result = await remoteDataSource.removeCompare(token, id);
      return Right(result['message']);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
