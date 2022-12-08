part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginServiceInitState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginState {
  final String email;
  const LoginSuccessState(this.email);

  @override
  List<Object> get props => [email];
}

class LoginErrorState extends LoginState {
  final String? error;
  const LoginErrorState(this.error);

  @override
  List<Object> get props => [error ?? ''];
}
