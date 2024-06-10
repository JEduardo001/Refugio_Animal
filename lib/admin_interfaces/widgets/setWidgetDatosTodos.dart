import 'package:flutter/material.dart';
import 'package:refugio_animales/admin_interfaces/administrarMascota.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:refugio_animales/admin_interfaces/widgets/widgetCamposDatos.dart';

class setWidgetDatosTodos extends StatelessWidget {

  final String image;
  final String nombre;
  final String edad;
  final String raza;
  final String id;
  final String fecha;
  final String tipoMascota;
  final String ubicacion;


  const setWidgetDatosTodos({
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
                  Container(
                    margin: const EdgeInsets.all(7),
                    child: widgetCamposDatos(nombre: nombre, edad: edad, raza: raza)

                  )
 
                  ],
                ),
                
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => administrarMascota(nombre: nombre,id: id,edad: edad,image: image, raza: raza,fecha: fecha,tipoMascota: tipoMascota,ubicacion:ubicacion)),

                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 0, 0, 0), backgroundColor:const Color.fromARGB(255, 238, 170, 255), shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Ajusta el valor para cambiar la redondez de los bordes
                    ),
                    minimumSize: const Size(10.0, 30.0), // Tamaño mínimo del botón
                    padding: const EdgeInsets.symmetric(horizontal: 16.0), // Color del texto del botón
                  ),
                  child: const Text('Administrar'),
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