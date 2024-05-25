import 'dart:convert';
import 'package:long_text_translator_gpt/model/translation_note/translation_note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:long_text_translator_gpt/repository/SettingsRepository.dart';
import 'package:uuid/uuid.dart';

class TranslationNoteListItem {
  final String title;
  final String id;

  TranslationNoteListItem({
    required this.title,
    required this.id,
  });

  TranslationNoteListItem copyWith({
    String? title,
    String? id,
  }) {
    return TranslationNoteListItem(
      title: title ?? this.title,
      id: id ?? this.id,
    );
  }
}

class TranslationNoteRepository {
  late final SettingsRepository _settingsRepository;

  TranslationNoteRepository(
    this._settingsRepository,
  );

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join((_settingsRepository.settings).workingDirectory,
        'translation_notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE translation_note (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        data TEXT NOT NULL
      )
    ''');
  }

  Future<List<TranslationNoteListItem>> getTranslationNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'translation_note',
      columns: ['id', 'title'], // Exclude 'content'
    );

    return List.generate(maps.length, (i) {
      return TranslationNoteListItem(
        id: maps[i]['id'],
        title: maps[i]['title'],
      );
    });
  }

  Future<TranslationNote> createTranslationNote({
    required String title,
    required TranslationNote note,
  }) async {
    final db = await database;
    var uuid = const Uuid();
    String id = uuid.v4();
    await db.insert(
      'translation_note',
      {
        'id': id,
        'title': title,
        'data': jsonEncode(note.toJson()),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return note.copyWith(id: id, title: title);
  }

  Future<void> renameTranslationNote({
    required String id,
    required String newTitle,
  }) async {
    final db = await database;
    await db.update(
      'translation_note',
      {'title': newTitle},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> saveTranslationNote({
    required String id,
    required TranslationNote note,
  }) async {
    final db = await database;
    await db.update(
      'translation_note',
      {'data': jsonEncode(note.toJson())},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTranslationNote({
    required String id,
  }) async {
    final db = await database;
    await db.delete(
      'translation_note',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<TranslationNote?> getTranslationNoteById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'translation_note',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      final note = TranslationNote.fromJson(
        jsonDecode(maps[0]['data']),
      ).copyWith(id: maps[0]['id'], title: maps[0]['title']);

      return note;
    } else {
      return null; // Return null if no note is found
    }
  }
}
