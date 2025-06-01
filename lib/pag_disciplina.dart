import 'package:actividad3/disciplina.dart';
import 'package:actividad3/disciplina_dao.dart';
import 'package:flutter/material.dart';

class PagDisciplina extends StatefulWidget {
  const PagDisciplina({super.key});

  @override
  State<PagDisciplina> createState() => _PagDisciplinaState();
}

class _PagDisciplinaState extends State<PagDisciplina> {
  final _disciplinaDAO = DisciplinaDao();
  Disciplina? _disciplinaAtual;

  final _controllerNome = TextEditingController();
  final _controllerProfessor = TextEditingController();
  List<Disciplina> _listaDisciplinas = [];

  @override
  void initState() {
    _loadDisciplinas();
    super.initState();
  }

  _loadDisciplinas() async {
    List<Disciplina> temp = await _disciplinaDAO.listarDisciplinas();
    setState(() {
      _listaDisciplinas = temp;
    });
  }

  _salvarOUEditar() async {
    if (_disciplinaAtual == null) {
      await _disciplinaDAO.incluirDisciplina(Disciplina(
        nome: _controllerNome.text,
        professor: _controllerProfessor.text,
      ));
    } else {
      _disciplinaAtual!.nome = _controllerNome.text;
      _disciplinaAtual!.professor = _controllerProfessor.text;
      await _disciplinaDAO.editarDisciplina(_disciplinaAtual!);
    }

    _controllerNome.clear();
    _controllerProfessor.clear();
    setState(() {
      _loadDisciplinas();
      _disciplinaAtual = null;
    });
  }

  _apagarDisciplina(int index) async {
    await _disciplinaDAO.deletarDisciplina(index);
    _loadDisciplinas();
  }

  _editarDisciplina(Disciplina d) async {
    await _disciplinaDAO.editarDisciplina(d);
    _loadDisciplinas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD Disciplina"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controllerNome,
              decoration: InputDecoration(
                labelText: "Nome da Disciplina",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controllerProfessor,
              decoration: InputDecoration(
                labelText: "Professor",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                _salvarOUEditar();
              },
              child:
                  _disciplinaAtual == null ? Text("Salvar") : Text("Atualizar"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _listaDisciplinas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_listaDisciplinas[index].nome),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Professor: ${_listaDisciplinas[index].professor}"),
                      Text(
                          "ID: ${_listaDisciplinas[index].id}"), 
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      _apagarDisciplina(_listaDisciplinas[index].id!);
                    },
                    icon: Icon(Icons.delete),
                  ),
                  onTap: () {
                    setState(() {
                      _disciplinaAtual = _listaDisciplinas[index];
                      _controllerNome.text = _disciplinaAtual!.nome;
                      _controllerProfessor.text = _disciplinaAtual!.professor;
                      _editarDisciplina(_disciplinaAtual!);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
