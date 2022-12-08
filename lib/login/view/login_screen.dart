import 'package:bloc_lesson/dashboard/dashboard.dart';
import 'package:bloc_lesson/login/bloc/login_bloc.dart';
import 'package:bloc_lesson/login/services/login_service.dart';
import 'package:bloc_lesson/register/register.dart';
import 'package:bloc_lesson/widget/hide_keyboard.dart';
import 'package:bloc_lesson/widget/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocProvider(
            create: (context) {
              return LoginBloc(RepositoryProvider.of<LoginService>(context))
                ..add(LoginServiceInitEvent());
            },
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          hideKeyboard(context);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const DashboardScreen(),
            ),
            (route) => false,
          );

          showDialog(
            context: context,
            builder: (context) {
              Future.delayed(
                const Duration(seconds: 2),
                () => Navigator.of(context).pop(true),
              );
              return AlertDialog(
                title: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                content: Text(
                  'Welcome\n${state.email}',
                  textAlign: TextAlign.center,
                ),
              );
            },
          );
        }
        if (state is LoginErrorState) {
          showDialog(
            context: context,
            builder: (context) {
              Future.delayed(
                const Duration(seconds: 2),
                () => Navigator.of(context).pop(true),
              );
              return AlertDialog(
                title: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                content: Text(
                  '${state.error}',
                  textAlign: TextAlign.center,
                ),
              );
            },
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              'Form Login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 2,
              ),
            ),
          ),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          child: Image.network(
                            'https://cdn3d.iconscout.com/3d/premium/thumb/man-holding-login-form-2937688-2426390.png',
                          ),
                        ),
                        const SizedBox(height: 60),
                        TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: myInputDecoration(
                            icon: Icons.email_outlined,
                            label: 'Email',
                            hintText: 'Type your email here',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email required';
                            }
                            if (!RegExp(
                              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
                            ).hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _password,
                          obscureText: true,
                          decoration: myInputDecoration(
                            icon: Icons.lock_outline,
                            label: 'Password',
                            hintText: 'Type your password here',
                          ).copyWith(
                            suffixIcon: const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.blueAccent,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                      LoginButtonEvent(
                                        _email.text,
                                        _password.text,
                                      ),
                                    );
                              }
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                            ),
                            child: const Text('Login'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Doesn\'t have an account ?'),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Text('Register here'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
