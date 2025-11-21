import 'package:fahrtenschreiber/views/dialogs/fahrt_hinzufuegen_dialog.dart';
import 'package:flutter/material.dart';

class Fahrt {
  final String datum;
  final String kategorie;
  final String start;
  final String? ziel;
  final String? distanz;
  final String? dauer;

  Fahrt({
    required this.datum,
    required this.kategorie,
    required this.start,
    this.ziel,
    this.distanz,
    this.dauer,
  });
}

class FahrtenPage extends StatelessWidget {
  const FahrtenPage({super.key});

  List<Fahrt> get _fahrten => [
        Fahrt(
          datum: "Heute, 08:30 Uhr",
          kategorie: "Geschäftlich",
          start: "Berlin, Hauptbahnhof",
          ziel: "Potsdam, Brandenburger Str.",
          distanz: "28 km",
          dauer: "45 min",
        ),
        Fahrt(
          datum: "Gestern, 17:15 Uhr",
          kategorie: "Privat",
          start: "Hamburg, HafenCity",
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fahrten'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: _fahrten.isEmpty
            ? Center(
                child: Text(
                  'Noch keine Fahrten vorhanden.',
                  style: theme.textTheme.bodyLarge,
                ),
              )
            : ListView.separated(
                itemCount: _fahrten.length,
                itemBuilder: (context, index) {
                  final fahrt = _fahrten[index];
                  return FahrtCard(
                    label: fahrt.datum,
                    kategorie: fahrt.kategorie,
                    start: fahrt.start,
                    ziel: fahrt.ziel,
                    distanz: fahrt.distanz,
                    dauer: fahrt.dauer,
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 12),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const FahrtHinzufuegenDialog(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Fahrt hinzufügen'),
      ),
    );
  }
}

// FahrtCard wie bisher definiert (du kannst sie zentral auslagern):
class FahrtCard extends StatelessWidget {
  final String label, kategorie, start;
  final String? ziel, distanz, dauer;

  const FahrtCard({
    super.key,
    required this.label,
    required this.kategorie,
    required this.start,
    this.ziel,
    this.distanz,
    this.dauer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Erste Zeile
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    label,
                    style: theme.textTheme.labelMedium,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: kategorie == "Geschäftlich"
                        ? Colors.green[100]
                        : Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    kategorie,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: kategorie == "Geschäftlich"
                          ? Colors.green[800]
                          : Colors.blue[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Start/Ziel
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(start, style: theme.textTheme.bodyLarge),
                if (ziel != null) ...[
                  Icon(Icons.more_vert, size: 20, color: theme.hintColor),
                  Text(ziel!, style: theme.textTheme.bodyLarge),
                ],
              ],
            ),
            if (distanz != null || dauer != null) ...[
              const Divider(height: 18),
              Row(
                children: [
                  if (distanz != null) ...[
                    const Icon(Icons.social_distance, size: 20),
                    const SizedBox(width: 5),
                    Text(distanz!, style: theme.textTheme.bodyMedium),
                    const SizedBox(width: 18),
                  ],
                  if (dauer != null) ...[
                    const Icon(Icons.access_time, size: 20),
                    const SizedBox(width: 5),
                    Text(dauer!, style: theme.textTheme.bodyMedium),
                  ],
                ],
              )
            ],
          ],
        ),
      ),
    );
  }
}
