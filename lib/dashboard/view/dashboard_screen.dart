import 'package:bloc_lesson/login/login.dart';
import 'package:bloc_lesson/login/models/login.dart';
import 'package:bloc_lesson/register/models/register.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Box<Login> _login;
  late Box<Register> _register;
  late Box _box;

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

    _box = Hive.box('box');
    _login = await Hive.openBox('login_box');
    _register = await Hive.openBox('register_box');
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
                child: ElevatedButton.icon(
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
                            'Do you want to logout?',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                logout();
                              },
                              child: const Text('Yes'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No'),
                            )
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: ElevatedButton.icon(
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
                            'Are you sure want to delete your data then logout?',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                logoutAndDeleteData();
                              },
                              child: const Text('Yes'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No'),
                            )
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('Delete Account'),
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
                    Text('Name : ${_box.get('name')}'),
                    const SizedBox(height: 10),
                    Text('Email : ${_box.get('email')}'),
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
    _box.delete('isAuth');
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
