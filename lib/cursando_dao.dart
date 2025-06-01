import 'package:actividad3/database_helper.dart';
import 'package:actividad3/cursando.dart';
import 'package:sqflite/sqflite.dart';

class CursandoDao {
  final Databasehelper _dbHelper = Databasehelper();

  
  Future<void> incluirCursando(Cursando c) async {
    final db = await _dbHelper.database;
    await db.insert(
      "cursando",
      c.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  
  Future<void> deleteCursando(int estudanteId, int disciplinaId) async {
    final db = await _dbHelper.database;
    await db.delete(
      "cursando",
      where: "estudante_id = ? AND disciplina_id = ?",
      whereArgs: [estudanteId, disciplinaId],
    );
  }

  

  
  Future<List<Map<String, dynamic>>> listarCursando() async {
    final db = await _dbHelper.database;
    return await db.rawQuery('''
      SELECT 
        estudante.id as estudante_id,
        estudante.nome as estudante_nome,
        disciplina.id as disciplina_id,
        disciplina.nome as disciplina_nome,
        disciplina.professor
      FROM cursando
      INNER JOIN estudante ON cursando.estudante_id = estudante.id
      INNER JOIN disciplina ON cursando.disciplina_id = disciplina.id
    ''');
  }


}






  




