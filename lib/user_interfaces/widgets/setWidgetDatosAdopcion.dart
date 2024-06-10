import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:refugio_animales/user_interfaces/RescatarMascota.dart';

class setWidgetDatosAdopcion extends StatelessWidget {
  
  final String image;
  final String nombre;
  final String edad;
  final String raza;
  final String fechaIngreso;
  final String id;
  final String tipoMascota;
  final String ubicacion;



  const setWidgetDatosAdopcion({
    super.key, 
    required this.image, 
    required this.nombre, 
    required this.edad,
    required this.raza,
    required this.fechaIngreso,
    required this.id,
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
                    Container(
                      margin: const EdgeInsets.all(7),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 242, 212, 251),  
                              borderRadius: BorderRadius.circular(20),  
                            ),
                            child:  Text('Hola! me llamo $nombre')
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
                            child:   Text('Soy de la raza $raza')
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 241, 214, 255),  
                              borderRadius: BorderRadius.circular(20),  
                            ),
                            child:   Text('Estoy desde $fechaIngreso')
                          ),
                          const SizedBox(height: 20),
                          
                        ],
                      )

                    )
 
                  ],
                ),
                
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RescatarMascota(nombre: nombre,id: id,edad: edad,image: image, raza: raza,fecha: fechaIngreso,tipoMascota: tipoMascota,ubicacion: ubicacion)),
                    );
                    
                    
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 0, 0, 0), backgroundColor:const Color.fromARGB(255, 238, 170, 255), shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Ajusta el valor para cambiar la redondez de los bordes
                    ),
                    minimumSize: const Size(10.0, 30.0), // Tamaño mínimo del botón
                    padding: const EdgeInsets.symmetric(horizontal: 16.0), // Color del texto del botón
                  ),
                  child:  Text('Rescatar a $nombre'),

                ),
              )
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



