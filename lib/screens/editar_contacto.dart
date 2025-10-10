import 'package:flutter/material.dart';
import 'package:pramov2_ao1_barella/model/contacto.dart';
import 'package:pramov2_ao1_barella/provider/contacto_provider.dart';
import 'package:provider/provider.dart';

class EditarContacto extends StatefulWidget {
  final Contacto contacto;
  const EditarContacto({super.key, required this.contacto});

  @override
  State<EditarContacto> createState() => _EditarContactoState();
}

class _EditarContactoState extends State<EditarContacto> {
  late TextEditingController nombreController;
  late TextEditingController apellidoController;
  late TextEditingController telefonoController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.contacto.nombre);
    apellidoController = TextEditingController(text: widget.contacto.apellido);
    telefonoController = TextEditingController(text: widget.contacto.telefono);
  }

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactosProvider = context.read<ContactoProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Editar Contacto")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/edit-info.png", height: 150, width: 150),
            SizedBox(height: 20),
            TextField(controller: nombreController, decoration: InputDecoration(labelText: "Nombre")),
            TextField(controller: apellidoController, decoration: InputDecoration(labelText: "Apellido")),
            TextField(controller: telefonoController, decoration: InputDecoration(labelText: "Teléfono")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.contacto.nombre = nombreController.text;
                widget.contacto.apellido = apellidoController.text;
                widget.contacto.telefono = telefonoController.text;
                contactosProvider.actualizarContacto(widget.contacto);
                Navigator.pop(context);
              },
              child: Text("GUARDAR", style: TextStyle(fontSize: 20)),
            ),
            ],
          ),
        ),
      ),
    );
  }
  }
