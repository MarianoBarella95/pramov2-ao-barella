import 'package:flutter/material.dart';
import 'package:pramov2_ao1_barella/model/contacto.dart';

class ContactoProvider extends ChangeNotifier {
  final List<Contacto> _contactos = [];
  List<Contacto> get contactos => _contactos;
  void agregarContacto(Contacto contacto) {
    _contactos.add(contacto);
    notifyListeners();
  }

  List<Contacto> buscarContactos(String query) {
    if (query.isEmpty) return _contactos;
    return _contactos
        .where((c) => c.nombre.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void eliminarContacto(Contacto contacto) {
    _contactos.remove(contacto);
    notifyListeners();
  }

  void actualizarContacto(Contacto contacto) {
  int index = _contactos.indexWhere((c) => c.id == contacto.id);
  if (index != -1) {
    _contactos[index] = contacto;
    notifyListeners();
  }
}

}
