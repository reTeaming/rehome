import 'package:equatable/equatable.dart';

class Id extends Equatable {
  const Id(this.id);

  final String id;

  @override
  List<Object> get props => [id];

  static const empty = Id('-');
}
