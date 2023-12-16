import 'package:flutter_bloc/flutter_bloc.dart';

class loadBloc extends Bloc<LoadEvents, LoadStates> {
  loadBloc() : super(Loading()) {
    on<LoadLoaded>((event, emit) => emit(Loaded()));
    on<LoadLoading>((event, emit) => emit(Loading()));
    on<LoadFailedLoading>((event, emit) => emit(FailedLoading()));
  }
}

sealed class LoadEvents {}

class LoadLoaded extends LoadEvents {}

class LoadLoading extends LoadEvents {}

class LoadFailedLoading extends LoadEvents {}

sealed class LoadStates {}

class Loaded extends LoadStates {}

class Loading extends LoadStates {}

class FailedLoading extends LoadStates {}