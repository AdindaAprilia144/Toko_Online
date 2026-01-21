import 'package:flutter/material.dart';
import 'package:toko_online/services/user.dart';
import 'package:toko_online/widgets/alert.dart';

class RegisterUserView extends StatefulWidget {
  const RegisterUserView({super.key});

  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {
  UserService user = UserService();
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  List roleChoice = ["admin", "user"];
  String? role;

  final Color maroon = const Color(0xFF7B1E3A);
  final Color maroonSoft = const Color(0xFFB23A5A);
  final Color lightGrey = const Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("April Store"),
        backgroundColor: maroon,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: lightGrey,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Create New User",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: maroon,
                    ),
                  ),
                  const SizedBox(height: 22),

                  _inputField(
                    controller: name,
                    label: "Name",
                    icon: Icons.person,
                    validator: (v) => v!.isEmpty ? "Nama harus diisi" : null,
                  ),
                  const SizedBox(height: 14),

                  _inputField(
                    controller: email,
                    label: "Email",
                    icon: Icons.email,
                    validator: (v) => v!.isEmpty ? "Email harus diisi" : null,
                  ),
                  const SizedBox(height: 14),

                  DropdownButtonFormField(
                    value: role,
                    decoration: _decoration("Role", Icons.security),
                    items: roleChoice.map((r) {
                      return DropdownMenuItem(value: r, child: Text(r));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        role = value.toString();
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Role harus dipilih';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),

                  _inputField(
                    controller: password,
                    label: "Password",
                    icon: Icons.lock,
                    obscure: true,
                    validator: (v) =>
                        v!.isEmpty ? "Password harus diisi" : null,
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: maroonSoft,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 4,
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          var data = {
                            "name": name.text,
                            "email": email.text,
                            "role": role,
                            "password": password.text,
                          };

                          var result = await user.registerUser(data);

                          if (result.status == true) {
                            name.clear();
                            email.clear();
                            password.clear();
                            setState(() {
                              role = null;
                            });

                            AlertMessage().showAlert(
                              context,
                              result.message,
                              true,
                            );
                          } else {
                            AlertMessage().showAlert(
                              context,
                              result.message,
                              false,
                            );
                          }
                        }
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(fontSize: 16, color: Colors.white),
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

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      decoration: _decoration(label, icon),
    );
  }

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: maroon),
      filled: true,
      fillColor: Colors.white,
      labelStyle: TextStyle(color: maroon),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: maroon, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    );
  }
}
