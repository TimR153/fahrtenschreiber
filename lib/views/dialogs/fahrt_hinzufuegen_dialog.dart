import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FahrtHinzufuegenDialog extends StatefulWidget {
  const FahrtHinzufuegenDialog({super.key});

  @override
  State<FahrtHinzufuegenDialog> createState() => _FahrtHinzufuegenDialogState();
}

class _FahrtHinzufuegenDialogState extends State<FahrtHinzufuegenDialog> {
  final _formKey = GlobalKey<FormState>();
  final _kmController = TextEditingController();

  final _startStrasseController = TextEditingController();
  final _startHausnummerController = TextEditingController();
  final _startPlzController = TextEditingController();
  final _startOrtController = TextEditingController();

  final _zielStrasseController = TextEditingController();
  final _zielHausnummerController = TextEditingController();
  final _zielPlzController = TextEditingController();
  final _zielOrtController = TextEditingController();

  @override
  void dispose() {
    _kmController.dispose();
    _startStrasseController.dispose();
    _startHausnummerController.dispose();
    _startPlzController.dispose();
    _startOrtController.dispose();
    _zielStrasseController.dispose();
    _zielHausnummerController.dispose();
    _zielPlzController.dispose();
    _zielOrtController.dispose();
    super.dispose();
  }

  String _composeAddress(
    TextEditingController str,
    TextEditingController nr,
    TextEditingController plz,
    TextEditingController ort
  ) {
    // Rückgabe als "Straße Hausnummer, PLZ Ort"
    List<String> parts = [];
    if (str.text.trim().isNotEmpty) {
      parts.add(str.text.trim());
    }
    if (nr.text.trim().isNotEmpty) {
      parts.add(nr.text.trim());
    }
    String address = parts.join(' ');
    List<String> loc = [];
    if (plz.text.trim().isNotEmpty) {
      loc.add(plz.text.trim());
    }
    if (ort.text.trim().isNotEmpty) {
      loc.add(ort.text.trim());
    }
    if (loc.isNotEmpty) {
      address = '$address, ${loc.join(' ')}';
    }
    return address;
  }

  Future<void> _openInMaps(String addr) async {
    final url = Uri.encodeFull('https://www.google.com/maps/search/?api=1&query=$addr');
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Karten-App kann nicht geöffnet werden.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Fahrt hinzufügen'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Kilometerstand
              TextFormField(
                controller: _kmController,
                decoration: const InputDecoration(labelText: 'Kilometerstand (optional)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              Text(
                'ODER',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: 16),
              // Startadresse Felder
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Startadresse', style: Theme.of(context).textTheme.labelMedium),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _startStrasseController,
                      decoration: const InputDecoration(labelText: 'Straße'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 70,
                    child: TextFormField(
                      controller: _startHausnummerController,
                      decoration: const InputDecoration(labelText: 'Nr.'),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: TextFormField(
                      controller: _startPlzController,
                      decoration: const InputDecoration(labelText: 'PLZ'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _startOrtController,
                      decoration: const InputDecoration(labelText: 'Ort'),
                    ),
                  ),
                  IconButton(
                    tooltip: "In Maps öffnen",
                    icon: const Icon(Icons.map),
                    onPressed: () {
                      final addr = _composeAddress(
                        _startStrasseController,
                        _startHausnummerController,
                        _startPlzController,
                        _startOrtController,
                      );
                      if (addr.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Bitte zuerst Adresse eingeben.')));
                        return;
                      }
                      _openInMaps(addr);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Zieladresse Felder
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Zieladresse', style: Theme.of(context).textTheme.labelMedium),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _zielStrasseController,
                      decoration: const InputDecoration(labelText: 'Straße'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 70,
                    child: TextFormField(
                      controller: _zielHausnummerController,
                      decoration: const InputDecoration(labelText: 'Nr.'),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: TextFormField(
                      controller: _zielPlzController,
                      decoration: const InputDecoration(labelText: 'PLZ'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _zielOrtController,
                      decoration: const InputDecoration(labelText: 'Ort'),
                    ),
                  ),
                  IconButton(
                    tooltip: "In Maps öffnen",
                    icon: const Icon(Icons.map),
                    onPressed: () {
                      final addr = _composeAddress(
                        _zielStrasseController,
                        _zielHausnummerController,
                        _zielPlzController,
                        _zielOrtController,
                      );
                      if (addr.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Bitte zuerst Adresse eingeben.')));
                        return;
                      }
                      _openInMaps(addr);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Abbrechen'),
        ),
        FilledButton(
          onPressed: () {
            // Mindestens ein Feld muss ausgefüllt sein!
            bool kmOk = _kmController.text.trim().isNotEmpty;
            bool startOk = _startStrasseController.text.trim().isNotEmpty &&
                _startOrtController.text.trim().isNotEmpty;
            bool zielOk = _zielStrasseController.text.trim().isNotEmpty &&
                _zielOrtController.text.trim().isNotEmpty;
            if (!kmOk && !(startOk && zielOk)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Bitte entweder KM-Stand ODER Start UND Ziel komplett angeben.')),
              );
              return;
            }
            // Daten speichern …
            Navigator.of(context).pop();
          },
          child: const Text('Speichern'),
        ),
      ],
    );
  }
}
