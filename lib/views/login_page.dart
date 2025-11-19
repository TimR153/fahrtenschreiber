import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'registration_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
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
            SizedBox(height: 20),
            authViewModel.isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      bool success = await authViewModel.signIn(
                          emailController.text, passwordController.text);
                      if (success) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(authViewModel.errorMessage ?? 'Fehler beim Login')),
                        );
                      }
                    },
                    child: Text('Login'),
                  ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => RegistrationPage()));
              },
              child: Text('Noch keinen Account? Registrieren'),
            ),
          ],
        ),
      ),
    );
  }
}
