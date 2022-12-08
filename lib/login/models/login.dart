import 'package:hive/hive.dart';

part 'login.g.dart';

@HiveType(typeId: 0)
class Login extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String password;

  Login(this.email, this.password);
}
