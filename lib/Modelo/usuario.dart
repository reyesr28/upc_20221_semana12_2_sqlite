class Usuario{

  int id;
  String nombre;
  String correo;

  Usuario({
   required this.id,
   required this.nombre,
   required this.correo,
  });

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'nombre':nombre,
      'correo':correo
    };
  }

  Usuario.fromMap(Map<String, dynamic> res):
      id=res["id"],
      nombre=res["nombre"],
      correo=res["correo"];

}