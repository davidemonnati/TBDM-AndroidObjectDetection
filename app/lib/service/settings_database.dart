import 'package:app/entity/settings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SettingsDatabase {

  static Database? _database;

  SettingsDatabase() {
    _setupDb();
  }

  void _setupDb() async {
    _database = await openDatabase(
        join(await getDatabasesPath(), 'settings.db'),
        version: 1,
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE SERVICES(ID INTEGER PRIMARY KEY, DETECTION_IP TEXT, STORAGE_IP TEXT)'
          );
        }
    );
  }

  void saveSettings(Settings settings) async {
    _database!.insert(
      'SERVICES',
      settings.toMap(),
    );
  }

  Future<List<Settings>> readSettings() async {
    final List<Map<String, Object?>> settingsMap = await _database!.query(
        'SERVICES');

    return [
      for (final {
      'DETECTION_IP': detectionIp as String,
      'STORAGE_IP': storageIp as String,
      } in settingsMap)
        Settings(detectionIp: detectionIp, storageIp: storageIp),
    ];
  }

  Future<Settings> getLastAddress() async {
    List<Settings> settings = await readSettings();
    return settings.last;
  }
}
