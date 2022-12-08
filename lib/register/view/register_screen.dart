import 'package:bloc_lesson/login/login.dart';
import 'package:bloc_lesson/register/bloc/register_bloc.dart';
import 'package:bloc_lesson/register/services/register_service.dart';
import 'package:bloc_lesson/widget/hide_keyboard.dart';
import 'package:bloc_lesson/widget/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocProvider(
            create: (context) {
              return RegisterBloc(
                  RepositoryProvider.of<RegisterService>(context))
                ..add(RegisterServiceInitEvent());
            },
            child: RegisterForm(),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  RegisterForm({super.key});

  final formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _passwordConfirmation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          hideKeyboard(context);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
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
                  '${state.name}\'s account created\nlogin with your account',
                  textAlign: TextAlign.center,
                ),
              );
            },
          );
        }
        if (state is RegisterErrorState) {
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
              'Form Register',
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
                            'https://cdn3d.iconscout.com/3d/premium/thumb/man-holding-sign-up-form-2937684-2426382.png',
                          ),
                        ),
                        const SizedBox(height: 60),
                        TextFormField(
                          controller: _name,
                          decoration: myInputDecoration(
                            icon: Icons.person_outline,
                            label: 'Name',
                            hintText: 'Type your name here',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 5),
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
                            if (value.length < 8) {
                              return 'Password must contain at least 8 character';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _passwordConfirmation,
                          obscureText: true,
                          decoration: myInputDecoration(
                            icon: Icons.lock_outline,
                            label: 'Password Confirmation',
                            hintText: 'Type your password confirmation here',
                          ).copyWith(
                            suffixIcon: const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.blueAccent,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password confirmation required';
                            }
                            if (value.length < 8) {
                              return 'Password confirmation must contain at least 8 character';
                            }
                            if (value != _password.text) {
                              return 'Password confirmation doesn\'t match';
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
                                context.read<RegisterBloc>().add(
                                      RegisterButtonEvent(
                                        _name.text,
                                        _email.text,
                                        _password.text,
                                        _passwordConfirmation.text,
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
                            child: const Text('Register'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account ?'),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text('Login here'),
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
