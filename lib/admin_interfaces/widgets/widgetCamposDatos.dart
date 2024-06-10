import 'package:flutter/material.dart';


class widgetCamposDatos extends StatelessWidget {
  
  final String nombre;
  final String edad;
  final String raza;

  const widgetCamposDatos({
    super.key,
    required this.nombre,
    required this.edad,
    required this.raza 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          )
        ],
      );
  }
}