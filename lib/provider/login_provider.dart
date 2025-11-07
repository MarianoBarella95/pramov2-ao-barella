import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    if(email == "marianobarella1@gmail.com" && password == "1905") {
      _email = email;
      _isLoggedIn = true;


      // CREA EL SHAREDPREFERENCES Y GUARDA LOS DATOS
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", email);
      await prefs.setBool("isLoggedIn", true);
      notifyListeners();
    } else {
      throw Exception("Credenciales incorrectas");
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
    notifyListeners();
    
    }

}

