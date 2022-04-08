part of 'DefRoutine_bloc.dart';

abstract class DefRoutineState extends Equatable {
  const DefRoutineState();

  @override
  List<Object> get props => [];
}

class DefRoutineInitial extends DefRoutineState {}

class DefRoutineSuccessState extends DefRoutineState {
  // lista de elementos de firebase "fshare collection"
  final List<Map<String, dynamic>> myDisabledData;

  DefRoutineSuccessState({required this.myDisabledData});
  @override
  List<Object> get props => [myDisabledData];
}

class DefRoutineErrorState extends DefRoutineState {}

class DefRoutineEmptyState extends DefRoutineState {}

class DefRoutineLoadingState extends DefRoutineState {}
