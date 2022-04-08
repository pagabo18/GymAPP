part of 'DefRoutine_bloc.dart';

abstract class DefRoutineEvent extends Equatable {
  const DefRoutineEvent();

  @override
  List<Object> get props => [];
}

class GetAllMyDisabledEvent extends DefRoutineEvent {}
