import 'package:bloc_lesson/register/models/register.dart';
import 'package:hive/hive.dart';

class RegisterService {
  late Box<Register> _register;
  late Box _box;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(RegisterAdapter());
    }
    _register = await Hive.openBox('register_box');
    _box = await Hive.openBox('box');
  }

  Future<RegisterEnum> addUser(String name, String email, String password,
      String passwordConfirmation) async {
    final userExist = _register.values
        .any((element) => element.email.toLowerCase() == email.toLowerCase());
    if (userExist) {
      return RegisterEnum.hasRegistered;
    } else {
      await _register
          .add(Register(name, email, password, passwordConfirmation));

      await _box.put('name', name);
      await _box.put('email', email);

      return RegisterEnum.successful;
    }
  }
}

enum RegisterEnum {
  successful,
  hasRegistered,
}
