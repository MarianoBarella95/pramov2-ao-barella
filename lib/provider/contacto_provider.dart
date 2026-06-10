import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
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
    // No cargar contactos aquí, el token aún no está disponible
    // Se cargará después del login en screens/login.dart
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
      final response = await dio.post('Contactos', data: {
        'nombre': contacto.nombre,
        'apellido': contacto.apellido,
        'telefono': contacto.telefono,
        'domicilio': contacto.domicilio,
        'genero': contacto.genero,
        'email': contacto.email,
        'fechaNacimiento': contacto.fechaNacimiento,
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        await cargarContactos();
      } else {
        print('POST Contactos falló: ${response.statusCode} ${response.data}');
      }
    } on DioException catch (e) {
      print('Error agregando el contacto: ${e.response?.statusCode}');
      print('Response data: ${e.response?.data}');
      print('Request path: ${e.requestOptions.uri}');
      print('Request headers: ${e.requestOptions.headers}');
      print('Request data: ${e.requestOptions.data}');
    } catch (e) {
      print('Error agregando el contacto: $e');
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
      await dio.delete('Contactos/${contacto.id}');
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
    final dio = DioClient.getDio();
    try {
      // if (contacto.id == null) {
      //   return;
      // }

      final response = await dio.put(
        'Contactos/${contacto.id}',
        data: contacto.toMap(),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        await cargarContactos();
        notifyListeners();
      }
    } catch (e) {
      print("Error actualizando el contacto: $e");
    }
    // await DbHelper.actualizarContacto(contacto);
    
    // final index = _contactos.indexWhere((c) => c.id  == contacto.id);
  
    // if(index != -1) {
    //   _contactos[index] = contacto;
      
    // }

  
  }

}
