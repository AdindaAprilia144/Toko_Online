import 'package:flutter/material.dart';
import 'package:toko_online/services/user.dart';
import 'package:toko_online/widgets/alert.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  UserService user = UserService();
  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLoading = false;
  bool showPass = true;

  // 🎨 WARNA
  final Color maroon = const Color(0xFF7B1E3A);
  final Color maroonSoft = const Color(0xFFB23A5A);
  final Color lightGrey = const Color(0xFFF4F4F4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("April Store"),
        centerTitle: true,
        backgroundColor: maroon,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: lightGrey,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: maroon,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // email
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email, color: maroon),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email harus diisi';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 14),

                  // pw
                  TextFormField(
                    controller: password,
                    obscureText: showPass,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock, color: maroon),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                        icon: Icon(
                          showPass
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: maroon,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password harus diisi';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // login button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: MaterialButton(
                      color: maroonSoft,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          var data = {
                            "email": email.text,
                            "password": password.text,
                          };

                          var result = await user.loginUser(data);

                          setState(() {
                            isLoading = false;
                          });

                          if (result.status == true) {
                            AlertMessage().showAlert(
                              context,
                              result.message,
                              true,
                            );
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/dashboard',
                              );
                            });
                          } else {
                            AlertMessage().showAlert(
                              context,
                              result.message,
                              false,
                            );
                          }
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "LOGIN",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
