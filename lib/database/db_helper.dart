import 'package:sqflite/sqflite.dart';
import 'package:pramov2_ao1_barella/model/contacto.dart';

class DbHelper {
  static Database? _database;
  static const _dbName = 'contactos.db';
  static const _dbVersion = 2;
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
            domicilio TEXT NOT NULL,
            genero TEXT NOT NULL,
            email TEXT,
            fechaNacimiento TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Añadir columnas nuevas en migraciones futuras
        if (oldVersion < 2) {
          try {
            await db.execute('ALTER TABLE $_tableName ADD COLUMN email TEXT');
          } catch (e) {
            // ignorar si ya existe
          }
          try {
            await db.execute('ALTER TABLE $_tableName ADD COLUMN fechaNacimiento TEXT');
          } catch (e) {
            // ignorar si ya existe
          }
        }
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
        email: maps[i]['email']?.toString(),
        fechaNacimiento: maps[i]['fechaNacimiento']?.toString(),
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
    if (contacto.id == null) return 0;
    return await db.update(
      _tableName,
      contacto.toMap(),
      where: 'id = ?',
      whereArgs: [contacto.id],
    );
  }
}