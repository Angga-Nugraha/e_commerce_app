import "package:e_commerce_app/data/common/routes.dart";
import "package:e_commerce_app/domain/entities/adress.dart";
import "package:e_commerce_app/domain/entities/geolocation.dart";
import "package:e_commerce_app/domain/entities/name.dart";
import "package:e_commerce_app/presentation/bloc/auth_bloc/auth_bloc.dart";
import "package:e_commerce_app/presentation/bloc/location_bloc/location_bloc.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:e_commerce_app/data/common/style.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import '../../components/components_helper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  static bool obscure = true;

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _numbController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confPasswordController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _numbController.dispose();
    _zipCodeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              myDialog(
                context: context,
                title: state.message,
                content:
                    "Akan tetapi akun yang anda buat tidak benar-benar di simpan dalam database kami",
                onPressed1: () => Navigator.pushNamed(context, firstPageRoute),
                onPressed2: () => Navigator.pop(context),
              );
            }
            if (state is UnAuthenticatedState) {
              myDialog(
                context: context,
                content: state.message,
                onPressed1: () => Navigator.pop(context),
                onPressed2: () => Navigator.pop(context),
              );
            }
          },
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(25.0),
              children: [
                Center(child: Image.asset("assets/img/logo.png")),
                Text(
                  "Sign Up!",
                  style: kTitle,
                ),
                Text(
                  "Create an new account",
                  style: kSubTitle,
                ),
                const SizedBox(height: 10),
                myTextfield(
                    label: "First Name", controller: _firstNameController),
                const SizedBox(height: 10),
                myTextfield(
                    label: "Last Name", controller: _lastNameController),
                const SizedBox(height: 10),
                myTextfield(
                    label: "Email",
                    type: TextInputType.emailAddress,
                    controller: _emailController),
                const SizedBox(height: 10),
                myTextfield(
                    label: "Username",
                    type: TextInputType.emailAddress,
                    controller: _usernameController),
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                myTextfield(
                  label: "Confirm Password",
                  type: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value! != _passwordController.text) {
                      return "Password tidak cocok";
                    } else {
                      return null;
                    }
                  },
                  controller: _confPasswordController,
                  obscureText: obscure,
                ),
                const SizedBox(height: 10),
                Text(
                  "Address",
                  style: kLabel,
                ),
                const SizedBox(height: 10),
                myTextfield(label: "City", controller: _cityController),
                const SizedBox(height: 10),
                myTextfield(label: "Street", controller: _streetController),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: myTextfield(
                        label: "No",
                        controller: _numbController,
                        type: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: myTextfield(
                          label: "Zipcode", controller: _zipCodeController),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                myTextfield(
                  label: "Phone",
                  controller: _phoneController,
                  type: TextInputType.number,
                ),
                const SizedBox(height: 10),
                BlocConsumer<LocationBloc, LocationState>(
                  listener: (context, state) {
                    if (state is LocationSuccessState) {
                      context.read<AuthBloc>().add(
                            SignupEventClick(
                              email: _emailController.text,
                              username: _usernameController.text,
                              password: _passwordController.text,
                              name: Name(
                                firstname: _firstNameController.text,
                                lastname: _lastNameController.text,
                              ),
                              address: Address(
                                city: _cityController.text,
                                street: _streetController.text,
                                number: int.parse(_numbController.text),
                                zipcode: _zipCodeController.text,
                                geolocation: Geolocation(
                                  lat: state.position.latitude.toString(),
                                  long: state.position.longitude.toString(),
                                ),
                              ),
                              phone: _phoneController.text,
                            ),
                          );
                    }
                  },
                  builder: (context, state) {
                    return BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoadingState) {
                          return myLoading(title: "Sign up...");
                        }
                        return myBotton(
                          context: context,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context
                                  .read<LocationBloc>()
                                  .add(const GetLocationEvent());
                            }
                          },
                          label: "Register",
                        );
                      },
                    );
                  },
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Already account? ",
                      style: kSubTitle.copyWith(color: Colors.black),
                    ),
                    TextSpan(
                      text: "Login",
                      style: kSubTitle.copyWith(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushNamedAndRemoveUntil(
                            context, loginPageRoute, (route) => false),
                    ),
                    TextSpan(
                        text: " here",
                        style: kSubTitle.copyWith(
                          color: Colors.black,
                        ))
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
