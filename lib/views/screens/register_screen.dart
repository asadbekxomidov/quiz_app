import 'package:dars_5/controllers/auth_controller.dart';
import 'package:dars_5/utils/messeges.dart';
import 'package:dars_5/views/widgets/my_textfield_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();

  void submit() {
    if (formKey.currentState!.validate()) {
      Messages.showLoadingDialog(context);
      Provider.of<AuthController>(context, listen: false)
          .register(emailController.text, passwordController.text, context);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reister'),
        backgroundColor: Colors.purple.shade300,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.abc,
                  size: 150,
                  color: Colors.blue,
                ),
                Text(
                  "TIZIMGA KIRISH",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: emailController,
                  label: "Elektron pochta",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Iltimos pochta kiriting";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  label: "Parol",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Iltimos parol kiriting";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordConfirmationController,
                  label: "Parolni tasdiqlang",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Iltimos parol tasdiqlang";
                    }
                    if (passwordController.text != passwordConfirmationController.text) {
                      return "Parollar mos kelmadi";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: submit,
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text("R O' Y X A T D A N  O' T I S H"),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Tizimga Kirish"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
