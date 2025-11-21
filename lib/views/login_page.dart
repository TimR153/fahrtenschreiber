import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePw = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final authViewModel = context.read<AuthViewModel>();
    authViewModel.clearError();

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte E-Mail und Passwort eingeben')),
      );
      return;
    }

    bool success = await authViewModel.signIn(email, password);

    if (!success && authViewModel.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login fehlgeschlagen: ${authViewModel.errorMessage}')),
      );
    }
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  // Logo
                  Container(
                    margin: const EdgeInsets.only(bottom: 32, top: 16),
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                      child: Icon(Icons.book, size: 56, color: theme.colorScheme.primary),
                    ),
                  ),
                  // Title
                  Text(
                    'Fahrtenschreiber',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Subtitle
                  Text(
                    'Logistik leicht gemacht. Bitte melden Sie sich an, um fortzufahren.',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // Email field
                  OutlinedTextField(
                    controller: _emailController,
                    labelText: 'E-Mail',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  // Password field
                  OutlinedTextField(
                    controller: _passwordController,
                    labelText: 'Passwort',
                    obscureText: _obscurePw,
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePw ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _obscurePw = !_obscurePw),
                    ),
                  ),
                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Hier Passwort-vergessen-Flow triggern
                      },
                      child: const Text('Passwort vergessen?'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Login button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton.icon(
                      icon: const Icon(Icons.login),
                      onPressed: authViewModel.isLoading ? null : _login,
                      label: authViewModel.isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Anmelden'),
                      style: FilledButton.styleFrom(
                        textStyle: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Oder Divider
                  Row(
                    children: [
                      const Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('ODER', style: theme.textTheme.labelLarge),
                      ),
                      const Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Social login buttons (Icons können beliebig ersetzt oder erweitert werden)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.g_mobiledata),
                          onPressed: () {/* Google Login */},
                          label: const Text('Google'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.apple),
                          onPressed: () {/* Apple Login */},
                          label: const Text('Apple'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Registrierung Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Noch kein Konto?', style: theme.textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {/* Registration flow */},
                        child: const Text('Registrieren'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Hilfs-Widget für Material 3 OutlinedTextField, kann ggf. noch ausgelagert werden
class OutlinedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  const OutlinedTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
        isDense: true,
      ),
    );
  }
}
