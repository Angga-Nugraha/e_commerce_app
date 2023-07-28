import 'package:equatable/equatable.dart';

class Name extends Equatable {
  final String firstname;
  final String lastname;

  const Name({
    required this.firstname,
    required this.lastname,
  });

  @override
  List<Object?> get props => [
        firstname,
        lastname,
      ];
}
