import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class crearCuenta extends StatefulWidget {
  const crearCuenta({super.key});

  @override
  State<crearCuenta> createState() => _crearCuentaState();
}

class _crearCuentaState extends State<crearCuenta> {


  TextEditingController nombreUsuarioC = TextEditingController();
  TextEditingController telefonoC = TextEditingController();
  TextEditingController direccionC = TextEditingController();
  TextEditingController correoElectronicoC = TextEditingController();
  TextEditingController contrasenaC = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crea una cuenta', style: TextStyle(fontSize: 30),),
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
                  const Text('Ingresa tus datos', style: TextStyle(fontSize: 25),),
                  const SizedBox(height: 30,),

                  TextField(
                    controller:  nombreUsuarioC,
                    enableInteractiveSelection: false,
                    textCapitalization: TextCapitalization.none,
                    decoration: InputDecoration(
                      hintText: 'Nombre de usuario',
                      labelText: 'Nombre de usuario',
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
                    controller:  direccionC,
                    enableInteractiveSelection: false,
                    textCapitalization: TextCapitalization.none,
                    decoration: InputDecoration(
                      hintText: 'Dirección',
                      labelText: 'Dirección',
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
                    keyboardType: TextInputType.number,
                    controller:  telefonoC,
                    enableInteractiveSelection: false,
                    textCapitalization: TextCapitalization.none,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      hintText: 'Teléfono',
                      labelText: 'Teléfono',
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
                    controller:  correoElectronicoC,
                    enableInteractiveSelection: false,
                    textCapitalization: TextCapitalization.none,
                    decoration: InputDecoration(
                      hintText: 'Correo Electrónico',
                      labelText: 'Correo Electrónico',
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
                    onPressed: crearCuenta,
                    child: const Text('Crear Cuenta', style: TextStyle(color: Color.fromARGB(255, 158, 53, 174)),),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

 crearCuenta() async {
    const String apiUrl = 'https://api-refugio-animal.onrender.com';
   
    const String endpoint = '/CrearCuenta';
    //preparamos los parametros
    final Map<String, dynamic> requestBody = {
      'nombre': nombreUsuarioC.text,
      'direccion': direccionC.text,
      'telefono': telefonoC.text,
      'correoElectronico': correoElectronicoC.text,
      'contrasena': contrasenaC.text

    };

    final response = await http.post(
      Uri.parse('$apiUrl$endpoint'),
      headers: {'Content-Type': 'application/json'}, 
      body: jsonEncode(requestBody), 
    );
    print(jsonEncode(requestBody));

    if (response.statusCode == 200) {
      _showAlertDialog(context,'Cuenta creada exitosamente');

      print('Respuesta de la API: ${response.body}');
    } else {
      print('Error al subir la imagen: ${response.reasonPhrase}');
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
