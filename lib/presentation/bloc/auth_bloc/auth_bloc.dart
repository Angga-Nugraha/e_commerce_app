import 'package:e_commerce_app/domain/entities/adress.dart';
import 'package:e_commerce_app/domain/entities/auth.dart';
import 'package:e_commerce_app/domain/entities/name.dart';
import 'package:e_commerce_app/domain/usecase/auth/authenticated.dart';
import 'package:e_commerce_app/domain/usecase/auth/sign_up.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Authenticated authenticated;
  final SignUp signUp;
  AuthBloc({
    required this.authenticated,
    required this.signUp,
  }) : super(AuthInitialState()) {
    on<LoginEvent>((event, emit) async {
      final username = event.username;
      final password = event.password;

      emit(AuthLoadingState());

      final auth = await authenticated.execute(username, password);
      auth.fold(
        (failure) => emit(UnAuthenticatedState(failure.message)),
        (data) => emit(AuthenticatedState(auth: data)),
      );
    });

    on<SignupEventClick>((event, emit) async {
      emit(AuthLoadingState());

      final result = await signUp.execute(
        event.email,
        event.username,
        event.password,
        event.name,
        event.address,
        event.phone,
      );

      result.fold(
        (failure) => emit(UnAuthenticatedState(failure.message)),
        (data) => emit(const AuthenticatedState(message: "Success")),
      );
    });
  }
}
