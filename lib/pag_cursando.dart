import 'package:actividad3/cursando.dart';
import 'package:actividad3/cursando_dao.dart';
import 'package:flutter/material.dart';

class PagCursando extends StatefulWidget {
  const PagCursando({super.key});

  @override
  State<PagCursando> createState() => _PagCursandoState();
}

class _PagCursandoState extends State<PagCursando> {
  final _cursandoDAO = CursandoDao();

  final _controllerIdEstudante = TextEditingController();
  final _controllerIdDisciplina = TextEditingController();

  
  List<Map<String, dynamic>> _listaCursando = [];

  @override
  void initState() {
    _loadCursando();
    super.initState();
  }

  _loadCursando() async {
    List<Map<String, dynamic>> resultado = await _cursandoDAO.listarCursando();
    setState(() {
      _listaCursando = resultado;
    });
  }

  _salvarCursando() async {
    await _cursandoDAO.incluirCursando(Cursando(
      idEstudante: int.parse(_controllerIdEstudante.text),
      idDisciplina: int.parse(_controllerIdDisciplina.text),
    ));

    _controllerIdEstudante.clear();
    _controllerIdDisciplina.clear();
    _loadCursando();
  }

  _apagarCursando(int idEstudante, int idDisciplina) async {
    await _cursandoDAO.deleteCursando(idEstudante, idDisciplina);
    _loadCursando();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cursando"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controllerIdEstudante,
              decoration: InputDecoration(
                labelText: "ID Estudante",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controllerIdDisciplina,
              decoration: InputDecoration(
                labelText: "ID Disciplina",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                _salvarCursando();
              },
              child: Text("Salvar"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _listaCursando.length,
              itemBuilder: (context, index) {
                final item = _listaCursando[index];
                return ListTile(
                  title: Text("Estudante: ${item['estudante_nome']}"),
                  subtitle: Text("Disciplina: ${item['disciplina_nome']}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _apagarCursando(item['estudante_id'], item['disciplina_id']);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
