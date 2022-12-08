import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_lesson/register/services/register_service.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterService _registerService;

  RegisterBloc(this._registerService) : super(RegisterServiceInitState()) {
    on<RegisterServiceInitEvent>((event, emit) async {
      await _registerService.init();
      emit(RegisterInitialState());
    });

    on<RegisterButtonEvent>((event, emit) async {
      RegisterEnum result = await _registerService.addUser(
          event.name, event.email, event.password, event.passwordConfirmation);
      switch (result) {
        case RegisterEnum.successful:
          emit(RegisterSuccessState(event.name));
          emit(RegisterInitialState());
          break;
        case RegisterEnum.hasRegistered:
          emit(const RegisterErrorState('This email already registered'));
          break;
      }
    });
  }
}
