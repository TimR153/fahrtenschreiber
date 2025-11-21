import 'package:flutter/material.dart';
import 'fahrt_card.dart';
import 'dialogs/fahrt_hinzufuegen_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header/Profile
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: theme.colorScheme.secondaryContainer,
                      child: Text('img',
                        style: TextStyle(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fahrtenschreiber',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 2),
                        Text('Guten Morgen, Max',
                            style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Blaue Card
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Manuell erfassen',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Fahrt hinzufügen',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Gib Start- und Zieladresse oder nur den Kilometerstand an.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 26),
                  FilledButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const FahrtHinzufuegenDialog(),
                      );
                    },
                    icon: const Icon(Icons.add, color: Colors.blue),
                    label: Text(
                      'Fahrt hinzufügen',
                      style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.onPrimary,
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            // Statistik
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.timeline,
                              color: theme.colorScheme.primary, size: 24),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Text('1.240',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.green[50],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '+12%',
                                  style: theme.textTheme.labelMedium
                                      ?.copyWith(color: Colors.green[800]),
                                ),
                              ),
                            ],
                          ),
                          Text('Kilometer diesen Monat',
                              style: theme.textTheme.labelMedium),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.access_time_filled_rounded,
                              color: theme.colorScheme.primary, size: 24),
                          const SizedBox(height: 10),
                          Text('14h 20m',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              )),
                          Text('Fahrzeit diesen Monat',
                              style: theme.textTheme.labelMedium),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Letzte Fahrten Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Letzte Fahrten",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Alle ansehen Funktion
                  },
                  child: const Text('Alle ansehen'),
                ),
              ],
            ),
            // Fahrtliste Beispiel
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                FahrtCard(
                  label: "Heute, 08:30 Uhr",
                  kategorie: "Geschäftlich",
                  start: "Berlin, Hauptbahnhof",
                  ziel: "Potsdam, Brandenburger Str.",
                  distanz: "28 km",
                  dauer: "45 min",
                ),
                const SizedBox(height: 12),
                FahrtCard(
                  label: "Gestern, 17:15 Uhr",
                  kategorie: "Privat",
                  start: "Hamburg, HafenCity",
                  ziel: null,
                  distanz: null,
                  dauer: null,
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
