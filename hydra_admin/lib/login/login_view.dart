import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: loginController.formKey,
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Login ',
                          style: TextStyle(fontFamily: 'Medium', fontSize: 20, color: Colors.teal),),
                        Text('Admin',
                          style: TextStyle(fontFamily: 'Medium', fontSize: 20, color: Colors.orange),),
                      ],),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontFamily: 'Medium'),
                      controller: loginController.userNameController,
                      decoration: InputDecoration(
                          labelText: 'User Name',
                          labelStyle: const TextStyle(fontFamily: 'Medium'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                          prefixIcon:
                          const Icon(Icons.person, color: Colors.teal)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter User Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                          () => TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        style: const TextStyle(fontFamily: 'Medium'),
                        controller: loginController.passwordController,
                        obscureText: loginController.isVisible.value,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(fontFamily: 'Medium'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            prefixIcon:
                            const Icon(Icons.lock, color: Colors.teal),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  loginController.togglePassword();
                                },
                                icon: Icon(
                                  loginController.isVisible.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.teal,
                                ))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Password';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            loginController.login();
                          },
                          child: Obx(() => loginController.loading.value
                              ? const CircularProgressIndicator(strokeWidth: 3, color: Colors.teal)
                              : const Text(
                            'Login',
                            style:
                            TextStyle(
                                fontSize: 18,
                                fontFamily: 'Medium',
                              color: Colors.teal
                            ),
                          )
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}