import 'package:bloc_lesson/dashboard/dashboard.dart';
import 'package:bloc_lesson/login/login.dart';
import 'package:bloc_lesson/login/services/login_service.dart';
import 'package:bloc_lesson/register/services/register_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box _box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  _box = await Hive.openBox('box');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => LoginService()),
        RepositoryProvider(create: (context) => RegisterService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter BLoC with Hive',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _box.get('isAuth', defaultValue: false)
            ? const DashboardScreen()
            : const LoginScreen(),
      ),
    );
  }
}
