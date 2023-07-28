part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {
  const LocationInitial();

  @override
  List<Object> get props => [];
}

class LocationLoading extends LocationState {}

class LocationSuccessState extends LocationState {
  final Position position;
  const LocationSuccessState({required this.position});

  @override
  List<Object> get props => [position];
}

class LocationErrorState extends LocationState {
  final String message;
  const LocationErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
