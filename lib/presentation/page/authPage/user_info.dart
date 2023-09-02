import 'package:e_commerce_app/data/common/style.dart';
import 'package:e_commerce_app/domain/entities/adress.dart';
import 'package:e_commerce_app/domain/entities/geolocation.dart';
import 'package:e_commerce_app/domain/entities/name.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:e_commerce_app/presentation/components/components_helper.dart';
import 'package:e_commerce_app/presentation/components/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _numbController = TextEditingController();
  TextEditingController _zipcodeController = TextEditingController();

  late Geolocation location;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<UserBloc>(context, listen: false)
        .add(FetchUserById(id: userId)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context,
        title: "Personal detail",
        trailingIcon: Icons.edit_document,
        trailingOnTap: () {
          myDialog(
            context: context,
            content: "Save changes?",
            title: "Update User",
            onPressed1: () {
              context.read<UserBloc>().add(EditEventClick(
                    userId: userId,
                    email: _emailController.text,
                    username: _userNameController.text,
                    password: _passController.text,
                    name: Name(
                        firstname: _firstNameController.text,
                        lastname: _lastNameController.text),
                    address: Address(
                      city: _cityController.text,
                      street: _streetController.text,
                      number: int.parse(_numbController.text),
                      zipcode: _zipcodeController.text,
                      geolocation: location,
                    ),
                    phone: _phoneController.text,
                  ));
              Navigator.pop(context);
            },
            onPressed2: () => Navigator.pop(context),
          );
        },
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserHasError) {}
          if (state is EditSuccessState) {
            mySnackBar(context, content: state.message);
          }
        },
        builder: (context, state) {
          if (state is UserHasData) {
            location = state.result.address.geolocation;
            _userNameController =
                TextEditingController(text: state.result.username);
            _firstNameController =
                TextEditingController(text: state.result.name.firstname);
            _lastNameController =
                TextEditingController(text: state.result.name.lastname);
            _emailController = TextEditingController(text: state.result.email);
            _passController =
                TextEditingController(text: state.result.password);
            _phoneController = TextEditingController(text: state.result.phone);
            _cityController =
                TextEditingController(text: state.result.address.city);
            _streetController =
                TextEditingController(text: state.result.address.street);
            _numbController = TextEditingController(
                text: state.result.address.number.toString());
            _zipcodeController = TextEditingController(
                text: state.result.address.zipcode.toString());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey.shade300,
                    foregroundImage: const AssetImage(
                      "assets/img/avatar.png",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: myTextfield(
                        label: "Firstname",
                        controller: _firstNameController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: myTextfield(
                          label: "lastname", controller: _lastNameController),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                myTextfield(label: "Email", controller: _emailController),
                const SizedBox(height: 15),
                myTextfield(label: "Username", controller: _userNameController),
                const SizedBox(height: 15),
                myTextfield(
                    label: "Password",
                    controller: _passController,
                    obscureText: true),
                const SizedBox(height: 15),
                myTextfield(label: "Phone", controller: _phoneController),
                const SizedBox(height: 15),
                Text('Addres', style: kLabel),
                const SizedBox(height: 15),
                myTextfield(label: "City", controller: _cityController),
                const SizedBox(height: 15),
                myTextfield(label: "Street", controller: _streetController),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: myTextfield(
                        label: "Number",
                        controller: _numbController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: myTextfield(
                          label: "ZipCode", controller: _zipcodeController),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
