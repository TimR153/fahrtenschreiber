import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Registrierung')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'E-Mail'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Passwort'),
              obscureText: true,
            ),
            TextField(
              controller: confirmPwController,
              decoration: InputDecoration(labelText: 'Passwort bestätigen'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            authViewModel.isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      if (passwordController.text != confirmPwController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Passwörter stimmen nicht überein')));
                        return;
                      }

                      bool success = await authViewModel.register(
                          emailController.text, passwordController.text);
                      if (success) {
                        Navigator.pop(context); // zurück zum Login
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(authViewModel.errorMessage ?? 'Fehler bei Registrierung')),
                        );
                      }
                    },
                    child: Text('Registrieren'),
                  ),
          ],
        ),
      ),
    );
  }
}
