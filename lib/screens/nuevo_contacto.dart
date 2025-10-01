import 'package:flutter/material.dart';
import 'package:pramov2_ao1_barella/model/contacto.dart';
import 'package:provider/provider.dart';
import 'package:pramov2_ao1_barella/provider/contacto_provider.dart';

class NuevoContacto extends StatefulWidget {
  const NuevoContacto({super.key});

  @override
  State<NuevoContacto> createState() => _NuevoContactoState();
}

class _NuevoContactoState extends State<NuevoContacto> {
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _domicilioController = TextEditingController();
  final _generoController = TextEditingController();

  void _guardarContacto() {
    final nuevoContacto = Contacto(
      nombre: _nombreController.text,
      apellido: _apellidoController.text,
      telefono: _telefonoController.text,
      domicilio: _domicilioController.text,
      genero: _generoController.text,
    );

  Provider.of<ContactoProvider>(context, listen: false)
        .agregarContacto(nuevoContacto);

    Navigator.pop(context, nuevoContacto);
  }

  String _generoSeleccionado = "Masculino"; // valor inicial


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Contacto"),
        actions: [
          IconButton(onPressed: () {
            _guardarContacto();
          }, icon: Icon(Icons.check, size: 30)),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text("Nombre", style: TextStyle(fontSize: 20)),
                ),
              ),
              TextField(
                controller: _apellidoController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text("Apellido", style: TextStyle(fontSize: 20)),
                ),
              ),
              TextField(
                controller: _telefonoController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text(
                    "Número de Teléfono",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              TextField(
                controller: _domicilioController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  label: Text("Domicilio", style: TextStyle(fontSize: 20)),
                ),
              ),
              RadioListTile<String>(
        title: Text("Masculino"),
        value: "Masculino",
        groupValue: _generoSeleccionado,
        onChanged: (value) {
          setState(() {
            _generoSeleccionado = value!;
          });
        },
      ),
      RadioListTile<String>(
        title: Text("Femenino"),
        value: "Femenino",
        groupValue: _generoSeleccionado,
        onChanged: (value) {
          setState(() {
            _generoSeleccionado = value!;
          });
        },
      ),
            ],
          ),
        ),
      ),
    );
  }
}
