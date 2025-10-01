import 'package:flutter/material.dart';
import 'package:pramov2_ao1_barella/screens/contactos.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _nombreController =TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/notebook.png", height: 150, width: 150),
            Text("AGENDA FLUTTER", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            SizedBox(height: 200, width: 300, child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: _nombreController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Usuario", style: TextStyle(fontSize: 20))
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Contraseña", style: TextStyle(fontSize: 20))
                  ),
                )
              ],
            )
            ),
            ElevatedButton(onPressed: (){

              if(_nombreController.text.isEmpty || _passwordController.text.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Debe completar todos los campos")));
                return;
              }

              Navigator.push(context, MaterialPageRoute(builder: (context) => Contactos()));
            }, child: Text("INICIAR SESIÓN", style: TextStyle(fontSize: 20))),
          ],
        ),
      ),
    );
  }
}