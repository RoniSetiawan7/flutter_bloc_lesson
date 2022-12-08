import 'package:bloc_lesson/login/services/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService _loginService;

  LoginBloc(this._loginService) : super(LoginServiceInitState()) {
    on<LoginServiceInitEvent>((event, emit) async {
      await _loginService.init();
      emit(LoginInitialState());
    });

    on<LoginButtonEvent>((event, emit) async {
      LoginEnum result =
          await _loginService.authenticateUser(event.email, event.password);

      switch (result) {
        case LoginEnum.registered:
          emit(LoginSuccessState(event.email));
          emit(LoginInitialState());
          break;
        case LoginEnum.notRegistered:
          emit(const LoginErrorState('Invalid username or password'));
          break;
      }
    });
  }
}
