import 'package:flutter/material.dart';
import 'package:pramov2_ao1_barella/provider/login_provider.dart';
import 'package:pramov2_ao1_barella/screens/editar_contacto.dart';
import 'package:pramov2_ao1_barella/screens/nuevo_contacto.dart';
import 'package:provider/provider.dart';
import 'package:pramov2_ao1_barella/provider/contacto_provider.dart';

class Contactos extends StatefulWidget {
  const Contactos({super.key});

  @override
  State<Contactos> createState() => _ContactosState();
}

class _ContactosState extends State<Contactos> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final contactosProvider = context.watch<ContactoProvider>();
    final loginProvider = context.watch<LoginProvider>();

    // Filtrar contactos según la query
    final contactosFiltrados = query.isEmpty
        ? contactosProvider.contactos
        : contactosProvider.contactos.where((c) {
            final nombreCompleto =
                "${c.nombre.toLowerCase()} ${c.apellido.toLowerCase()}";
            return nombreCompleto.contains(query.toLowerCase());
          }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Contactos"),
        actions: [
          IconButton(
            onPressed: () {
              showSearchDialog(context);
            },
            icon: Icon(Icons.search, size: 30),
          ),
          IconButton(onPressed: () async {

            await context.read<LoginProvider>().logout();



          }, icon: Icon(Icons.logout, size: 30, color: Colors.red)),
        ],
      ),
      body: contactosFiltrados.isEmpty
          ? Center(
              child: SizedBox(
                height: 400,
                width: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/sad.png",
                        height: 150,
                        width: 150,
                      ),
                      Text(
                        "No hay contactos".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : ListView.builder(
              itemCount: contactosFiltrados.length,
              itemBuilder: (context, index) {
                final contacto = contactosFiltrados[index];
                return ListTile(
                  leading: Icon(Icons.person_3_sharp, size: 40),
                  title: Text(
                    "${contacto.nombre.toUpperCase()} ${contacto.apellido.toUpperCase()}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(contacto.telefono, style: TextStyle(fontSize: 15)),
                  tileColor: Colors.grey[300],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditarContacto(contacto: contacto),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      size: 40,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      contactosProvider.eliminarContacto(contacto);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NuevoContacto()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Buscar contacto'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Ingrese un nombre'),
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  query = '';
                });
                Navigator.pop(context);
              },
              child: const Text('Limpiar'),
            ),
          ],
        );
      },
    );
  }
}
