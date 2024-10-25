import 'package:dartz/dartz.dart';

import '/data/data_provider/remote_data_source.dart';
import '/data/model/review/review_model.dart';
import '/presentation/error/exception.dart';
import '../../presentation/error/failure.dart';

abstract class ReviewRepository {
  Future<Either<Failure, List<ReviewModel>>> getReviewList(String token);

  Future<Either<dynamic, String>> storeReview(
      String token, Map<String, String> body);
}

class ReviewRepositoryImpl implements ReviewRepository {
  final RemoteDataSource remoteDataSource;

  const ReviewRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ReviewModel>>> getReviewList(String token) async {
    try {
      final result = await remoteDataSource.getReviewList(token);
      final reviews = result['data'] as List<dynamic>;
      final data =
          List<ReviewModel>.from(reviews.map((e) => ReviewModel.fromMap(e)))
              .toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<dynamic, String>> storeReview(
      String token, Map<String, String> body) async {
    try {
      final result = await remoteDataSource.storeReview(token, body);
      return Right(result);
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
