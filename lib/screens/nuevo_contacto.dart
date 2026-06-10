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
  final _emailController = TextEditingController();
  final _fechaController = TextEditingController();
  // Focus nodes and keys to ensure fields scroll into view when focused
  final _nombreFocus = FocusNode();
  final _apellidoFocus = FocusNode();
  final _telefonoFocus = FocusNode();
  final _domicilioFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _fechaFocus = FocusNode();

  final _nombreKey = GlobalKey();
  final _apellidoKey = GlobalKey();
  final _telefonoKey = GlobalKey();
  final _domicilioKey = GlobalKey();
  final _emailKey = GlobalKey();
  final _fechaKey = GlobalKey();

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
      email: _emailController.text.isEmpty ? null : _emailController.text,
      fechaNacimiento: _fechaController.text.isEmpty ? null : _fechaController.text,
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
  void initState() {
    super.initState();

    void attach(FocusNode node, GlobalKey key) {
      node.addListener(() {
        if (node.hasFocus) {
          final ctx = key.currentContext;
          if (ctx != null) {
            Scrollable.ensureVisible(ctx, duration: Duration(milliseconds: 250));
          }
        }
      });
    }

    attach(_nombreFocus, _nombreKey);
    attach(_apellidoFocus, _apellidoKey);
    attach(_telefonoFocus, _telefonoKey);
    attach(_domicilioFocus, _domicilioKey);
    attach(_emailFocus, _emailKey);
    attach(_fechaFocus, _fechaKey);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: bottomInset + 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: SizedBox(
                    height: constraints.maxHeight,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                  Image.asset(
                    "assets/images/add-friend.png",
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(height: 30),
                  Container(key: _nombreKey, child: TextField(
                    focusNode: _nombreFocus,
                    controller: _nombreController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      label: Text("Nombre", style: TextStyle(fontSize: 20)),
                    ),
                  )),
                  TextField(
                    controller: _apellidoController,
                    focusNode: _apellidoFocus,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      label: Text("Apellido", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  TextField(
                    controller: _telefonoController,
                    focusNode: _telefonoFocus,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      label: Text(
                        "Número de Teléfono",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(key: _domicilioKey, child: TextField(
                    focusNode: _domicilioFocus,
                    controller: _domicilioController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      label: Text("Domicilio", style: TextStyle(fontSize: 20)),
                    ),
                  )),
                  Container(key: _emailKey, child: TextField(
                    focusNode: _emailFocus,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      label: Text("Email", style: TextStyle(fontSize: 20)),
                    ),
                  )),
                  Container(key: _fechaKey, child: TextField(
                    focusNode: _fechaFocus,
                    controller: _fechaController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      label: Text("Fecha de Nacimiento", style: TextStyle(fontSize: 20)),
                    ),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        _fechaController.text = picked.toIso8601String().split('T').first;
                      }
                    },
                  )),
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
            },
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
    _emailController.dispose();
    _fechaController.dispose();
    _nombreFocus.dispose();
    _apellidoFocus.dispose();
    _telefonoFocus.dispose();
    _domicilioFocus.dispose();
    _emailFocus.dispose();
    _fechaFocus.dispose();
    super.dispose();
  }
}
