import 'package:bloc_lesson/dashboard/dashboard.dart';
import 'package:bloc_lesson/login/login.dart';
import 'package:bloc_lesson/login/models/login.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CheckAuth extends StatefulWidget {
  const CheckAuth({super.key});

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  late Box<Login> _login;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(LoginAdapter());
    }
  }

  @override
  void initState() {
    super.initState();
    checkData();
  }

  void checkData() async {
    _login = await Hive.openBox('login_box');

    if (_login.isNotEmpty) {
      setState(() {
        isAuth = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? const DashboardScreen() : const LoginScreen();
  }
}
