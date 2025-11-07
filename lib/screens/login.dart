import 'package:flutter/material.dart';
import 'package:pramov2_ao1_barella/screens/contactos.dart';
import 'package:pramov2_ao1_barella/provider/login_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
            SizedBox(
              height: 200,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    controller: _nombreController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Usuario", style: TextStyle(fontSize: 20)),
                    ),
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
                if (_nombreController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Debe completar todos los campos")),
                  );
                  return;
                }

                try {
                  await loginProvider.login(
                    _nombreController.text,
                    _passwordController.text,
                  );
                } catch (e) {
                  mostrarMensaje(context, "¡USUARIO Y/O CONTRASEÑA INCORRECTOS!", Colors.red, 2);
                }

                //Navigator.push(context, MaterialPageRoute(builder: (context) => Contactos()));
              },
              child: Text("INICIAR SESIÓN", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }

  void login(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    loginProvider
        .login(_nombreController.text, _passwordController.text)
        .catchError((error) {
          mostrarMensaje(context, error.toString(), Colors.red, 2);
        });
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
