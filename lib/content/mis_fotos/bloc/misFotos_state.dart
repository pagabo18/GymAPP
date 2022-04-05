part of 'misFotos_bloc.dart';

abstract class misFotosState extends Equatable {
  const misFotosState();

  @override
  List<Object> get props => [];
}

class misFotosInitial extends misFotosState {}

class misFotosFotosSuccessState extends misFotosState {
  // lista de elementos de firebase "fshare collection"
  final List<Map<String, dynamic>> myEnableData;

  misFotosFotosSuccessState({required this.myEnableData});
  @override
  List<Object> get props => [myEnableData];
}

class misFotosFotosErrorState extends misFotosState {}

class misFotosFotosEmptyState extends misFotosState {}

class misFotosFotosLoadingState extends misFotosState {}