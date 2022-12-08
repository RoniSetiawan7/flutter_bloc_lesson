import 'package:bloc_lesson/check_auth.dart';
import 'package:bloc_lesson/login/services/login_service.dart';
import 'package:bloc_lesson/register/services/register_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
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
        home: const CheckAuth(),
      ),
    );
  }
}
