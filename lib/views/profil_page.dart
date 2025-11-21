import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Beispiel-Daten, in Praxis dynamisch (z.B. aus Provider/Firebase)!
    final userName = "Max Mustermann";
    final userEmail = "max@beispiel.de";

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            // Avatar
            CircleAvatar(
              radius: 48,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
              child: Text(
                userName.isNotEmpty ? userName[0] : "?",
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 22),
            // Username
            Text(
              userName,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            // E-Mail
            Text(
              userEmail,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
            ),
            const SizedBox(height: 32),
            // Optional: Einstellungen, Passwort ändern etc.
            Card(
              margin: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                leading: const Icon(Icons.lock_reset),
                title: const Text("Passwort ändern"),
                onTap: () {
                  // Aktion, z.B. Dialog zum PW ändern
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("App-Einstellungen"),
                onTap: () {
                  // Einstellungen öffnen
                },
              ),
            ),
            const SizedBox(height: 36),
            // Logout
            FilledButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text("Abmelden"),
              onPressed: () {
                // Dein Logout-Provider/Kommando
                // Beispiel: Provider.of<AuthViewModel>(context, listen: false).signOut();
              },
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
                minimumSize: const Size(180, 50),
                textStyle: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
