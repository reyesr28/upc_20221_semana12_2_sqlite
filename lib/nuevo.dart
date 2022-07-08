import 'package:flutter/material.dart';
import 'package:upc_20221_semana12_2_sqlite/Modelo/usuario.dart';
import 'package:upc_20221_semana12_2_sqlite/databases/db.dart';
import 'package:upc_20221_semana12_2_sqlite/vista.dart';


class nuevo extends StatefulWidget {
  const nuevo({Key? key}) : super(key: key);

  @override
  _nuevoState createState() => _nuevoState();
}

class _nuevoState extends State<nuevo> {

  int codigo=0;
  String nombre="";
  String correo="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title:Text('Nuevos Usuarios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [

            TextFormField(
              decoration: InputDecoration(
                hintText: 'Codigo',
              ),
              onChanged: (value){
                setState(() {
                  codigo=int.parse(value);
                });
              },
            ),


            TextFormField(
              decoration: InputDecoration(
                hintText: 'Nombre',
              ),
              onChanged: (value){
                setState(() {
                  nombre=value;
                });
              },
            ),

            TextFormField(
              decoration: InputDecoration(
                hintText: 'Correo',
              ),
              onChanged: (value){
                setState(() {
                  correo=value;
                });
              },
            ),

            ElevatedButton(onPressed: () async{
              await DB().insertUser(Usuario(id:codigo, nombre: nombre, correo: correo))
                  .whenComplete(() => Navigator.push(context,
              MaterialPageRoute(builder: (context)=>vista())));
            }, child: Text('Grabar Usuario')),


          ],
        ),
      ),

    );
  }
}
