import 'package:app/entity/settings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SettingsDatabase {
  static final SettingsDatabase instance = SettingsDatabase._internal();

  static Database? _database;

  SettingsDatabase._internal();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _setupDb();
    return _database;
  }

  Future<Database> _setupDb() async {
    return openDatabase(
        join(await getDatabasesPath(), 'settings.db'),
        version: 1,
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE SERVICES(ID INTEGER PRIMARY KEY, DETECTION_IP TEXT, STORAGE_IP TEXT)'
          );
        }
    );
  }

  Database? getDatabase() {
    return _database;
  }


  void saveSettings(Settings settings) async {
    _database?.insert(
      'services',
      settings.toMap(),
    );
  }

  void readSettings() async {
    final List<Map<String, Object?>>? settingsMap = await _database?.query(
        'services');
  }
}
