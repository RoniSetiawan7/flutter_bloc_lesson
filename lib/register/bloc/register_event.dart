part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterServiceInitEvent extends RegisterEvent {
  @override
  List<Object> get props => [];
}

class RegisterButtonEvent extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  const RegisterButtonEvent(
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
  );

  @override
  List<Object> get props => [name, email, password, passwordConfirmation];
}
