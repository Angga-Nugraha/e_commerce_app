import "package:e_commerce_app/data/common/routes.dart";
import "package:e_commerce_app/data/database/preference_helper.dart";
import "package:e_commerce_app/presentation/bloc/auth_bloc/auth_bloc.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:e_commerce_app/data/common/style.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import '../../components/components_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  static bool obscure = true;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
            children: [
              Center(child: Image.asset("assets/img/logo.png")),
              const SizedBox(height: 50),
              Text(
                "Welcome!",
                style: kTitle,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Please Login or ",
                    style: kSubTitle.copyWith(color: Colors.black),
                  ),
                  TextSpan(
                    text: "Sign Up",
                    style: kSubTitle.copyWith(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.pushNamedAndRemoveUntil(
                          context, signUpPageRoute, (route) => false),
                  ),
                  TextSpan(
                    text: " to continue our app",
                    style: kSubTitle.copyWith(color: Colors.black),
                  ),
                ]),
              ),
              const SizedBox(height: 50),
              myTextfield(
                  label: "Username",
                  type: TextInputType.emailAddress,
                  controller: _usernameController),
              const SizedBox(height: 20),
              myTextfield(
                label: "Password",
                type: TextInputType.visiblePassword,
                controller: _passwordController,
                obscureText: obscure,
                suffixIcon: obscure
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            obscure = false;
                          });
                        },
                        child: const Icon(Icons.visibility_off, size: 16),
                      )
                    : InkWell(
                        onTap: () {
                          setState(() {
                            obscure = true;
                          });
                        },
                        child: const Icon(Icons.visibility, size: 16),
                      ),
              ),
              const SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  int id = 0;
                  if (state is AuthenticatedState) {
                    if (_usernameController.text == 'johnd') {
                      id = 1;
                    } else if (_usernameController.text == 'mor_2314') {
                      id = 2;
                    } else if (_usernameController.text == 'kevinryan') {
                      id = 3;
                    } else if (_usernameController.text == 'donero') {
                      id = 4;
                    } else if (_usernameController.text == 'derek') {
                      id = 5;
                    } else if (_usernameController.text == 'david') {
                      id = 6;
                    } else if (_usernameController.text == 'snyder') {
                      id = 7;
                    } else if (_usernameController.text == 'hopkins') {
                      id = 8;
                    } else if (_usernameController.text == 'kate_h') {
                      id = 9;
                    } else if (_usernameController.text == 'jimmie_k') {
                      id = 10;
                    } else {
                      id = 0;
                    }
                    preferencesHelper.saveUserId(id);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      botNavBarRoute,
                      arguments: id,
                      (route) => false,
                    );
                  }
                  if (state is UnAuthenticatedState) {
                    myDialog(
                      content: state.message,
                      context: context,
                      onPressed1: () => Navigator.pop(context),
                      onPressed2: () => Navigator.pop(context),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return myLoading(title: "Sign in ...");
                  }
                  return myBotton(
                    context: context,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              LoginEvent(
                                username: _usernameController.text,
                                password: _passwordController.text,
                              ),
                            );
                      }
                    },
                    label: "Login",
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                "or\nLogin to continue with",
                style: kSubTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAvatar(
                      context: context, assets: 'assets/img/google.png'),
                  _buildAvatar(context: context, assets: "assets/img/fb.png"),
                  _buildAvatar(
                      context: context, assets: "assets/img/twitter.png"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell _buildAvatar({BuildContext? context, String? assets}) {
    return InkWell(
      onTap: () {
        myDialog(
          context: context!,
          title: 'Upss Sorry',
          content: 'This fitur not ready to use',
          onPressed1: () => Navigator.pop(context),
          onPressed2: () => Navigator.pop(context),
        );
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.asset(assets!),
      ),
    );
  }
}
