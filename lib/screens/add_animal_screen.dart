import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AddAnimalScreen extends StatefulWidget {
  const AddAnimalScreen({super.key});

  @override
  _AddAnimalScreenState createState() => _AddAnimalScreenState();
}

class _AddAnimalScreenState extends State<AddAnimalScreen> {
  final _nameController = TextEditingController();
  final _speciesController = TextEditingController();
  final _ageController = TextEditingController();
  final _latController = TextEditingController();
  final _lonController = TextEditingController();

  Future<void> _addAnimal() async {
    final response = await http.post(
      Uri.parse('http://192.168.217.72/api/animals/'),  // Remplacez par l'URL de votre serveur Django
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': _nameController.text,
        'species': _speciesController.text,
        'age': int.parse(_ageController.text),
        'location_lat': double.parse(_latController.text),
        'location_lon': double.parse(_lonController.text),
      }),
    );

    if (response.statusCode == 201) {
      // Animal ajouté avec succès
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Animal ajouté avec succès')));
    } else {
      // Erreur
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Erreur lors de l\'ajout de l\'animal')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter un Animal")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nom de l\'animal'),
            ),
            TextField(
              controller: _speciesController,
              decoration: const InputDecoration(labelText: 'Espèce'),
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Âge'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _latController,
              decoration: const InputDecoration(labelText: 'Latitude'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: _lonController,
              decoration: const InputDecoration(labelText: 'Longitude'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addAnimal,
              child: const Text('Ajouter l\'Animal'),
            ),
          ],
        ),
      ),
    );
  }
}
