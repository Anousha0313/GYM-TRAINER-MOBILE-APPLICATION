import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'fitness_tracker.db');
    return await openDatabase(
      path,
      version: 3, // Increased version for new tables
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Original progress table
    await db.execute('''
      CREATE TABLE progress(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        trainer TEXT,
        exercise TEXT,
        duration INTEGER,
        date TEXT
      )
    ''');

    // New video progress table
    await db.execute('''
      CREATE TABLE video_progress(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT,
        trainer TEXT,
        exercise TEXT,
        videoUrl TEXT,
        progressPercent INTEGER,
        watchedDuration INTEGER,
        totalDuration INTEGER,
        isCompleted INTEGER,
        lastWatched TEXT,
        createdAt TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // New workout progress table
    await db.execute('''
      CREATE TABLE workout_progress(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT,
        trainer TEXT,
        exercise TEXT,
        completionPercent INTEGER,
        status TEXT,
        duration INTEGER,
        date TEXT,
        createdAt TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // User table for managing users
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT UNIQUE,
        name TEXT,
        email TEXT,
        createdAt TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE video_progress(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          userId TEXT,
          trainer TEXT,
          exercise TEXT,
          videoUrl TEXT,
          progressPercent INTEGER,
          watchedDuration INTEGER,
          totalDuration INTEGER,
          isCompleted INTEGER,
          lastWatched TEXT,
          createdAt TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      await db.execute('''
        CREATE TABLE workout_progress(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          userId TEXT,
          trainer TEXT,
          exercise TEXT,
          completionPercent INTEGER,
          status TEXT,
          duration INTEGER,
          date TEXT,
          createdAt TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');
    }

    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          userId TEXT UNIQUE,
          name TEXT,
          email TEXT,
          createdAt TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');
    }
  }

  // Original methods
  Future<int> insertProgress(Map<String, dynamic> progress) async {
    final db = await database;
    return await db.insert('progress', progress);
  }

  Future<List<Map<String, dynamic>>> getProgress() async {
    final db = await database;
    return await db.query('progress');
  }

  // New video progress methods
  Future<int> insertVideoProgress(Map<String, dynamic> videoProgress) async {
    final db = await database;

    // Check if record exists for this user, exercise, and video
    final existing = await db.query(
      'video_progress',
      where: 'userId = ? AND exercise = ? AND videoUrl = ?',
      whereArgs: [
        videoProgress['userId'],
        videoProgress['exercise'],
        videoProgress['videoUrl']
      ],
    );

    if (existing.isNotEmpty) {
      // Update existing record
      return await db.update(
        'video_progress',
        videoProgress,
        where: 'userId = ? AND exercise = ? AND videoUrl = ?',
        whereArgs: [
          videoProgress['userId'],
          videoProgress['exercise'],
          videoProgress['videoUrl']
        ],
      );
    } else {
      // Insert new record
      return await db.insert('video_progress', videoProgress);
    }
  }

  Future<List<Map<String, dynamic>>> getVideoProgress(String userId) async {
    final db = await database;
    return await db.query(
      'video_progress',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'lastWatched DESC',
    );
  }

  Future<Map<String, dynamic>?> getVideoProgressForExercise(String userId,
      String exercise, String videoUrl) async {
    final db = await database;
    final result = await db.query(
      'video_progress',
      where: 'userId = ? AND exercise = ? AND videoUrl = ?',
      whereArgs: [userId, exercise, videoUrl],
      limit: 1,
    );

    return result.isNotEmpty ? result.first : null;
  }

  // New workout progress methods
  Future<int> insertWorkoutProgress(
      Map<String, dynamic> workoutProgress) async {
    final db = await database;

    // Check if record exists for this user and exercise today
    final today = DateTime.now().toIso8601String().split('T')[0];
    final existing = await db.query(
      'workout_progress',
      where: 'userId = ? AND exercise = ? AND date LIKE ?',
      whereArgs: [
        workoutProgress['userId'],
        workoutProgress['exercise'],
        '$today%'
      ],
    );

    if (existing.isNotEmpty) {
      // Update existing record
      return await db.update(
        'workout_progress',
        workoutProgress,
        where: 'userId = ? AND exercise = ? AND date LIKE ?',
        whereArgs: [
          workoutProgress['userId'],
          workoutProgress['exercise'],
          '$today%'
        ],
      );
    } else {
      // Insert new record
      return await db.insert('workout_progress', workoutProgress);
    }
  }

  Future<List<Map<String, dynamic>>> getWorkoutProgress(String userId) async {
    final db = await database;
    return await db.query(
      'workout_progress',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'date DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getTodayWorkoutProgress(
      String userId) async {
    final db = await database;
    final today = DateTime.now().toIso8601String().split('T')[0];

    return await db.query(
      'workout_progress',
      where: 'userId = ? AND date LIKE ?',
      whereArgs: [userId, '$today%'],
      orderBy: 'completionPercent DESC',
    );
  }

  Future<Map<String, dynamic>> getWorkoutStats(String userId) async {
    final db = await database;

    // Total workouts
    final totalWorkouts = await db.rawQuery('''
      SELECT COUNT(*) as count FROM workout_progress 
      WHERE userId = ?
    ''', [userId]);

    // Completed workouts (>= 90%)
    final completedWorkouts = await db.rawQuery('''
      SELECT COUNT(*) as count FROM workout_progress 
      WHERE userId = ? AND completionPercent >= 90
    ''', [userId]);

    // Average completion rate
    final avgCompletion = await db.rawQuery('''
      SELECT AVG(completionPercent) as avg FROM workout_progress 
      WHERE userId = ?
    ''', [userId]);

    // This week's progress
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    final weekProgress = await db.query(
      'workout_progress',
      where: 'userId = ? AND date >= ?',
      whereArgs: [userId, weekAgo.toIso8601String()],
    );

    return {
      'totalWorkouts': totalWorkouts.first['count'] ?? 0,
      'completedWorkouts': completedWorkouts.first['count'] ?? 0,
      'averageCompletion': ((avgCompletion.first['avg'] ?? 0.0) as num).round(),
      'weeklyWorkouts': weekProgress.length,
    };
  } // ← closes getWorkoutStats

  // ------------------------
  // User management methods
  // ------------------------

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'userId = ?',
      whereArgs: [userId],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  // ------------------------
  // Utility methods
  // ------------------------

  Future<void> deleteAllProgress() async {
    final db = await database;
    await db.delete('progress');
    await db.delete('video_progress');
    await db.delete('workout_progress');
  }

  Future<void> deleteUserProgress(String userId) async {
    final db = await database;
    await db.delete('video_progress', where: 'userId = ?', whereArgs: [userId]);
    await db.delete('workout_progress', where: 'userId = ?', whereArgs: [userId]);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
