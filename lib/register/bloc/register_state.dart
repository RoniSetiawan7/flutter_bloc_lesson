part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitialState extends RegisterState {}

class RegisterServiceInitState extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSuccessState extends RegisterState {
  final String name;
  const RegisterSuccessState(this.name);

  @override
  List<Object> get props => [name];
}

class RegisterErrorState extends RegisterState {
  final String? error;
  const RegisterErrorState(this.error);

  @override
  List<Object> get props => [error ?? ''];
}
