import 'package:admin_app/pages/deleteUserConfirmation.dart';
import 'package:admin_app/widget/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteUser extends StatefulWidget {
  const DeleteUser({super.key});
  static const String route = '/userManagement/deleteUser';

  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureTextPassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  togglePasswordVisibility() {
    setState(() {
      obscureTextPassword = !obscureTextPassword;
    });
  }

  checkIfUserAndPasswordExist(context) async {
    setState(() {
      isLoading = true;
    });
    final auth = FirebaseAuth.instance;
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      if (userCredential.user != null) {
        StatusAlert.show(
          context,
          duration: const Duration(seconds: 2),
          subtitle: AppLocalizations.of(context)!.account_success_delete,
          configuration: const IconConfiguration(icon: Icons.waving_hand),
          maxWidth: 260,
          backgroundColor: Theme.of(context).colorScheme.secondary,
        );
        Navigator.of(context)
            .pushReplacementNamed(DeleteUserConfirmation.route);
      }
    } catch (e) {
      if (e is FirebaseAuthException &&
          (e.code == 'user-not-found' ||
              e.code == 'wrong-password' ||
              e.code == 'invalid-email')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.error_message_1),
            duration: const Duration(seconds: 5),
          ),
        );
      } else if (e is FirebaseAuthException && e.code == 'user-disabled') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.error_message_2,
            ),
            duration: const Duration(seconds: 5),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.error_message_3,
            ),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  buildDeleteUser(context) {
    return Center(
      child: SizedBox(
        width: 360,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 64.0),
              Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.delete_user,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              Text(
                AppLocalizations.of(context)!.delete_user_undertitle,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8F9),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.email_necessary;
                    } else if (!value.contains("@")) {
                      return AppLocalizations.of(context)!.email_must_have_a;
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {
                      checkIfUserAndPasswordExist(context);
                    }
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.email,
                    hintText: AppLocalizations.of(context)!.email_hint_text,
                    suffixIcon: const Icon(Icons.email),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8F9),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.password_necessary;
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    if (_formKey.currentState!.validate()) {
                      checkIfUserAndPasswordExist(context);
                    }
                  },
                  controller: passwordController,
                  obscureText: obscureTextPassword,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.password,
                    hintText: AppLocalizations.of(context)!.password,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureTextPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: togglePasswordVisibility,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          checkIfUserAndPasswordExist(context);
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.confirm,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  createLoadingOverlay() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: header(context, removeBackButton: true),
        body: Stack(
          children: [
            if (isLoading) createLoadingOverlay(),
            buildDeleteUser(context),
          ],
        ),
      ),
    );
  }
}
