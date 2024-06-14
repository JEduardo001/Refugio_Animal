import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class administrarMascota extends StatefulWidget {

  final String image;
  final String nombre;
  final String edad;
  final String raza;
  final String fecha;
  final String id;
  final String tipoMascota;
  final String ubicacion;




  administrarMascota(
    {
      required this.image, 
      required this.nombre, 
      required this.edad,
      required this.raza,
      required this.fecha,
      required this.id,
      required this.tipoMascota,
      required this.ubicacion,


    }
  );

  @override
  State<administrarMascota> createState() => _administrarMascotaState(nombre: nombre,id:id,image: image,edad: edad,fecha: fecha,raza: raza,tipoMascota: tipoMascota,ubicacion: ubicacion);
}

class _administrarMascotaState extends State<administrarMascota> {

  TextEditingController nombreMascotaC = TextEditingController();
  TextEditingController razaMascotaC = TextEditingController();
  TextEditingController edadMascotaC = TextEditingController();
  TextEditingController fechaMascotaC = TextEditingController();

  String image;
  final String nombre;
  final String edad;
  final String raza;
  final String fecha;
  final String id;
  final String tipoMascota;
  final String ubicacion;

  bool selectValorSignosMaltrato = false;
  bool selectValorVacunaRabia= false;
  bool selectValorVacunaLeptospirosis= false;
  bool selectValorVacunaCoronavirus= false;
  bool selectValorVacunaPeritonitis= false;
  bool selectValorVacunaCalcivirus= false;

  _administrarMascotaState(
    {
      required this.image, 
      required this.nombre, 
      required this.edad,
      required this.raza,
      required this.fecha,
      required this.id,
      required this.tipoMascota,
      required this.ubicacion,
  

    }
  );
  //File? imageSelecionada;
  Uint8List? bytes;
  Uint8List? compressedBytes;
  String? base64String;

  Future<void> _pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      final XFile? imageBinaria = pickedFile;
      if(pickedFile!=null){
        bytes = await File(imageBinaria!.path).readAsBytes();
        base64String = base64Encode(bytes!);
        
        setState(() {
          image= base64String! ;
          //imageSelecionada = File(pickedFile.path);
          //print('es diferente... $image');

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
  void initState() {
    super.initState();
   
    // Inicializa el controlador con el valor de 'raza' pasado como parámetro
    razaMascotaC = TextEditingController(text: raza);
    nombreMascotaC = TextEditingController(text: nombre);
    edadMascotaC = TextEditingController(text: edad);
    fechaMascotaC = TextEditingController(text: fecha);

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrar Mascota'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 200,
                    child:  ClipRRect(
                      borderRadius: BorderRadius.circular(20), 
                      child: decifrarImage(imagen: image)
                    ),
                  ),
                  ElevatedButton(
                      onPressed: _pickImage,
                      child: const Text('Seleccionar Imagen'),
                  ),

                ],
              ),
              const SizedBox(height: 10,),
              Text('Id de mascota : $id'),
              const SizedBox(height: 10,),
              Text('Tipo Mascota : $tipoMascota'),
              const SizedBox(height: 10,),
              Text('Ubicación: $ubicacion'),
              const SizedBox(height: 10,),
              const Text("Modifica sus datos",style: TextStyle(color: Color.fromARGB(255, 0, 0, 0),fontSize: 20)),
              const SizedBox(height: 10,),
              const Text('Nombre tutor:',style: TextStyle(fontSize: 17),),
              const SizedBox(height: 10),
              TextField(
                controller:  nombreMascotaC,
                enableInteractiveSelection: false,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  hintText: 'Nombre',
                  labelText: nombre,
                  suffixIcon: const  Icon(
                    Icons.verified_user
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  )
                ),             
              ),
              const SizedBox(height: 10,),
              const Text('Raza:',style: TextStyle(fontSize: 17),),
              const Divider(
                height: 18.0,
              ),
              TextField(
                controller:  razaMascotaC,
                enableInteractiveSelection: false,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  hintText: 'Raza',
                  labelText: raza,
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
              const SizedBox(height: 10,),
              const Text('Edad:',style: TextStyle(fontSize: 17),),
              const Divider(
                height: 18.0,
              ),
              TextField(
                controller:  edadMascotaC,
                enableInteractiveSelection: false,
                textCapitalization: TextCapitalization.characters,
               
                decoration: InputDecoration(
                  hintText: 'Edad',
                  labelText: edad,
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
              const Divider(
                height: 18.0,
              ),
              Text(setText()),
              TextFormField(
                controller: fechaMascotaC,
                decoration:  InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  labelText: fecha,
                ),
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: guardarCambios,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0), backgroundColor:const Color.fromARGB(255, 238, 170, 255), shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0), 
                      ),
                      minimumSize: const Size(10.0, 30.0), 
                      padding: const EdgeInsets.symmetric(horizontal: 16.0), 
                    ),
                    child: const Text('Guardar Cambios'),
                  ),
                 const Spacer(),
                 ElevatedButton(
                  onPressed: borrarMascota,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 0, 0, 0), backgroundColor: const Color.fromARGB(255, 248, 227, 253), shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), 
                    ),
                    minimumSize: const Size(10.0, 30.0), 
                    padding: const EdgeInsets.symmetric(horizontal: 16.0), 
                  ),
                  child: const Text('Borrar Mascota', style: TextStyle(color: Color.fromARGB(255, 241, 80, 80)),),
                ),

                ],
              )

            ],
          ),
        )
      )
    
    );
  }

  String setText() {
    String text;
    if(ubicacion=='gatosAdopcion' || ubicacion=='perrosAdopcion'){
      text='Fecha de cuando se ingreso la mascota';
    }else{
      text='Fecha de cuando se perido la mascota';

    }
    return text;
  }

  void _showAlertDialog(BuildContext context,var textAviso) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:const Text('Aviso'),
            content:  Text(textAviso),
            actions: <Widget>[
              TextButton(
                child:const  Text('Aceptar'),
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

 

  guardarCambios() async {
     // URL de la API
    const String apiUrl = 'https://api-refugio-animal.onrender.com';
    
    const String endpoint = '/ActualizarMascota';

    //preparamos los datos que se enviaran hacia el endpoint 
    final Map<String, dynamic> requestBody = {
      'nombre': nombreMascotaC.text,
      'edad': edadMascotaC.text,
      'raza': razaMascotaC.text,
      'imagen': image,
      'fecha': fechaMascotaC.text,
      'tipoMascota': tipoMascota,
      'ubicacion': ubicacion,
      'id': id,
      'signosMaltrato': selectValorSignosMaltrato,
      'vacunaRabia': selectValorVacunaRabia,
      'vacunaLeptospirosis': selectValorVacunaLeptospirosis,
      'vacunaCoronavirus': selectValorVacunaCoronavirus,
      'vacunaPeritonitis': selectValorVacunaPeritonitis,
      'vacunaCalcivirus': selectValorVacunaCalcivirus,
    };

    final response = await http.post(
      Uri.parse('$apiUrl$endpoint'),
      headers: {'Content-Type': 'application/json'}, // Especifica el tipo de contenido como JSON
      body: jsonEncode(requestBody), // Codifica los parametros como JSON
    );
    print(jsonEncode(requestBody));

    if (response.statusCode == 200) {
      _showAlertDialog(context,'Mascota modificada correctamente');

      print('Respuesta de la API: ${response.body}');
    } else {
      print('Error al modificar la mascota: ${response.reasonPhrase}');
    }

  }
  
  borrarMascota()async {
     const String apiUrl = 'https://api-refugio-animal.onrender.com';
    
    const String endpoint = '/BorrarMascota';

    final Map<String, dynamic> requestBody = {
      'tipoMascota': tipoMascota,
      'ubicacion': ubicacion,
      'id': id
    };

    final response = await http.delete(
      Uri.parse('$apiUrl$endpoint'),
      headers: {'Content-Type': 'application/json'}, // Especifica el tipo de contenido como JSON
      body: jsonEncode(requestBody), // Codifica los parámetros como JSON
    );
    print(jsonEncode(requestBody));

    if (response.statusCode == 200) {
      _showAlertDialog(context,'Mascota eliminada correctamente');

      print('Respuesta de la API: ${response.body}');
    } else {
      print('Error al eliminar la mascota: ${response.reasonPhrase}');
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

Image decifrarImage({required imagen}){
 //pasamos la imagen a base64
  Uint8List imageData = base64Decode(imagen);
    // Crear una imagen a partir de los datos binarios
  Image image = Image.memory(imageData);
  return image;
}