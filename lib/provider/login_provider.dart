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

  Future<bool> login(String email, String password) async {
    print("Intentando login con: $email");
    final dio = DioClient.getDio();

    try {
      final response = await dio.post('auth/login', data: {
        'email': email, 
        'password': password,
      });
      print("Respuesta del servidor: ${response.statusCode}");
      print("Tipo de response.data: ${response.data.runtimeType}");
      print("Contenido de response.data: ${response.data}");

      if (response.statusCode == 200) {
        String token = response.data; // El servidor retorna el token como String directo
        
        print("Token recibido: ${token.length > 20 ? token.substring(0, 20) : token}...");

        _email = email;
        _isLoggedIn = true;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token);
        await prefs.setString("email", email);
        await prefs.setBool("isLoggedIn", true);

        print("Token guardado en SharedPreferences");
        notifyListeners();
        return true;
      }
      return false;

    } on DioException catch (e) {
      print("Error en login: ${e.response?.statusCode} - ${e.response?.data}");
      return false;
    } catch (e) {
      print("Error detectado: $e");
      return false;
    }
  }

  // REGISTRO
  Future<bool> register(String email, String password) async {
    final dio = DioClient.getDio();
  
    try {
      final response = await dio.post('auth/register', data: {
        'UserName': email,
        'Password': password,
        'Rol': 'Admin',
      });
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Registro exitoso");
        return true;
      }
      return false;
    } on DioException catch (e) {
      print("Error en registro: ${e.response?.statusCode} - ${e.response?.data}");
      return false;
    } catch (e) {
      print("Error en registro: $e");
      return false;
    }
  }


  // CERRAR SESIÓN  
  Future<void> logout () async {
    _email = "";
    _isLoggedIn = false; 

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("email");
    await prefs.remove("isLoggedIn");
    await prefs.remove("token");
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

