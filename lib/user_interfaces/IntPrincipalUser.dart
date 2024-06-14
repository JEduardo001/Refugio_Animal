import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:refugio_animales/user_interfaces/widgets/setWidgetDatosPerdidos.dart';
import 'package:refugio_animales/user_interfaces/widgets/setWidgetDatosTodos.dart';
import 'package:refugio_animales/user_interfaces/widgets/setWidgetDatosAdopcion.dart';

class IntPrincipalUser extends StatefulWidget {
  final int idUsuario;
  IntPrincipalUser(
    {
      required this.idUsuario, 
    }
  );
  

  @override
  State<IntPrincipalUser> createState() => _IntPrincipalUserState(idUsuario: idUsuario);
}

class _IntPrincipalUserState extends State<IntPrincipalUser> {

 final int idUsuario;


  _IntPrincipalUserState(
    {
      required this.idUsuario, 
    }
  );

  var opcionEscogidaMenuAnimales = 'VerGatos';
  var opcionEscogidaMenuFiltros = 'EnAdopcion';

  Map<String,dynamic> btnsMenuAnimales = {
    'VerGatos': {
      'color': const Color.fromARGB(255, 177, 249, 106),
      'destinoPublicacion': 'publicacionesPerdidos'
    },
    'VerPerros': {
      'color': const Color.fromARGB(255, 255, 255, 255),
      'destinoPublicacion': 'publicacionesAdopcion'
    },
  };

  Map<String,dynamic> btnsMenuFiltros = {
    'EnAdopcion': {
      'color': const Color.fromARGB(255, 177, 249, 106),
      'opcionEscogida': 'publicacionesPerdidos'
    },
    'VerPerdidos': {
      'color': const Color.fromARGB(255, 255, 255, 255),
      'opcionEscogida': 'publicacionesAdopcion'
    },
    'VerTodos': {
      'color': const Color.fromARGB(255, 255, 255, 255),
      'opcionEscogida': 'publicacionesVerTodos'
    },
   
  };
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REFUGIO DE MASCOTAS'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 240, 196, 255),  
              borderRadius: BorderRadius.circular(20),  
            ),
            child:  Row(
              children: [
                const SizedBox(height: 30),
                const Spacer(),
                InkWell(
                     
                      onTap: () => hacerAccionesMenuAnimales(opcion: 'VerGatos'),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: btnsMenuAnimales['VerGatos']['color'],
                          borderRadius: BorderRadius.circular(10.0), 
                        ),
                        child: const Text(
                          'Ver Gatos',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => hacerAccionesMenuAnimales(opcion: 'VerPerros'),
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: btnsMenuAnimales['VerPerros']['color'],
                      borderRadius: BorderRadius.circular(10.0), 
                    ),
                    child: const Text(
                      'Ver Perros ',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
                const Spacer(),
               
              ],
            ),
          ),
          const SizedBox(height: 20,),
          
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:const Color.fromARGB(255, 242, 221, 249),  
              borderRadius: BorderRadius.circular(20),  
            ),
            child: Row(
              children: [
                const SizedBox(height: 30),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => hacerAccionesMenuFiltros(opcion: 'EnAdopcion'),
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                     color: btnsMenuFiltros['EnAdopcion']['color'],
                     borderRadius: BorderRadius.circular(10.0), // Ajusta el radio según tus necesidades
                    ),
                    child: const Text(
                      'En adopción',
                       style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
                const Spacer(),
                 InkWell(
                  onTap: () => hacerAccionesMenuFiltros(opcion: 'VerTodos'),
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                     color: btnsMenuFiltros['VerTodos']['color'],
                     borderRadius: BorderRadius.circular(10.0), 
                    ),
                    child: const Text(
                      'Ver Todos',
                       style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => hacerAccionesMenuFiltros(opcion: 'VerPerdidos'),
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: btnsMenuFiltros['VerPerdidos']['color'],
                      borderRadius: BorderRadius.circular(10.0), 
                    ),
                    child: const Text(
                      'Ver Perdidos',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              const SizedBox(width: 10,)
              ],
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: actualizarInterfaz,
            child: const Text('Actualizar', style: TextStyle(color: Color.fromARGB(255, 158, 53, 174)),),
          ),
          const SizedBox(height: 20,),
          FutureBuilder(
            future: traerDatos(opcionMenuAnimales: opcionEscogidaMenuAnimales,opcionMenuFiltros:opcionEscogidaMenuFiltros ),
            builder: (context,AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); 
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); 
              } else {
          
                
                List<Map<String, dynamic>> datos = snapshot.data!;

                return Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints)  {
                      return ListView (
                        children: [
                          const SizedBox(height: 20,),

                          datos.isEmpty
                            ? setAviso()
                            : const Text(''),
                          
                          for (var i in datos)
                            i['adoptado']==false
                              ? setPubliaciones(i)
                              : const Text('')
                            
            
                        ],
                        
                      );
                    },
                  ),
                );
              
              }
            },
          )
         
        ],
      )
     
    );
  }


  void _cambiarColorMenuAnimales(String opcion) {
    setState(() {
      for(var clave in btnsMenuAnimales.keys){
        if(clave==opcion){
          btnsMenuAnimales[clave]['color'] = const Color.fromARGB(255, 177, 249, 106);
        }else{
          btnsMenuAnimales[clave]['color'] = const Color.fromARGB(255, 255, 255, 255);
        }
      }
      
    });
  }
  hacerAccionesMenuAnimales({required String opcion}) {
    setState(() {
      _cambiarColorMenuAnimales(opcion);
      opcionEscogidaMenuAnimales=opcion;
    });
  }

  void _cambiarColorMenuFiltros(String claveBtnPresionado) { 
    for(var clave in btnsMenuFiltros.keys){
      if(clave==claveBtnPresionado){
        btnsMenuFiltros[clave]['color'] = const Color.fromARGB(255, 177, 249, 106);
      }else{
        btnsMenuFiltros[clave]['color'] = const Color.fromARGB(255, 255, 255, 255);
      }
    }
  }
  
  hacerAccionesMenuFiltros({required String opcion}) {
    setState(() {
      _cambiarColorMenuFiltros(opcion);
      opcionEscogidaMenuFiltros=opcion;
    });
  }
  
  Widget setPubliaciones(datos) {

      switch (opcionEscogidaMenuFiltros) {
        case 'EnAdopcion':
          return setWidgetDatosAdopcion(
            image: '${datos['imagen']}',
            edad: '${datos['edad']}',
            nombre: '${datos['nombre']}',
            raza: '${datos['raza']}',
            fechaIngreso: '${datos['fecha']}',
            id: '${datos['id']}',
            tipoMascota: '${datos['especie']}',
            ubicacion: '${datos['ubicacion']}',


          );
          break;
        case 'VerPerdidos':
          return setWidgetDatosPerdidos(
            image: '${datos['imagen']}',
            edad: '${datos['edad']}',
            nombre: '${datos['nombre']}',
            raza: '${datos['raza']}',
            fechaPerdido: '${datos['fecha']}',
            id: '${datos['id']}',
            tipoMascota: '${datos['especie']}',
            ubicacion: '${datos['ubicacion']}',


          );
          break;
        case 'VerTodos':
          return setWidgetDatosTodos(
            image: '${datos['imagen']}',
            edad: '${datos['edad']}',
            nombre: '${datos['nombre']}',
            raza: '${datos['raza']}',
            id: '${datos['id']}',
            fecha: '${datos['fecha']}',
            tipoMascota: '${datos['especie']}',
            ubicacion: '${datos['ubicacion']}',

          );
          break;
        default:
          return SizedBox(); 
      };
  }
  
  Widget setAviso() {
    return const Center(
      child: Text('No hay registros'),
    );
  }
  
  actualizarInterfaz() {
    setState(() {
      
    });
  }
}

Future<List<Map<String,dynamic>>> traerDatos({required opcionMenuAnimales,required opcionMenuFiltros}) async{
  //end point de la api
  final response = await http.get(Uri.parse('https://api-refugio-animal.onrender.com/${opcionMenuAnimales+opcionMenuFiltros}'));
  if (response.statusCode == 200) {
   
    List<dynamic> jsonResponse = jsonDecode(response.body);
    List<Map<String, dynamic>> data = jsonResponse.map((e) => e as Map<String, dynamic>).toList();

    return data;
  } else {
    print('Error al traer los datos: ${response.statusCode}');
    throw Exception('Error al traer los datos: ${response.statusCode}');

  }
}

