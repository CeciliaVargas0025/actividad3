class Cursando {
  int idEstudante;
  int idDisciplina;

  Cursando({required this.idEstudante, required this.idDisciplina});

  Map<String, dynamic> toMap() {
    return {
      "estudante_id": idEstudante,
      "disciplina_id": idDisciplina,
    };
  }

  factory Cursando.fromMap(Map<String, dynamic> map) {
  return Cursando(
    idEstudante: map['estudante_id'],
    idDisciplina: map['disciplina_id'],
  );
}

}
