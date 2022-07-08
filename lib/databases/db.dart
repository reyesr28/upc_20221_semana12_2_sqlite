import 'package:upc_20221_semana12_2_sqlite/Modelo/usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB{

  Future<Database> initializeDB() async{
    String path=await getDatabasesPath();
    return openDatabase(
      join(path,'dbusers'),
      onCreate: (database,version) async{
        await database.execute(
          'CREATE TABLE usuarios(id INTEGER PRIMARY KEY, nombre TEXT, correo TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertUser(Usuario usu) async{
    final db=await initializeDB();
    await db.insert('usuarios', usu.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteUser(int id) async{
    final db=await initializeDB();
    await db.delete('usuarios',where: 'id=?',whereArgs: [id]);
  }

  Future<List<Usuario>> listUser() async{
    final db=await initializeDB();
    final List<Map<String, dynamic>> query=await db.query('usuarios');
    return query.map((e) => Usuario.fromMap(e)).toList();
  }
}