import 'package:bloc_lesson/login/models/login.dart';
import 'package:bloc_lesson/register/models/register.dart';
import 'package:hive/hive.dart';

class LoginService {
  late Box<Login> _login;
  late Box<Register> _register;
  late Box _box;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(0) && !Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(LoginAdapter());
      Hive.registerAdapter(RegisterAdapter());
    }

    _login = await Hive.openBox('login_box');
    _register = await Hive.openBox('register_box');
    _box = await Hive.openBox('box');
  }

  Future<LoginEnum> authenticateUser(String email, String password) async {
    final success = _register.values.any(
        (element) => element.email == email && element.password == password);
    if (success) {
      await _login.add(Login(email, password));
      await _box.put('isAuth', true);
    }

    LoginEnum result = success ? LoginEnum.registered : LoginEnum.notRegistered;
    return result;
  }
}

enum LoginEnum {
  registered,
  notRegistered,
}
