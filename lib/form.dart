import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_data.dart';
import 'resume.dart';

class ResumeForm extends StatefulWidget {
  @override
  _ResumeFormState createState() => _ResumeFormState();
}

class _ResumeFormState extends State<ResumeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  void _submitForm(AppData appData) async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );
      String correctedContact = await appData.sendToOllama(
          'Dades de contacte', _contactController.text);
      print("contact ready");
      String correctedSummary =
          await appData.sendToOllama('Resum', _summaryController.text);
      print("summary ready");
      String correctedExperience = await appData.sendToOllama(
          'Experiència laboral', _experienceController.text);
      print("experience ready");
      String correctedEducation =
          await appData.sendToOllama('Formació', _educationController.text);
      print("formacio ready");
      String correctedSkills =
          await appData.sendToOllama('Aptituds', _skillsController.text);
      print("aptituds ready");

      Navigator.of(context).pop(); // Close the loading dialog

      // String correctedContact = _contactController.text;
      // String correctedSummary = _summaryController.text;
      // String correctedExperience = _experienceController.text;
      // String correctedEducation = _educationController.text;
      // String correctedSkills = _skillsController.text;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResumeDisplay(
            name: _nameController.text,
            contact: correctedContact,
            summary: correctedSummary,
            experience: correctedExperience,
            education: correctedEducation,
            skills: correctedSkills,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.withOpacity(0.1),
        title: const Text('Crear Currículum'),
        actions: [
          ElevatedButton(
            onPressed: () => (
              _nameController.text = 'Joan Pérez García',
              _contactController.text =
                  "Em podeu contactar al telèfon 612 345 678 o per correu electrònic a joan.perez@email.com.",
              _summaryController.text =
                  "Sóc un professional polivalent amb experiència en la gestió d’equips i l’atenció al client. M’apassiona l’organització i la resolució de problemes, i sempre busco maneres d’optimitzar processos i millorar l’eficiència. Tinc una gran capacitat d’adaptació i aprenc ràpidament, fet que em permet afrontar nous reptes amb confiança i iniciativa.",
              _experienceController.text =
                  "Actualment treballo com a Supervisor d’Operacions a l’empresa XYZ, on lidero un equip de deu persones. La meva tasca principal és coordinar i millorar els processos interns per garantir un servei eficient i de qualitat. També gestiono incidències i atenc els clients per assegurar la seva satisfacció.",
              _educationController.text =
                  "Vaig graduar-me en Administració i Direcció d’Empreses per la Universitat de Barcelona l’any 2018. Amb la voluntat de millorar les meves competències, el 2020 vaig completar un curs especialitzat en Atenció al Client i Comunicació Eficaç, que em va permetre aprofundir en estratègies per oferir un servei excel·lent i gestionar situacions complexes amb professionalitat.",
              _skillsController.text =
                  "Em considero una persona amb una gran capacitat per treballar en equip i resoldre conflictes de manera eficient. Sóc adaptable i aprenc ràpidament, cosa que em permet encaixar fàcilment en nous entorns. A més, tinc un domini sòlid d’eines ofimàtiques, la qual cosa em facilita l’organització i la gestió de tasques diàries."
            ),
            child: const Text('Rellenar'),
          ),
          const Padding(padding: EdgeInsets.only(left: 20)),
          ElevatedButton(
            onPressed: () => _submitForm(appData),
            child: const Text('Generar Currículum'),
          ),
          const Padding(padding: EdgeInsets.only(left: 20))
        ],
      ),
      body: Container(
        color: Colors.lightBlue
            .withOpacity(0.1), // Set background color to light pink
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                maxLines: 1,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _contactController,
                maxLines: 3,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: const InputDecoration(
                  labelText: 'Dades de contacte',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _summaryController,
                maxLines: 3,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: const InputDecoration(
                  labelText: 'Resum',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _experienceController,
                maxLines: 3,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: const InputDecoration(
                  labelText: 'Experiència laboral',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _educationController,
                maxLines: 3,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: const InputDecoration(
                  labelText: 'Formació',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _skillsController,
                maxLines: 3,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: const InputDecoration(
                  labelText: 'Aptituds',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
