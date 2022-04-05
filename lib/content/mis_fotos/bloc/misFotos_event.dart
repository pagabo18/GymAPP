part of 'misFotos_bloc.dart';

abstract class misFotosEvent extends Equatable {
  const misFotosEvent();

  @override
  List<Object> get props => [];
}

class GetAllMyFotosEvent extends misFotosEvent {}