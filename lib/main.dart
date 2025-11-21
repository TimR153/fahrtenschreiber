import 'package:fahrtenschreiber/viewmodels/auth_viewmodel.dart';
import 'package:fahrtenschreiber/views/fahrten_page.dart';
import 'package:fahrtenschreiber/views/home_page.dart';
import 'package:fahrtenschreiber/views/login_page.dart';
import 'package:fahrtenschreiber/views/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return MaterialApp(
      title: 'Fahrtenbuch App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
        stream: authViewModel.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const MainNavigation()
      },
    );
  }
}
