import 'package:bloc_lesson/login/login.dart';
import 'package:bloc_lesson/login/models/login.dart';
import 'package:bloc_lesson/register/models/register.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DashboardScreen extends StatefulWidget {
  final String? email, password;
  const DashboardScreen({super.key, this.email, this.password});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Box<Login> _login;
  late Box<Register> _register;

  late Box _box;
  String? myName, myEmail;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    if (!Hive.isAdapterRegistered(0) && !Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(LoginAdapter());
      Hive.registerAdapter(RegisterAdapter());
    }

    _login = await Hive.openBox('login_box');
    _register = await Hive.openBox('register_box');

    _box = await Hive.openBox('box');

    setState(() {
      myName = _box.get('name');
      myEmail = _box.get('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Icon(
                            Icons.question_mark,
                            color: Colors.blue,
                          ),
                          content: const Text(
                            'Wanna logout?',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                logout();
                              },
                              child: const Text('Yup'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Nah'),
                            )
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.logout),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Icon(
                            Icons.question_mark,
                            color: Colors.blue,
                          ),
                          content: const Text(
                            'Are you sure to logout and delete your data?',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                logoutAndDeleteData();
                              },
                              child: const Text('Yup'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Nah'),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Delete my data\nand logout',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      child: Image.network(
                        'https://cdn3d.iconscout.com/3d/premium/thumb/handsome-boy-4929611-4118354.png',
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text('Name : $myName'),
                    const SizedBox(height: 10),
                    Text('Email : $myEmail'),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logout() async {
    _login.clear().then(
      (_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(
              const Duration(seconds: 2),
              () => Navigator.of(context).pop(true),
            );
            return const AlertDialog(
              title: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              content: Text(
                'Logout successfuly',
                textAlign: TextAlign.center,
              ),
            );
          },
        );
      },
    );
  }

  void logoutAndDeleteData() async {
    _box.clear();
    _register.clear();
    _login.clear().then(
      (_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(
              const Duration(seconds: 2),
              () => Navigator.of(context).pop(true),
            );
            return const AlertDialog(
              title: Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              content: Text(
                'Logout and delete data successfuly',
                textAlign: TextAlign.center,
              ),
            );
          },
        );
      },
    );
  }
}
