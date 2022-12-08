import 'package:hive/hive.dart';

part 'register.g.dart';

@HiveType(typeId: 1)
class Register extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String passwordConfirmation;

  Register(this.name, this.email, this.password, this.passwordConfirmation);
}
