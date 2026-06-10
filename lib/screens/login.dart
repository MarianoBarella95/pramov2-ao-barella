import 'package:flutter/material.dart';
import 'package:pramov2_ao1_barella/screens/contactos.dart';
import 'package:pramov2_ao1_barella/provider/contacto_provider.dart';
import 'package:pramov2_ao1_barella/provider/login_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoginMode = true; // true = login, false = registro

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/notebook.png", height: 150, width: 150),
                SizedBox(height: 20),
                Text(
                  "AGENDA FLUTTER",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  _isLoginMode ? "Iniciar Sesión" : "Crear Cuenta",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Email", style: TextStyle(fontSize: 20)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Contraseña", style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_emailController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      mostrarMensaje(context, "Debe completar todos los campos", Colors.red, 2);
                      return;
                    }

                    // Capturar referencias antes de operaciones asincrónicas
                    final currentContext = context;
                    final contactoProvider = context.read<ContactoProvider>();

                    if (_isLoginMode) {
                      // Modo LOGIN
                      final success = await loginProvider.login(
                        _emailController.text,
                        _passwordController.text,
                      );

                      if (success && mounted) {
                        // Cargar contactos después del login
                        await contactoProvider.cargarContactos();

                        if (mounted) {
                          Navigator.pushReplacement(currentContext, MaterialPageRoute(builder: (context) => Contactos()));
                        }
                      } else if (!success && mounted) {
                        mostrarMensaje(currentContext, "Email o contraseña incorrectos", Colors.red, 2);
                      }
                    } else {
                      // Modo REGISTRO
                      final success = await loginProvider.register(
                        _emailController.text,
                        _passwordController.text,
                      );

                      if (success && mounted) {
                        mostrarMensaje(currentContext, "Registro exitoso. Inicia sesión con tus credenciales.", Colors.green, 2);
                        setState(() {
                          _isLoginMode = true;
                          _emailController.clear();
                          _passwordController.clear();
                        });
                      } else if (!success && mounted) {
                        mostrarMensaje(currentContext, "Error en el registro. Intenta con otro email o contraseña.", Colors.red, 2);
                      }
                    }
                  },
                  child: Text(
                    _isLoginMode ? "INICIAR SESIÓN" : "CREAR CUENTA",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLoginMode = !_isLoginMode;
                      _emailController.clear();
                      _passwordController.clear();
                    });
                  },
                  child: Text(
                    _isLoginMode
                        ? "¿No tienes cuenta? Regístrate"
                        : "¿Ya tienes cuenta? Inicia sesión",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void mostrarMensaje(
    BuildContext context,
    String mensaje,
    Color color,
    int duracionSegundos,
  ) {
    final snackBar = SnackBar(
      content: Text(mensaje),
      backgroundColor: color,
      duration: Duration(seconds: duracionSegundos),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
