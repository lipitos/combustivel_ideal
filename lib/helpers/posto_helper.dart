import 'package:combustivel_ideal/model/posto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class PostoHelper{
  static final PostoHelper _instance = PostoHelper.internal();

  PostoHelper.internal();

  factory PostoHelper() => _instance;

  Database _db;

  //Se o banco não existir, realiza a iniciação
  Future<Database> get db async{
    if(_db != null){
      return _db;
    }else{
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async{
    final path = await getDatabasesPath();
    final pathDB = join(path, "posto.db");

    final String sql = "CREATE TABLE posto ("
                      "c_id INTEGER PRIMARY KEY,"
                      "c_nome TEXT,"
                      "c_alcool TEXT,"
                      "c_gasolina TEXT,"
                      "c_data TEXT"
                      ")";

    return await openDatabase(
        pathDB,
        version: 1,
        onCreate: (Database db, int newerVersion) async {
          await db.execute(sql);
        }
    );

  }

  //Create
  Future<Posto> insert (Posto posto) async{
    Database dbPosto = await db;
    posto.id = await dbPosto.insert("posto", posto.toMap());
    return posto;
  }

  //Read
  Future<Posto> selectById(int id) async{
    Database dbPosto = await db;
    List<Map> maps = await dbPosto.query(
      "posto",
      columns:[
        "c_id", "c_nome", "c_alcool", "c_gasolina", "c_data"
      ],
      where: "c_id = ?",
      whereArgs: [id]
    );
    if(maps.length > 0){
      return Posto.fromMap(maps.first);
    }else{
      return null;
    }
  }

  //List
  Future<List> selectAll() async{
    Database dbPosto = await db;
    List list = await dbPosto.rawQuery("SELECT * FROM posto");
    List<Posto> lsPosto = List();
    for(Map m in list){
      lsPosto.add(Posto.fromMap(m));
    }
    return lsPosto;
  }

  //Update
  Future<int> update (Posto posto) async {
    Database dbPosto = await db;
    return await dbPosto.update("posto", posto.toMap(), where: "c_id = ?", whereArgs: [posto.id]);
  }

  //Delete
  Future<int> delete(int id) async{
    Database dbPosto = await db;
    return await dbPosto.delete("posto", where: "c_id = ?", whereArgs: [id]);
  }

  Future close() async{
    Database dbPosto = await db;
    dbPosto.close();
  }
}