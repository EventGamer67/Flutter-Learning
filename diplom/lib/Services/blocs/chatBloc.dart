// ignore_for_file: camel_case_types, file_names

import 'package:flutter_bloc/flutter_bloc.dart';

class chatBloc extends Bloc<ChatEvents, ChatStates> {
  chatBloc() : super(Loading()) {
    on<ChatLoaded>((event, emit) => emit(Loaded()));
    on<ChatLoading>((event, emit) => emit(Loading()));
    on<ChatFailedLoading>((event, emit) => emit(FailedLoading()));
  }
}

sealed class ChatEvents {}

class ChatLoaded extends ChatEvents {}

class ChatLoading extends ChatEvents {}

class ChatFailedLoading extends ChatEvents {}

sealed class ChatStates {}

class Loaded extends ChatStates {}

class Loading extends ChatStates {}

class FailedLoading extends ChatStates {}
