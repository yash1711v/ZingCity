import 'package:dartz/dartz.dart';

import '/presentation/error/failure.dart';
import '../../data/data_provider/remote_data_source.dart';
import '../../data/model/ticket/ticket_model.dart';
import '../../presentation/error/exception.dart';

abstract class SupportRepository {
  Future<Either<Failure, List<TicketModel>>> getAllTickets(String token);

  Future<Either<Failure, List<TicketModel>>> showTicket(String token, String id);

  Future<Either<Failure, List<String>>> getPriorityList(String token);

  Future<Either<Failure, String>> createTicket(TicketModel body);

  Future<Either<Failure, String>> sendMessage(TicketModel body);
}

class SupportRepositoryImpl implements SupportRepository {
  final RemoteDataSource remoteDataSource;

  SupportRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> createTicket(TicketModel body) async {
    try {
      final result = await remoteDataSource.createTicket(body);
      //final data = TicketModel.fromMap(result['ticket']);
      return Right(result['message']);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, List<TicketModel>>> getAllTickets(String token) async {
    try {
      final result = await remoteDataSource.getAllTickets(token);
      final ticket = result['support_tickets'] as List;
      final data = List<TicketModel>.from(ticket.map((t) => TicketModel.fromMap(t)))
              .toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPriorityList(String token) async {
    try {
      final result = await remoteDataSource.getPriorityList(token);
      final ticket = result['priorities'] as List;
      final data = List<String>.from(ticket.map((t) => t as String)).toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> sendMessage(TicketModel body) async {
    try {
      final result = await remoteDataSource.sendMessage(body);
      // final data = TicketModel.fromMap(result['ticket_message']);
      return Right(result['message']);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    } on InvalidAuthData catch (e) {
      return Left(InvalidAuthData(e.errors));
    }
  }

  @override
  Future<Either<Failure, List<TicketModel>>> showTicket(
      String token, String id) async {
    try {
      final result = await remoteDataSource.showTicket(token, id);
      final ticket = result['ticket_messages'] as List;
      final data =
          List<TicketModel>.from(ticket.map((t) => TicketModel.fromMap(t)))
              .toList();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
