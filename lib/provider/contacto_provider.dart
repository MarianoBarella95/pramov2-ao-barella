import 'package:flutter/material.dart';
import 'package:pramov2_ao1_barella/model/contacto.dart';

class ContactoProvider extends ChangeNotifier {
  final List<Contacto> _contactos = []; // Lista privada de contactos
  List<Contacto> get contactos => _contactos; // Getter para acceder a la lista de contactos

  void agregarContacto(Contacto contacto) {
    _contactos.add(contacto); // Add es un método propio de la clase List en Dart
    notifyListeners();
  }

  List<Contacto> buscarContactos(String query) {
    if (query.isEmpty) return _contactos;
    return _contactos
        .where((c) => c.nombre.toLowerCase().contains(query.toLowerCase())) // c es un contacto temporal
        .toList();
  }

  void eliminarContacto(Contacto contacto) {
    _contactos.remove(contacto); // Remove es un método propio de la clase List en Dart
    notifyListeners();
  }

  void actualizarContacto(Contacto contacto) {

  /* c ES EL CONTACTO QUE EXISTE EN LA LISTA, contacto es el nuevo que pasamos por parámetro. */   

  int index = _contactos.indexWhere((c) => c.id == contacto.id); 
  if (index != -1) {
    _contactos[index] = contacto;
    notifyListeners();
  }
}

}
