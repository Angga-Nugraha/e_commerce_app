import 'package:e_commerce_app/domain/entities/adress.dart';
import 'package:e_commerce_app/domain/entities/name.dart';
import 'package:e_commerce_app/domain/entities/user.dart';
import 'package:e_commerce_app/domain/usecase/auth/edit_user.dart';
import 'package:e_commerce_app/domain/usecase/user/get_user_by_id.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  GetUserById getUserById;
  EditUser editUser;

  UserBloc({required this.getUserById, required this.editUser})
      : super(UserInitial()) {
    on<FetchUserById>((event, emit) async {
      emit(UserLoading());

      final result = await getUserById.execute(event.id);
      result.fold(
        (failure) => emit(UserHasError(message: failure.message)),
        (data) => emit(UserHasData(result: data)),
      );
    });

    on<EditEventClick>((event, emit) async {
      final result = await editUser.execute(
        event.userId,
        event.email,
        event.username,
        event.password,
        event.name,
        event.address,
        event.phone,
      );

      result.fold(
        (failure) => emit(UserHasError(message: failure.message)),
        (data) => emit(EditSuccessState(data)),
      );
      add(FetchUserById(id: event.userId));
    });
  }
}
