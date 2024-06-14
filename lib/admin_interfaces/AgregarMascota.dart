import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;



class AgregarMascota extends StatefulWidget {
  const AgregarMascota({super.key});

  @override
  State<AgregarMascota> createState() => _AgregarMascotaState();
}

class _AgregarMascotaState extends State<AgregarMascota> {

  //controladores para los textfield
  TextEditingController nombreMascotaC = TextEditingController();
  TextEditingController razaMascotaC = TextEditingController();
  TextEditingController edadMascotaC = TextEditingController();
  TextEditingController fechaMascotaC = TextEditingController();


  //declaramos variables
  var tipoMascota = 'gatos';
  var destinoMascota = 'adoptar';
  bool selectValorSignosMaltrato = false;
  bool selectValorVacunaRabia= false;
  bool selectValorVacunaLeptospirosis= false;
  bool selectValorVacunaCoronavirus= false;
  bool selectValorVacunaPeritonitis= false;
  bool selectValorVacunaCalcivirus= false;





  File? image;
  Uint8List? bytes;
  Uint8List? compressedBytes;
  String? base64String;

  Map<String,dynamic> BtnsTipoMascotaAgregar = {
    'gatos': {
      'color': const Color.fromARGB(255, 177, 249, 106),
    },
    'perros': {
      'color': const Color.fromARGB(255, 255, 255, 255),
    },
  
  };

  Map<String,dynamic> BtnsDestinoMascota = {
    'adoptar': {
      'color': const Color.fromARGB(255, 177, 249, 106),
    },
    'perdido': {
      'color': const Color.fromARGB(255, 255, 255, 255),
    },
  
  };
  //funcion que es para seleccionar una imagen por galeria y pasar la imagen a base64
  Future<void> _pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      final XFile? imageBinaria = pickedFile;
      if(pickedFile!=null){
        bytes = await File(imageBinaria!.path).readAsBytes();
        base64String = base64Encode(bytes!);
        setState(() {
          image = File(pickedFile.path);
        });
      }else{
        _showAlertDialog(context, 'Porfavor selecciona una imagen');
      }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        fechaMascotaC.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AGREGAR MASCOTA'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30,),
            const Text('¿Que mascota es?',style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 20)),
            const SizedBox(height: 30,),
            Container(
              margin: const EdgeInsets.only(left: 80,right: 80),
              child: Row(
                children: [
                    InkWell(
                      onTap: () => hacerAccionesMenuTipoMascota(opcion: 'perros'),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: BtnsTipoMascotaAgregar['perros']['color'],
                          borderRadius: BorderRadius.circular(10.0), // Ajusta el radio según tus necesidades
                        ),
                        child: const Text(
                          'Perro',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                    const Spacer(),

                    InkWell(
                      onTap: () => hacerAccionesMenuTipoMascota(opcion: 'gatos'),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: BtnsTipoMascotaAgregar['gatos']['color'],
                          borderRadius: BorderRadius.circular(10.0), // Ajusta el radio según tus necesidades
                        ),
                        child: const Text(
                          'Gato',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 30,),
            const Text("¿Cual es el destino?",style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 20)),
            const SizedBox(height: 30,),
            Container(
              margin: const EdgeInsets.only(left: 40,right: 40),
              child: Row(
                children: [
                    InkWell(
                      onTap: () => hacerAccionesMenuDestinoMascota(opcion: 'adoptar'),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: BtnsDestinoMascota['adoptar']['color'],
                          borderRadius: BorderRadius.circular(10.0), // Ajusta el radio según tus necesidades
                        ),
                        child: const Text(
                          'Para adoptar',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () => hacerAccionesMenuDestinoMascota(opcion: 'perdido'),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: BtnsDestinoMascota['perdido']['color'],
                          borderRadius: BorderRadius.circular(10.0), // Ajusta el radio según tus necesidades
                        ),
                        child: const Text(
                          'Para Perdidos',
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            setFormularioDatosMascota(),
           
          
          ],
        ),
      )
    );
  }

  void _cambiarColorMenuTipoMascota(String opcion) {
    setState(() {
      for(var clave in BtnsTipoMascotaAgregar.keys){
        if(clave==opcion){
          BtnsTipoMascotaAgregar[clave]['color'] = const Color.fromARGB(255, 177, 249, 106);
        }else{
          BtnsTipoMascotaAgregar[clave]['color'] = const Color.fromARGB(255, 255, 255, 255);
        }
      }
      
    });
  }
  hacerAccionesMenuTipoMascota({required String opcion}) {
    setState(() {
      _cambiarColorMenuTipoMascota(opcion);
      tipoMascota=opcion;
    });
  }
  
  void _cambiarColorMenuDestinoMascota(String opcion) {
    setState(() {
      for(var clave in BtnsDestinoMascota.keys){
        if(clave==opcion){
          BtnsDestinoMascota[clave]['color'] = const Color.fromARGB(255, 177, 249, 106);
        }else{
          BtnsDestinoMascota[clave]['color'] = const Color.fromARGB(255, 255, 255, 255);
        }
      }
      
    });
  }

  hacerAccionesMenuDestinoMascota({required String opcion}) {
    setState(() {
      _cambiarColorMenuDestinoMascota(opcion);
      destinoMascota=opcion;
    });
  }

  subirMascota() async {
    // URL de la API
    const String apiUrl = 'https://api-refugio-animal.onrender.com';
    if(base64String==null){
      _showAlertDialog(context,'Porfavor Ingresa una imagen');
    }else{
      const String endpoint = '/SubirMascota';
      final Map<String, dynamic> requestBody = {
        'nombre': nombreMascotaC.text,
        'edad': edadMascotaC.text,
        'raza': razaMascotaC.text,
        'imagen': base64String,
        'fecha': fechaMascotaC.text,
        'tipoMascota': tipoMascota,
        'destinoMascota': destinoMascota,
        'signosMaltrato': selectValorSignosMaltrato,
        'vacunaRabia': selectValorVacunaRabia,
        'vacunaLeptospirosis': selectValorVacunaLeptospirosis,
        'vacunaCoronavirus': selectValorVacunaCoronavirus,
        'vacunaPeritonitis': selectValorVacunaPeritonitis,
        'vacunaCalcivirus': selectValorVacunaCalcivirus,
   
      };

      final response = await http.post(
        Uri.parse('$apiUrl$endpoint'),
        headers: {'Content-Type': 'application/json'}, 
        body: jsonEncode(requestBody), 
      );
      print(jsonEncode(requestBody));

      if (response.statusCode == 200) {
        _showAlertDialog(context,'Mascota agregada correctamente');

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

  Widget setFormularioDatosMascota(){
    return Container(
      decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 222, 222),  
              borderRadius: BorderRadius.circular(20),  
            ),
        constraints: const BoxConstraints(
              maxHeight: 400,
        ),
        child: ListView(
        children: [
          Container(
            child: Column(
             children: [
              const SizedBox(height: 10,),
              const Text("Agrega sus Datos",style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 20)),
              const SizedBox(height: 10,),
              TextField(
                controller:  nombreMascotaC,
                enableInteractiveSelection: false,
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(
                  hintText: 'Nombre',
                  labelText: 'Nombre',
                  suffixIcon: const  Icon(
                    Icons.verified_user
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  )
                ),
                onSubmitted: (valor){
                 
                  },
                ),
                
                const Divider(
                  height: 18.0,
                ),
                TextField(
                  controller:  razaMascotaC,
                  enableInteractiveSelection: false,
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                    hintText: 'Raza',
                    labelText: 'Raza',
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
                  controller:  edadMascotaC,
                  enableInteractiveSelection: false,
                  textCapitalization: TextCapitalization.none,
                  
                  decoration: InputDecoration(
                    hintText: 'Edad',
                    labelText: 'Edad',
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
                  height: 14.0,
                ),
                const Text('¿Porta signos de maltrato?',style: TextStyle(fontSize: 18),),
                const Divider(
                  height: 18.0,
                ),
                DropdownButton<bool>(
                  value: selectValorSignosMaltrato,
                  items:  const [
                    DropdownMenuItem(
                      value: true,
                      child: Text('Con Signos'),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Text('Sin Signos'),
                    ),
                  ],
                  onChanged: (bool? newValue) {
                    setState(() {
                      selectValorSignosMaltrato = newValue!;
                    });
                  },
                  hint:const  Text('Asigna un valor'),
                ),
                setTipoVacuna(),
                setCampoFecha(),
                const SizedBox(height: 20,),
                Row(
                  
                  children: [
                    const SizedBox(width: 40,),
                    image == null
                    ? const Text("Sin imagen")
                    : SizedBox( width: 100, height: 100, child: ClipRRect( borderRadius: BorderRadius.circular(30), child: Image.file(image!), )),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Seleccionar Imagen'),
                    ),
                    const SizedBox(width: 10,),
                   

                  ],
                ),
                const SizedBox(width: 40,),
                ElevatedButton(
                      onPressed: subirMascota,
                      child: const Text('Añadir Mascota', style: TextStyle(color: Color.fromARGB(255, 158, 53, 174)),),
                    ),
 
              ],
            ),
          )
        ],
      ),
    );
  }
  
  Widget setCampoFecha() {
    
    if(destinoMascota=="adoptar"){
      return  TextFormField(
        controller: fechaMascotaC,
        decoration: const InputDecoration(
          icon: Icon(Icons.calendar_today),
          labelText: "Fecha de ingreso de la mascota",
        ),
        readOnly: true,
        onTap: () {
          _selectDate(context);
        },
      );
    }else{
      return  TextFormField(
        controller: fechaMascotaC,
        decoration: const InputDecoration(
          icon: Icon(Icons.calendar_today),
          labelText: "Fecha de cuando se perido la mascota",
        ),
        readOnly: true,
        onTap: () {
          _selectDate(context);
        },
      );
    }
  }
  
  Widget setTipoVacuna() {

    
  return  Column(
        children: [
          const Text('Vacuna contra Leptospirosis',style: TextStyle(fontSize: 18),),
          const Divider(
            height: 18.0,
          ),
          DropdownButton<bool>(
            value: selectValorVacunaLeptospirosis,
            items:  const [
              DropdownMenuItem(
                value: true,
                child: Text('Puesta'),
              ),
              DropdownMenuItem(
                value: false,
                child: Text('Pendiente'),
              ),
            ],
            onChanged: (bool? newValue) {
              setState(() {
                selectValorVacunaLeptospirosis = newValue!;
              });
            },
            hint:const  Text('Asigna un valor'),
          ),
          const SizedBox(height: 20,),
          const Text('Vacuna contra Rabia',style: TextStyle(fontSize: 18),),
          const SizedBox(height: 10,),
          DropdownButton<bool>(
            value: selectValorVacunaRabia,
            items: const [
              DropdownMenuItem(
                value: true,
                child: Text('Puesta'),
              ),
              DropdownMenuItem(
                value: false,
                child: Text('Pendiente'),
              ),
            ],
            onChanged: (bool? newValue) {
              setState(() {
                selectValorVacunaRabia = newValue!;
              });
            },

            hint:const  Text('Asigna un valor'),
          ),
          const Text('Vacuna contra Coronavirus',style: TextStyle(fontSize: 18),),
          const SizedBox(height: 10,),
          DropdownButton<bool>(
            value: selectValorVacunaCoronavirus,
            items: const [
              DropdownMenuItem(
                value: true,
                child: Text('Puesta'),
              ),
              DropdownMenuItem(
                value: false,
                child: Text('Pendiente'),
              ),
            ],
            onChanged: (bool? newValue) {
              setState(() {
                selectValorVacunaCoronavirus = newValue!;
              });
            },

            hint:const  Text('Asigna un valor'),
          ),
          const Text('Vacuna contra Peritonitis',style: TextStyle(fontSize: 18),),
          const SizedBox(height: 10,),
          DropdownButton<bool>(
            value: selectValorVacunaPeritonitis,
            items: const [
              DropdownMenuItem(
                value: true,
                child: Text('Puesta'),
              ),
              DropdownMenuItem(
                value: false,
                child: Text('Pendiente'),
              ),
            ],
            onChanged: (bool? newValue) {
              setState(() {
                selectValorVacunaPeritonitis = newValue!;
              });
            },

            hint:const  Text('Asigna un valor'),
          ),
          const Text('Vacuna contra Calcivirus',style: TextStyle(fontSize: 18),),
          const SizedBox(height: 10,),
          DropdownButton<bool>(
            value: selectValorVacunaCalcivirus,
            items: const [
              DropdownMenuItem(
                value: true,
                child: Text('Puesta'),
              ),
              DropdownMenuItem(
                value: false,
                child: Text('Pendiente'),
              ),
            ],
            onChanged: (bool? newValue) {
              setState(() {
                selectValorVacunaCalcivirus = newValue!;
              });
            },

            hint:const  Text('Asigna un valor'),
          ),
          
        ],
      );
    
    
  }
  
  

}



