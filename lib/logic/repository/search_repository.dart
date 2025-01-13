import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:real_estate/data/model/home/home_data_model.dart';

import '/presentation/error/failure.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/model/search_response_model/search_response_model.dart';
import '../../presentation/error/exception.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Properties>>> getSearchProperty(Uri uri);
}

class SearchRepositoryImpl implements SearchRepository {
  final RemoteDataSource remoteDataSource;

  const SearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Properties>>> getSearchProperty(Uri uri) async {
    try {
      final result = await remoteDataSource.getSearchProperty(uri);
      log("${result}", name: "Resource Data");

      // Safely map the dynamic list to a List<Properties>
      final List<Properties> data = (result['data'] as List)
          .map((e) => Properties.fromJson(e as Map<String, dynamic>))
          .toList();

      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

}
