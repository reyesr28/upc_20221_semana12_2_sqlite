import 'package:flutter/material.dart';
import 'package:upc_20221_semana12_2_sqlite/Modelo/usuario.dart';
import 'package:upc_20221_semana12_2_sqlite/databases/db.dart';

import 'nuevo.dart';

class vista extends StatefulWidget {
  const vista({Key? key}) : super(key: key);

  @override
  _vistaState createState() => _vistaState();
}

class _vistaState extends State<vista> {

  late Future<List<Usuario>> lista;

  @override
  void initState() {
    super.initState();
    DB().initializeDB().whenComplete(() async{
      setState(() {
        lista=DB().listUser();
      });
    });
  }

  Future<void> actualizarLista() async{
    setState(() {
      lista=DB().listUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Lista de Usuarios'),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=>nuevo()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),

      body: FutureBuilder<List<Usuario>>(
        future: lista,
        builder: (BuildContext context, AsyncSnapshot<List<Usuario>> snapshot){
          if(snapshot.hasError){
            return new Text('Error: ${snapshot.error}');
          }else{
            final items=snapshot.data??<Usuario>[];
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index){
                  return Dismissible(
                      direction: DismissDirection.startToEnd,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.delete_forever),
                      ),
                      key: ValueKey<int>(items[index].id),
                      onDismissed: (DismissDirection direction) async{
                        await DB().deleteUser(items[index].id);
                          setState(() {
                            items.remove(items[index]);
                          });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width*1,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Codigo: "+items[index].id.toString()),
                                Text("Nombre: "+items[index].nombre),
                                Text("Correo: "+items[index].correo),
                              ],
                            ),
                          ),
                        ),
                      )
                  );
                },
            );
          }
        },
      ),


    );
  }
}
