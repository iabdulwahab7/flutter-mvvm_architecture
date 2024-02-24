// ignore_for_file: prefer_final_fields, unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/res/colors.dart';
import 'package:mvvm/res/components/round_botton.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    super.dispose();

    //for relief the ram after leaving this login screen
    _emailController.dispose();
    _passwordController.dispose();

    passwordFocusNode.dispose();
    emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                'LogIn',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                decoration: InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                onFieldSubmitted: (value) {
                  Utils.focusNodeChange(
                      context, emailFocusNode, passwordFocusNode);
                },
              ),
              const SizedBox(height: 10),
              ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: _obsecurePassword.value,
                      obscuringCharacter: '*',
                      focusNode: passwordFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_open_outlined),
                        suffix: InkWell(
                            onTap: () {
                              _obsecurePassword.value =
                                  !_obsecurePassword.value;
                            },
                            child: Icon(_obsecurePassword.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    );
                  }),
              SizedBox(
                height: height * 0.05,
              ),
              RoundButton(
                  title: 'LogIn',
                  loading: authViewModel.loading,
                  onPress: () {
                    if (_emailController.text.isEmpty) {
                      Utils.flushbarErrorMessage(
                          'Please! Enter your email address.', context);
                    } else if (_passwordController.text.isEmpty) {
                      Utils.flushbarErrorMessage(
                          'Please! Enter your password.', context);
                    } else if (_passwordController.text.length < 6) {
                      Utils.flushbarErrorMessage(
                          'Password must be 6 or more than 6 characters',
                          context);
                    } else {
                      // Map data = {
                      //   'email': _emailController.text.toString(),
                      //   'password': _passwordController.text.toString()
                      // };
                      Map data = {
                        'email': 'eve.holt@reqres.in',
                        'password': 'cityslicka'
                      };
                      authViewModel.loginApi(data, context);
                      if (kDebugMode) {
                        print('API hit');
                      }
                    }
                  }),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Don't have an account! "),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.signup);
                    },
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                          color: AppColors.textButtonColor,
                          fontSize: 16,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
