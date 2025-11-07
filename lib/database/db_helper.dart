import 'package:sqflite/sqflite.dart';
import 'package:pramov2_ao1_barella/model/contacto.dart';

class DbHelper {
  static Database? _database;
  static const _dbName = 'contactos.db';
  static const _dbVersion = 1;
  static const _tableName = 'contactos';

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = await getDatabasesPath() + _dbName;
    
    print('Database path: $path'); // DEBUGGING 

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            apellido TEXT NOT NULL,
            telefono TEXT NOT NULL,
            email TEXT NOT NULL,
            genero TEXT NOT NULL
          )
        ''');
      },
    );
  }

  static Future<int> insertarContacto(Contacto contacto) async {
    final db = await database;
    return await db.insert(_tableName, contacto.toMap());
  }

  static Future<List<Contacto>> obtenerContactos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return Contacto(
        id: maps[i]['id'],
        nombre: maps[i]['nombre'],
        apellido: maps[i]['apellido'],
        telefono: maps[i]['telefono'],
        domicilio: maps[i]['domicilio'],
        genero: maps[i]['genero'],
      );
    });
  }

  static Future<int> eliminarContacto(int id) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> actualizarContacto(Contacto contacto) async {
    final db = await database;
    return await db.update(
      _tableName,
      contacto.toMap(),
      where: 'id = ?',
      whereArgs: [contacto.id],
    );
  }
}