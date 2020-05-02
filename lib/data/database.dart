import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:prizey_vendor/models/queryModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final queryTable = 'queries';
  static final _databaseName = 'Query_DB';
  String productId = 'product_id';
  String queryId = 'query_id';
  String productName = 'product_name';
  String categoryId = 'category_id';
  QueryModel queryModel;
  String primaryKey = 'id';
  // DatabaseHelper._createInstance({this.queryModel});

  DatabaseHelper._createInstance();

  static DatabaseHelper _databaseHelper;
  static Database _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }

    return _database;
  }

  _initDatabase() async {
    Directory queryDirectory = await getApplicationDocumentsDirectory();
    String path = join(queryDirectory.path, _databaseName);
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  void _onCreate(Database database, int version) async {
    await database.execute('''CREATE TABLE $queryTable(
        $queryId TEXT PRIMARY KEY,
        $productId TEXT NOT NULL,
        $productName TEXT,
        $categoryId TEXT
      )''');
  }

  Future<List<Map<String, dynamic>>> _getQueriesMapList() async {
    Database db = await this.database;

    var result = db.rawQuery('SELECT * FROM $queryTable');

    return result;
  }

  Future insertQuery(QueryModel queryModel) async {
    bool proceed = await checkExistQuery(queryModel.queryId);
    if (proceed) {
      Database db = await this.database;
      var queryMap = queryModel.toMap();
      // print('queryMap : $queryMap');
      var result = db.insert(queryTable, queryMap);
      return result;
    } else {
      return null;
    }
  }

  Future deleteQuery(String queryId) async {
    Database db = await this.database;
    var result = db
        .rawDelete('DELETE FROM $queryTable WHERE ${this.queryId} = $queryId');

    return result;
  }

  Future<bool> checkExistQuery(String queryId) async {
    Database db = await this.database;
    var result =
        db.rawQuery('SELECT FROM $queryTable WHERE ${this.queryId} = $queryId');

    if (result == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<QueryModel>> getQueriesList() async {
    var queryMapList = await _getQueriesMapList();

    int count = queryMapList.length;

    List<QueryModel> queriesList = List<QueryModel>();

    for (int i = 0; i < count; i++) {
      queriesList.add(QueryModel.fromMapObject(queryMapList[i]));
    }

    return queriesList;
  }
}
