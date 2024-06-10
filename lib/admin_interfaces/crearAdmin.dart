import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class crearAdmin extends StatefulWidget {
  const crearAdmin({super.key});

  @override
  State<crearAdmin> createState() => _crearAdminState();
}

class _crearAdminState extends State<crearAdmin> {


  TextEditingController nombreUsuarioC = TextEditingController();
  TextEditingController contrasenaC = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Admin', style: TextStyle(fontSize: 30),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40,),

            const SizedBox(height: 50,),
            Container(
              padding:const  EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:const  Color.fromARGB(255, 241, 221, 247),  
                borderRadius: BorderRadius.circular(20),  
              ),
              child: Column(
                children: [
                  const Text('Ingreso de datos', style: TextStyle(fontSize: 25),),
                  const SizedBox(height: 30,),

                  TextField(
                    controller:  nombreUsuarioC,
                    enableInteractiveSelection: false,
                    textCapitalization: TextCapitalization.none,
                    decoration: InputDecoration(
                      hintText: 'Nombre Usuario',
                      labelText: 'Nombre Usuario',
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
                    height: 18.0,
                  ),
                  ElevatedButton(
                    onPressed: crearCuentaAdmin,
                    child: const Text('Crear Cuenta Admin', style: TextStyle(color: Color.fromARGB(255, 158, 53, 174)),),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

 crearCuentaAdmin() async {
    const String apiUrl = 'https://api-refugio-animal.onrender.com';
   
    const String endpoint = '/CrearCuentaAdmin';
    final Map<String, dynamic> requestBody = {
      'nombre': nombreUsuarioC.text,
      'contrasena': contrasenaC.text,

    };

    final response = await http.post(
      Uri.parse('$apiUrl$endpoint'),
      headers: {'Content-Type': 'application/json'}, 
      body: jsonEncode(requestBody), 
    );
    print(jsonEncode(requestBody));

    if (response.statusCode == 200) {
      _showAlertDialog(context,'Cuenta ADMIN Creada exitosamente');

      print('Respuesta de la API: ${response.body}');
    } else {
      print('Error al crear cuenta ADMIN: ${response.reasonPhrase}');
    }
    
    
  } 
}
//funcion para mostrar un mensaje de aviso
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
                child: const Text('Aceptar'),
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
