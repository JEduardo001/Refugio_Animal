import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';


class setWidgetRescatarMascota extends StatelessWidget {

  final String image;
  final String nombre;
  final String edad;
  final String raza;
  final String id;
  final String fecha;
  final String tipoMascota;
  final String ubicacion;


  const setWidgetRescatarMascota({
    super.key, 
    required this.image, 
    required this.nombre, 
    required this.edad,
    required this.raza,
    required this.id,
    required this.fecha,
    required this.tipoMascota,
    required this.ubicacion


  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
      elevation: 30,
      margin: EdgeInsets.zero,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                  Container(
                    width: 200,
                    child:  ClipRRect(
                      borderRadius: BorderRadius.circular(20), 
                      child: decifrarImage(datosImage: image)
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 242, 212, 251),  
                          borderRadius: BorderRadius.circular(20),  
                        ),
                        child:  SingleChildScrollView(
                          scrollDirection: Axis.horizontal, 
                          child: Text(
                            'Me llamo $nombre',
                            style: const TextStyle(fontSize: 14), 
                          ),
                        ),
                      ),        
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 242, 212, 251),  
                          borderRadius: BorderRadius.circular(20),  
                        ),
                        child: Text('Mi edad es $edad')
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 241, 214, 255),  
                          borderRadius: BorderRadius.circular(20),  
                        ),
                        child:  SingleChildScrollView(
                          scrollDirection: Axis.horizontal, 
                          child: Text(
                            'Soy de la raza $raza',
                            style:const TextStyle(fontSize: 14), 
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 241, 214, 255),  
                          borderRadius: BorderRadius.circular(20),  
                        ),
                        child:  SingleChildScrollView(
                          scrollDirection: Axis.horizontal, 
                          child: Text(
                            'Estoy en $ubicacion',
                            style:const TextStyle(fontSize: 14), 
                          ),
                        ),
                      )
                    ],
                  )
 
                  ],
                ),
                
              ),
              
              
            ],
          )
    );
  }
}


Image decifrarImage({required datosImage}){
  // Decodificar la cadena base64 en una lista de enteros
  Uint8List imageData = base64Decode(datosImage);
 
  // Crear una imagen a partir de los datos binarios
  Image image = Image.memory(imageData);
  return image;
}