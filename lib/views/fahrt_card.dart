import 'package:flutter/material.dart';

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
            // Datum und Kategorie
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
            // Start und (optional) Ziel
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
            // Distanz und Dauer (optional)
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
              ),
            ],
          ],
        ),
      ),
    );
  }
}
