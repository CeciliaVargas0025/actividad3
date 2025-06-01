import 'package:actividad3/estudante.dart';
import 'package:actividad3/estudante_dao.dart';
import 'package:flutter/material.dart';

class Pag1 extends StatefulWidget {
  const Pag1({super.key});

  @override
  State<Pag1> createState() => _Pag1State();
}

class _Pag1State extends State<Pag1> {
  final _estudanteDAO = EstudanteDao();
  Estudante? _estudanteAtual;

  final _controllerNome = TextEditingController();
  final _controllerMatricula = TextEditingController();
  List<Estudante> _listaEstudantes = [];

  @override
  void initState() {
    _loadEstudantes();
    super.initState();
  }

  _loadEstudantes() async {
    List<Estudante> temp = await _estudanteDAO.listarEstudantes();
    setState(() {
      _listaEstudantes = temp;
    });
  }

  _salvarOUEditar() async {
    if (_estudanteAtual == null) {
      
      await _estudanteDAO.incluirEstudante(Estudante(
          nome: _controllerNome.text, matricula: _controllerMatricula.text));
    } else {
      
      _estudanteAtual!.nome = _controllerNome.text;
      _estudanteAtual!.matricula = _controllerMatricula.text;
      await _estudanteDAO.editarEstudante(_estudanteAtual!);
    }
    _controllerNome.clear();
    _controllerMatricula.clear();
    setState(() {
      _loadEstudantes();
      _estudanteAtual = null;
    });
  }

  _apagarEstudante(int index) async {
    await _estudanteDAO.deleteEstudante(index);
    _loadEstudantes();
  }

  _editarEstudante(Estudante e) async {
    await _estudanteDAO.editarEstudante(e);
    _loadEstudantes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD Estudante"),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controllerNome,
              decoration: InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controllerMatricula,
              decoration: InputDecoration(
                labelText: "Matricula",
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
                  _estudanteAtual == null ? Text("Salvar") : Text("Atualizar"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _listaEstudantes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_listaEstudantes[index].nome),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Matrícula: ${_listaEstudantes[index].matricula}"),
                      Text(
                          "ID: ${_listaEstudantes[index].id}"), 
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      _apagarEstudante(_listaEstudantes[index].id!);
                    },
                    icon: Icon(Icons.delete),
                  ),
                  onTap: () {
                    setState(() {
                      _estudanteAtual = _listaEstudantes[index];
                      _controllerNome.text = _estudanteAtual!.nome;
                      _controllerMatricula.text = _estudanteAtual!.matricula;
                      _editarEstudante(_estudanteAtual!);
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
