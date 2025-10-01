import 'package:flutter/material.dart';
import 'package:pramov2_ao1_barella/model/contacto.dart';

class ContactoProvider extends ChangeNotifier{
  final List<Contacto> _contactos = [];
List<Contacto> get contactos => _contactos;
  void agregarContacto(Contacto contacto){
    _contactos.add(contacto);
    notifyListeners();
  }

  void eliminarContacto(Contacto contacto){
    _contactos.remove(contacto);
    notifyListeners();
  }
}