import 'package:equatable/equatable.dart';

class StatusCode extends Equatable{
  final String id;
  final String name;

  const StatusCode(this.id, this.name);

  @override
  List<Object?> get props => [id, name];
}
final List<StatusCode> statusCodeList = [
  const StatusCode("1", "Active"),
  const StatusCode("2", "Inactive"),

];