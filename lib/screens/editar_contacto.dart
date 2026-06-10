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
  late TextEditingController emailController;
  late TextEditingController fechaController;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.contacto.nombre);
    apellidoController = TextEditingController(text: widget.contacto.apellido);
    telefonoController = TextEditingController(text: widget.contacto.telefono);
    emailController = TextEditingController(text: widget.contacto.email ?? '');
    fechaController = TextEditingController(text: widget.contacto.fechaNacimiento ?? '');
  }

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    telefonoController.dispose();
    emailController.dispose();
    fechaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactosProvider = context.read<ContactoProvider>();
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
        appBar: AppBar(title: Text("Editar Contacto")),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: bottomInset + 16),
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
                      Image.asset("assets/images/edit-info.png", height: 150, width: 150),
                      SizedBox(height: 20),
                      TextField(controller: nombreController, decoration: InputDecoration(labelText: "Nombre")),
                      TextField(controller: apellidoController, decoration: InputDecoration(labelText: "Apellido")),
                      TextField(controller: telefonoController, decoration: InputDecoration(labelText: "Teléfono")),
                      TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
                      TextField(
                        controller: fechaController,
                        readOnly: true,
                        decoration: InputDecoration(labelText: "Fecha de Nacimiento"),
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: widget.contacto.fechaNacimiento != null && widget.contacto.fechaNacimiento!.isNotEmpty
                                ? DateTime.parse(widget.contacto.fechaNacimiento!)
                                : DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            fechaController.text = picked.toIso8601String().split('T').first;
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          widget.contacto.nombre = nombreController.text;
                          widget.contacto.apellido = apellidoController.text;
                          widget.contacto.telefono = telefonoController.text;
                          widget.contacto.email = emailController.text;
                          widget.contacto.fechaNacimiento = fechaController.text;
                          await contactosProvider.actualizarContacto(widget.contacto);
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        },
                        child: Text("GUARDAR", style: TextStyle(fontSize: 20)),
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
  }
