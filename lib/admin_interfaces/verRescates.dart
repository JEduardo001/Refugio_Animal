import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:refugio_animales/admin_interfaces/widgets/setWidgetDatosRescates.dart';


class verRescates extends StatefulWidget {
  const verRescates({super.key});

  @override
  State<verRescates> createState() => _verRescatesState();
}

class _verRescatesState extends State<verRescates> {

  late List<Map<String, dynamic>> datos;
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rescates Activos', style: TextStyle(fontSize: 20)),
      ),
      body: FutureBuilder(
            future: traerDatos(),
            builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                datos = snapshot.data!;

                return datos.isEmpty
                    ? Center(child: setAviso())
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: datos.length,
                        itemBuilder: (context, index) {
                          var i = datos[index];
                          return setWidgetDatosRescates(
                            correoElectronico: i['correoElectronico'],
                            direccion: i['direccion'],
                            idMascota: i['idMascota'],
                            nombreTutor: i['nombreTutor'],
                            telefono: i['telefono'],
                            tipoMascota: i['tipoMascota'],
                            ubicacionMascota: i['ubicacionMascota'],
                            edadMascota: i['edad'],
                            especie: i['especie'],
                            imagen: i['imagen'],
                            nombreMascota: i['nombre'],
                            razaMascota: i['raza'],
                            signosMaltrato: i['signosMaltrato'],
                            vacunaLeptospirosis: i['vacunaLeptospirosis'],
                            vacunaRabia: i['vacunaRabia'],
                            context: context,

                          );
                        },
                      );
              }
            },
          ),
    );
  }
  Widget setAviso() {
    return const Text('No hay Rescates');
  }
}


Future<List<Map<String,dynamic>>> traerDatos() async{
  //especificamos el endpoint de la api
  final response = await http.get(Uri.parse('https://api-refugio-animal.onrender.com/getRescates'));
  if (response.statusCode == 200) {
   
    List<dynamic> jsonResponse = jsonDecode(response.body);
    List<Map<String, dynamic>> data = jsonResponse.map((e) => e as Map<String, dynamic>).toList();

    return data;
  } else {
    print('Error al traer los datos: ${response.statusCode}');
    throw Exception('Error al traer los datos: ${response.statusCode}');

  }
}