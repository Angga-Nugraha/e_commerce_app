import 'package:e_commerce_app/domain/entities/auth.dart';
import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String token;

  const AuthModel({
    required this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };

  Auth toEntity() => Auth(token: token);

  @override
  List<Object?> get props => [token];
}
