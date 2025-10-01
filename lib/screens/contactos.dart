import 'package:flutter/material.dart';
import 'package:pramov2_ao1_barella/screens/nuevo_contacto.dart';
import 'package:provider/provider.dart';
import 'package:pramov2_ao1_barella/provider/contacto_provider.dart';

class Contactos extends StatefulWidget {
  const Contactos({super.key});

  @override
  State<Contactos> createState() => _ContactosState();
}

class _ContactosState extends State<Contactos> {
  @override
  Widget build(BuildContext context) {
    final contactosProvider = context.watch<ContactoProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Contactos"),
        actions: [
          //IconButton(onPressed: (){}, icon: Icon(Icons.add))
        ],
      ),
      body: contactosProvider.contactos.isEmpty
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
              itemCount: contactosProvider.contactos.length,
              itemBuilder: (context, index) {
                final contacto = contactosProvider.contactos[index];
                return ListTile(
                  leading: Icon(Icons.person_3_sharp, size: 40),
                  title: Text(
                    "${contacto.nombre.toUpperCase()} ${contacto.apellido.toUpperCase()}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(contacto.telefono, style: TextStyle(fontSize: 15)),
                  tileColor: Colors.grey[300],
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
}
