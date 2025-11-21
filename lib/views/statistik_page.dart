import 'package:flutter/material.dart';

class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Beispielwerte, später ersetzen durch echte Auswertung!
    final totaleKm = 1240;
    final monatZeit = '14h 20m';
    final geschaeftlich = 67; // Prozent
    final privat = 33;
    final rekordDistanz = 330; // km
    final rekordFahrtTitel = 'Berlin – München';

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistik',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),
            // Monatsübersicht
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.speed, size: 28, color: theme.colorScheme.primary),
                          const SizedBox(height: 10),
                          Text('$totaleKm',
                              style: theme.textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          Text('Kilometer diesen Monat', style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.access_time, size: 28, color: theme.colorScheme.primary),
                          const SizedBox(height: 10),
                          Text(monatZeit,
                              style: theme.textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          Text('Fahrzeit diesen Monat', style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Anteil geschäftlich/privat
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.pie_chart, color: theme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Text('Verteilung', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text('$geschaeftlich%',
                                  style: theme.textTheme.headlineSmall?.copyWith(
                                    color: Colors.green[800],
                                    fontWeight: FontWeight.bold
                                  )),
                              const SizedBox(height: 4),
                              Text('Geschäftlich', style: theme.textTheme.bodySmall),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text('$privat%',
                                  style: theme.textTheme.headlineSmall?.copyWith(
                                    color: Colors.blue[800],
                                    fontWeight: FontWeight.bold
                                  )),
                              const SizedBox(height: 4),
                              Text('Privat', style: theme.textTheme.bodySmall),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Rekordfahrt
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.emoji_events, color: theme.colorScheme.primary, size: 36),
                    const SizedBox(width: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Längste Fahrt',
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(
                          rekordFahrtTitel,
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 4),
                        Text('$rekordDistanz km', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Platz für weitere Auswertungen, Charts, Kalender etc.
          ],
        ),
      ),
    );
  }
}
