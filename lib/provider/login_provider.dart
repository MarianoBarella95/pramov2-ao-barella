import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:pramov2_ao1_barella/services/dio_client.dart';

class LoginProvider extends ChangeNotifier {


  // VARIABLES
  String _email = "";
  bool _isLoggedIn = false;


  // GETTERS  
  String get email => _email;
  bool get isLoggedIn => _isLoggedIn;

  // MÉTODOS

  LoginProvider() {
    _loadSession();
  }

  Future<void> login(String email, String password) async {
    print("Intentando login con: $email");
    final dio = DioClient.getDio();

    try {
      final response = await dio.post('/auth/login', data: {
        'email': email, 
        'password': password,
      });
      print("Respuesta del servidor: ${response.statusCode}");

      if (response.statusCode == 200) {
        String token = response.data is String ? response.data : response.data.toString();
        print("Token recibido: ${token.substring(0, 20)}...");

        _email = email;
        _isLoggedIn = true;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token);
        await prefs.setString("email", email);
        await prefs.setBool("isLoggedIn", true);

        print("Token guardado en SharedPreferences");
        notifyListeners();
      }

    } catch (e) {
      print("Error detectado: $e");
    }


    // if(email == "marianobarella1@gmail.com" && password == "1905") {
    //   _email = email;
    //   _isLoggedIn = true;


    //   // CREA EL SHAREDPREFERENCES Y GUARDA LOS DATOS
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   await prefs.setString("email", email);
    //   await prefs.setBool("isLoggedIn", true);
    //   notifyListeners();
    // } else {
    //   throw Exception("Credenciales incorrectas");
    // }

  }

  // REGISTRO
  Future <void> register (String email, String password, String nombre) async {
    final dio = DioClient.getDio();
  
    try {
      await dio.post('auth/register', data: {
        'UserName': email,
        'Password': password, 
        // 'Email': email,
      });
    } on DioException catch (e) {
      throw Exception("Error en el registro: ${e.response?.data}");
    }
  }


  // CERRAR SESIÓN  
  Future<void> logout () async {
    _email = "";
    _isLoggedIn = false; 

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("email");
    await prefs.remove("isLoggedIn");
    notifyListeners();
  }
  
  // CARGAR SESIÓN

  Future<void> _loadSession() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('email') ?? '';
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? token = prefs.getString('token');
    notifyListeners();
    
    }

}

