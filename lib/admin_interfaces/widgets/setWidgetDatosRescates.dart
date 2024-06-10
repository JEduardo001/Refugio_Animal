import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;



class setWidgetDatosRescates extends StatelessWidget {
  
  
  final String correoElectronico;
  final String direccion;
  final int idMascota;
  final String nombreTutor;
  final String telefono;
  final String tipoMascota;
  final String ubicacionMascota;

  final String edadMascota;
  final String especie;
  final String imagen;
  final String nombreMascota;
  final String razaMascota;
  final bool signosMaltrato;
  final bool vacunaLeptospirosis;
  final bool vacunaRabia;

  final BuildContext context;


  setWidgetDatosRescates({
    super.key, 
    required this.correoElectronico, 
    required this.direccion, 
    required this.idMascota,
    required this.nombreTutor,
    required this.telefono,
    required this.tipoMascota,
    required this.ubicacionMascota,
    required this.edadMascota,
    required this.especie,
    required this.imagen,
    required this.nombreMascota,
    required this.razaMascota,
    required this.signosMaltrato,
    required this.vacunaLeptospirosis,
    required this.vacunaRabia,
    required this.context,



  });
  List<String> lista = ['Hola1', 'Hola2', 'Hola3'];


  @override
  Widget build(BuildContext context) {
    return Card(
      
      color: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
      elevation: 30,
          child: Column(
            children: [
              const Text('Datos de mascota', style: TextStyle(fontSize: 20),),
              const SizedBox(height: 20,),
              Center(
                child: Container(
                  width: 200,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(20), 
                    child: decifrarImage(datosImage: imagen)
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 242, 212, 251),  
                  borderRadius: BorderRadius.circular(20),  
                ),
                child:  Text('ID: $idMascota', style: const TextStyle(fontSize: 16),)
              ), 
              const SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 242, 212, 251),  
                  borderRadius: BorderRadius.circular(20),  
                ),
                child:  Text('Nombre: $nombreMascota', style: const TextStyle(fontSize: 16),)
              ),      
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 242, 212, 251),  
                  borderRadius: BorderRadius.circular(20),  
                ),
                child: Text('Edad: $edadMascota', style: const TextStyle(fontSize: 16),)
              ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 214, 255),  
                borderRadius: BorderRadius.circular(20),  
              ),
              child:   Text('Raza: $razaMascota',style: const TextStyle(fontSize: 16),)
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 214, 255),  
                borderRadius: BorderRadius.circular(20),  
              ),
              child:   Text('Especie: $especie',style: const TextStyle(fontSize: 16),)
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 214, 255),  
                borderRadius: BorderRadius.circular(20),  
              ),
              child:   Text('Ubicacion: $ubicacionMascota',style: const TextStyle(fontSize: 16),)
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 214, 255),  
                borderRadius: BorderRadius.circular(20),  
              ),
              child:   Text('Signos de Maltrato: $signosMaltrato',style: const TextStyle(fontSize: 16),)
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 214, 255),  
                borderRadius: BorderRadius.circular(20),  
              ),
              child:   Text('Vacuna Leptospirosis : $vacunaLeptospirosis',style: const TextStyle(fontSize: 16),)
            ),
             const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 214, 255),  
                borderRadius: BorderRadius.circular(20),  
              ),
              child:   Text('Vacuna Rabia : $vacunaRabia',style: const TextStyle(fontSize: 16),)
            ),
            const SizedBox(height: 20),
            const Text('Datos Tutor: ',style:  TextStyle(fontSize: 26),),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 242, 212, 251),  
                borderRadius: BorderRadius.circular(20),  
              ),
              child:  Text('Nombre Tutor: $nombreTutor', style: const TextStyle(fontSize: 16),)
            ), 
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 242, 212, 251),  
                borderRadius: BorderRadius.circular(20),  
              ),
              child:  Text('Telefono: $telefono', style: const TextStyle(fontSize: 16),)
            ), 
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 242, 212, 251),  
                borderRadius: BorderRadius.circular(20),  
              ),
              child:  Text('Direccion: $direccion', style: const TextStyle(fontSize: 16),)
            ), 
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 242, 212, 251),  
                borderRadius: BorderRadius.circular(20),  
              ),
              child:  Text('Correo Electronico: $correoElectronico', style: const TextStyle(fontSize: 16),)
            ), 
            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showAlertDialog(context, 'Si confirmas el rescate, Se eliminará la mascota y el reporte concluyendo con su estadia');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 0, 0, 0), backgroundColor:const Color.fromARGB(255, 91, 255, 179), shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Ajusta el valor para cambiar la redondez de los bordes
                  ),
                  minimumSize: const Size(10.0, 30.0), // Tamaño mínimo del botón
                  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Color del texto del botón
                ),
                child: const Text('Confirmar Rescate'),
              ),
            )
            ],
          )
    );
  }
  
 
  void rescatarMascota() async {
    const String apiUrl = 'https://api-refugio-animal.onrender.com';
    
      const String endpoint = '/rescatarMascota';
      //preparamos los dato para mandarlos como endpoint
      final Map<String, dynamic> requestBody = {
        'idMascota': idMascota,
        'tipoMascota': tipoMascota,
        'ubicacionMascota': ubicacionMascota
        
      };

      final response = await http.delete(
        Uri.parse('$apiUrl$endpoint'),
        headers: {'Content-Type': 'application/json'}, 
        body: jsonEncode(requestBody), 
      );
      print(jsonEncode(requestBody));

      if (response.statusCode == 200) {
        _showAlertDialog2(context,'RESCATE CONFIRMADO!! Solo queda esperar a que el nuevo tutor pase por $nombreMascota');

        print('Respuesta de la API: ${response.body}');
      } else {
        print('Error al subir la imagen: ${response.reasonPhrase}');
      }
    
  }
  //funcion que muestra un mensaje de aviso
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
                child: const Text('Confirmar Rescate'),
                onPressed: () {
                  rescatarMascota();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child:const Text('Cancelar'),
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
  //funcion que muestra un mensaje de aviso
  void _showAlertDialog2(BuildContext context,var textAviso) {
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
  

}

Image decifrarImage({required datosImage}){
  // Decodificar la cadena base64 en una lista de enteros
  Uint8List imageData = base64Decode(datosImage);
  // Crear una imagen a partir de los datos binarios
  Image image = Image.memory(imageData);
  return image;
}



