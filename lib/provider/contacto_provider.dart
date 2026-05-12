import 'package:flutter/material.dart';
import 'package:pramov2_ao1_barella/database/db_helper.dart';
import 'package:pramov2_ao1_barella/model/contacto.dart';
import 'package:pramov2_ao1_barella/services/dio_client.dart';

class ContactoProvider extends ChangeNotifier {
  List<Contacto> _contactos = []; // Lista privada de contactos
  List<Contacto> get contactos => _contactos; // Getter para acceder a la lista de contactos

  // void agregarContacto(Contacto contacto) {
  //   _contactos.add(contacto); // Add es un método propio de la clase List en Dart
  //   notifyListeners();
  // }

  ContactoProvider() {
    cargarContactos();
  }

  Future<void> cargarContactos() async {
    final dio = DioClient.getDio();

    try {
      final response = await dio.get('Contactos');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        _contactos = data.map((json) => Contacto.fromJson(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      print("Error cargando los contactos: $e");
    }


    // _contactos = await DbHelper.obtenerContactos();
    // notifyListeners();
  }

  Future<void> agregarContacto(Contacto contacto) async {
    final dio = DioClient.getDio();
    try {
      final response = await dio.post('/minimal/contactos', data: contacto.toMap());
      if (response.statusCode == 200 || response.statusCode == 201) {
        await cargarContactos();
      }
    } catch (e) {
      print("Error cargando los contactos: $e");
    }
    
    // final newId = await DbHelper.insertarContacto(contacto);
    // final contactoGuardado = contacto.copyWith(id: newId);
    // _contactos.add(contactoGuardado);
    // notifyListeners();
  }

  List<Contacto> buscarContactos(String query) {
    if (query.isEmpty) return _contactos;
    return _contactos
        .where((c) => c.nombre.toLowerCase().contains(query.toLowerCase())) // c es un contacto temporal
        .toList();
  }

  // void eliminarContacto(Contacto contacto) {
  //   _contactos.remove(contacto); // Remove es un método propio de la clase List en Dart
  //   notifyListeners();
  // }

  Future<void> eliminarContacto(Contacto contacto) async {
    final dio = DioClient.getDio();
    try {
      await dio.delete('/api/Contactos/${contacto.id}');
      _contactos.removeWhere((c) => c.id == contacto.id);
      notifyListeners();
    } catch (e) {
      print("Error cargando los contactos: $e");
    }


    // if(contacto.id == null) {
    //   _contactos.remove(contacto);
    //   notifyListeners();
    //   return;
    // }

    // await DbHelper.eliminarContacto(contacto.id!);
    // _contactos.removeWhere((c) => c.id == contacto.id);
    // notifyListeners();
  }


//   void actualizarContacto(Contacto contacto) {

//   /* c ES EL CONTACTO QUE EXISTE EN LA LISTA, contacto es el nuevo que pasamos por parámetro. */   

//   int index = _contactos.indexWhere((c) => c.id == contacto.id); 
//   if (index != -1) {
//     _contactos[index] = contacto;
//     notifyListeners();
//   }
// }

  Future<void> actualizarContacto(Contacto contacto) async {
    await DbHelper.actualizarContacto(contacto);
    
    final index = _contactos.indexWhere((c) => c.id  == contacto.id);
  
    if(index != -1) {
      _contactos[index] = contacto;
      
    }

    notifyListeners();
  
  
  }

}
