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
  int id = 0;

  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _domicilioController = TextEditingController();

  void _guardarContacto() async {
    if (_nombreController.text.isEmpty ||
        _apellidoController.text.isEmpty ||
        _telefonoController.text.isEmpty ||
        _domicilioController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Debe completar todos los campos")),
      );
      return;
    }

    final nuevoContacto = Contacto(
      // id: id++,
      nombre: _nombreController.text,
      apellido: _apellidoController.text,
      telefono: _telefonoController.text,
      domicilio: _domicilioController.text,
      genero: _generoSeleccionado,
    );

    await Provider.of<ContactoProvider>(
      context,
      listen: false,
    ).agregarContacto(nuevoContacto);

    if (mounted) {
      Navigator.pop(context, nuevoContacto);
    }
  }

  String _generoSeleccionado = "Masculino";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Contacto"),
        actions: [
          IconButton(
            onPressed: () {
              _guardarContacto();
            },
            icon: Icon(Icons.check, size: 30),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/add-friend.png",
                height: 150,
                width: 150,
              ),
              SizedBox(height: 30),
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

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _telefonoController.dispose();
    _domicilioController.dispose();
    super.dispose();
  }
}
