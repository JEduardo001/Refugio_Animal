import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:refugio_animales/admin_interfaces/AgregarMascota.dart';
import 'package:refugio_animales/admin_interfaces/crearAdmin.dart';
import 'package:refugio_animales/admin_interfaces/verRescates.dart';
import 'package:refugio_animales/admin_interfaces/widgets/setWidgetDatosPerdidos.dart';
import 'package:refugio_animales/admin_interfaces/widgets/setWidgetDatosTodos.dart';
import 'package:refugio_animales/admin_interfaces/widgets/setWidgetDatosAdopcion.dart';

class IntPrincipal extends StatefulWidget {
  const IntPrincipal({super.key});

  @override
  State<IntPrincipal> createState() => _IntPrincipalState();
}

class _IntPrincipalState extends State<IntPrincipal> {
  var opcionEscogidaMenuAnimales = 'VerGatos';
  var opcionEscogidaMenuFiltros = 'EnAdopcion';

  Map<String,dynamic> btnsMenuAnimales = {
    'VerGatos': {
      'color': const Color.fromARGB(255, 177, 249, 106),
    },
    'VerPerros': {
      'color': const Color.fromARGB(255, 255, 255, 255),
    },
    'btnAgregarMascota': {
      'color': const Color.fromARGB(255, 255, 255, 255),
    },
    'VerRescates': {
      'color': const Color.fromARGB(255, 255, 255, 255),
    }
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
        title: const Text('ADMINISTRACIÓN DEL REFUGIO'),
      ),
      body: Column(
        children: [
         Container(
          padding: const EdgeInsets.all(10),
            height: 50, 
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 240, 196, 255),  
              borderRadius: BorderRadius.circular(20),  
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
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
                  const SizedBox(width: 5,),
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
                  const SizedBox(width: 5,),

                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AgregarMascota()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: btnsMenuAnimales['btnAgregarMascota']['color'],
                          borderRadius: BorderRadius.circular(10.0), 
                        ),
                        child: const Text(
                          'Agregar Mascota ',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                  ),
                  const SizedBox(width: 5,),

                  InkWell(
                     onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const verRescates()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: btnsMenuAnimales['VerRescates']['color'],
                          borderRadius: BorderRadius.circular(10.0), 
                        ),
                        child: const Text(
                          'Ver Rescates',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                  ),
                  const SizedBox(width: 5,),
                  InkWell(
                     onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const crearAdmin()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10.0), 
                        ),
                        child: const Text(
                          'Crear usuario administrador',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                  ),

                ],
              ),
            ),
         ),
          const SizedBox(height: 20,),
          
          Container(
            height: 40,
            decoration: BoxDecoration(
              color:const  Color.fromARGB(255, 249, 230, 255),  
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
                     borderRadius: BorderRadius.circular(10.0),
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
                return const CircularProgressIndicator(); // Muestra un indicador de carga mientras se espera el resultado
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // Muestra un mensaje de error si ocurre algún problema
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
                          
                            setPubliaciones(i)
                            
                           

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
            fecha: '${datos['fechaIngreso']}',
            tipoMascota: '${datos['especie']}',
            ubicacion: '${datos['ubicacion']}',
           

          );
          break;
        default:
          return const SizedBox(); 
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




