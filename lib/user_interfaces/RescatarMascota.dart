import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:refugio_animales/user_interfaces/widgets/setWidgetRescatarMascota.dart';
import 'package:http/http.dart' as http;



class RescatarMascota extends StatefulWidget {



  final String image;
  final String nombre;
  final String edad;
  final String raza;
  final String fecha;
  final String id;
  final String tipoMascota;
  final String ubicacion;

   RescatarMascota({
    super.key, 
    required this.image, 
    required this.nombre, 
    required this.edad,
    required this.raza,
    required this.fecha,
    required this.id,
    required this.tipoMascota,
    required this.ubicacion


  });

  @override
  State<RescatarMascota> createState() => _RescatarMascotaState(nombre: nombre,id:id,image: image,edad: edad,fecha: fecha,raza: raza,tipoMascota: tipoMascota,ubicacion: ubicacion);
}

class _RescatarMascotaState extends State<RescatarMascota> {

  TextEditingController nombreTutorC = TextEditingController();
  TextEditingController direccionC = TextEditingController();
  TextEditingController telefonoC = TextEditingController();
  TextEditingController correoElectronicoC = TextEditingController();
  
  final String image;
  final String nombre;
  final String edad;
  final String raza;
  final String fecha;
  final String id;
  final String tipoMascota;
  final String ubicacion;



   _RescatarMascotaState({
    required this.image, 
    required this.nombre, 
    required this.edad,
    required this.raza,
    required this.fecha,
    required this.id,
    required this.tipoMascota,
    required this.ubicacion


  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REFUGIO DE MASCOTAS'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            setWidgetRescatarMascota(
              image: image,
              edad: edad,
              nombre: nombre,
              raza: raza,
              fecha: fecha,
              id: id,
              tipoMascota: tipoMascota,
              ubicacion: ubicacion,

            ),
            const SizedBox(height: 20,),
            const Text('Agrega tus Datos', style: TextStyle(fontSize: 25),),
            const SizedBox(height: 20,),

            TextField(
              controller:  nombreTutorC,
              enableInteractiveSelection: false,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                hintText: 'Nombre Tutor',
                labelText: 'Nombre Tutor',
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
              textCapitalization: TextCapitalization.characters,
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
              textCapitalization: TextCapitalization.characters,
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
              textCapitalization: TextCapitalization.characters,
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
            ElevatedButton(
              onPressed: accionesRescatarMascota,
              child:  Text('Rescatar a $nombre', style: TextStyle(color: Color.fromARGB(255, 158, 53, 174)),),
            ),
              


          ],
        ),
      )
    );
  }
  

  Future<void> subirRescateMascota() async {
    // URL de la API
    const String apiUrl = 'https://api-refugio-animal.onrender.com';
    
      const String endpoint = '/SubirReporteRescateMascota';
      final Map<String, dynamic> requestBody = {
        'nombreTutor': nombreTutorC.text,
        'direccion': direccionC.text,
        'telefono': telefonoC.text,
        'correoElectronico': correoElectronicoC.text,
        'idMascota': id,
        'tipoMascota': tipoMascota,
        'ubicacionMascota': ubicacion

       
        
      };

      final response = await http.post(
        Uri.parse('$apiUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody), 
      );
      print(jsonEncode(requestBody));

      // Leer la respuesta como JSON
      if (response.statusCode == 200) {
        _showAlertDialog(context,'Haz rescatado a $nombre. Pasa por $nombre al refugio de 10:00 AM a 6:00 PM');

        print('Respuesta de la API: ${response.body}');
      } else {
        print('Error al subir la el reporte de recate de mascota: ${response.reasonPhrase}');
      }
    
  }

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
  
  

  void accionesRescatarMascota() {
    subirRescateMascota();
    desactivarMascota();
  }

  desactivarMascota()async {
    const String apiUrl = 'https://api-refugio-animal.onrender.com';
    
    const String endpoint = '/DesactivarMascota';

    final Map<String, dynamic> requestBody = {
      'tipoMascota': tipoMascota,
      'ubicacion': ubicacion,
      'id': id,
      'valor': true 
    };

    final response = await http.post(
      Uri.parse('$apiUrl$endpoint'),
      headers: {'Content-Type': 'application/json'}, // Especifica el tipo de contenido como JSON
      body: jsonEncode(requestBody), // Codifica los parámetros como JSON
    );
    print(jsonEncode(requestBody));

    if (response.statusCode == 200) {

      print('Respuesta de la API: ${response.body}');
    } else {
      print('Error al desactivar la mascota: ${response.reasonPhrase}');
    }
  }
}