import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:refugio_animales/admin_interfaces/IntPrincipal.dart';
import 'package:refugio_animales/globalInterfaces/crearCuenta.dart';
import 'package:refugio_animales/user_interfaces/IntPrincipalUser.dart';


class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  TextEditingController nombreUsuarioC = TextEditingController();
  TextEditingController contrasenaC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            logo(),

            const SizedBox(height: 40,),
            camposDatosLogin(),
            const SizedBox(height: 40,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const crearCuenta()),
                );
              },
              child: const Text('Crear Cuttttttttttttenta', style: TextStyle(color: Color.fromARGB(255, 75, 150, 255)),),
          ),
          ],
        ),
      )
    );
  }
  
  Widget logo() {
    return   Column(
      children: [
        const SizedBox(height: 40,),
        const Center(
          child: Text('Refugio de Mascotas', style: TextStyle(fontSize: 30),),
    
        ),
        const SizedBox(height: 40,),
        ClipRRect(
            borderRadius: BorderRadius.circular(40.0), 
            child: Image.asset('assets/images/ft.jpg'),

        ),

    
      ]
    );
  }
  
  Widget camposDatosLogin() {
    return Container(
      margin:const EdgeInsets.all(10),
        padding:const  EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:const  Color.fromARGB(255, 241, 221, 247),  
                borderRadius: BorderRadius.circular(20),  
        ),
        child: Column(
        children: [
          const  SizedBox(height: 20,),
          const Text('Login',style: TextStyle(fontSize: 19),),
          const  SizedBox(height: 20,),

          TextField(
            controller:  nombreUsuarioC,
            enableInteractiveSelection: false,
            textCapitalization: TextCapitalization.none,
            decoration: InputDecoration(
              hintText: 'Nombre de Usuario',
              labelText: 'Nombre de Usuario',
              suffixIcon: const  Icon(
                Icons.verified_user
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              )
            ),
            onSubmitted: (valor){
            
            }
          ),
          const Divider(
            height: 18.0,
          ),
          TextField(
            controller:  contrasenaC,
            
            enableInteractiveSelection: false,
            textCapitalization: TextCapitalization.none,
            decoration: InputDecoration(
              hintText: 'Contraseña',
              labelText: 'Contraseña',
              suffixIcon: const  Icon(
                Icons.verified_user
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              )
            ),
            onSubmitted: (valor){
              
            }
          ),
          const Divider(
            height: 50.0,
          ),
          ElevatedButton(
              onPressed: iniciarSesion,
              child: const Text('Iniciar Sesión', style: TextStyle(color: Color.fromARGB(255, 158, 53, 174)),),
          ),
          
         
        ],
      ),
    );
  }
  
  iniciarSesion() async {
    Map<String,dynamic> datos = await validarInicioSesion();
    if(datos['existeUsuario']==true){
      switch(datos['tipo']){
        case 'usuario':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  IntPrincipalUser(idUsuario: datos['idUsuario'],)),
          );
        break;
        case 'admin':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IntPrincipal()),
          );
        break;
      }
    }else{
      _showAlertDialog(context,'Datos Incorrectos');

    }

  
  }
  //funcion en la que mostramos un mensaje de aviso
  void _showAlertDialog(BuildContext context,var textAviso) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Aviso'),
            content: Text(textAviso),
            actions: <Widget>[
              TextButton(
                child:const Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  Future<Map<String,dynamic>> validarInicioSesion() async {
    const String apiUrl = 'https://api-refugio-animal.onrender.com/IniciarSesion';
    Map<String,dynamic> datos;
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombreUsuario': nombreUsuarioC.text,
        'contrasena': contrasenaC.text,
      }),
    );

    if (response.statusCode == 200) {
      datos = jsonDecode(response.body);
      setState(() {});
      return datos;
      
    }else{
      throw Exception('Error al iniciar sesion: ${response.statusCode}');

    } 
  }
 
}

