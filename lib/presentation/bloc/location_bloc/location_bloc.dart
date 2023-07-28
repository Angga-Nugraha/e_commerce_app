import 'package:e_commerce_app/domain/usecase/user/get_location.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  GetLocation getLocation;
  LocationBloc({required this.getLocation}) : super(const LocationInitial()) {
    on<GetLocationEvent>((event, emit) async {
      emit(LocationLoading());
      final result = await getLocation.execute();
      result.fold(
          (failure) => emit(LocationErrorState(message: failure.message)),
          (data) => emit(LocationSuccessState(position: data)));
    });
  }
}
