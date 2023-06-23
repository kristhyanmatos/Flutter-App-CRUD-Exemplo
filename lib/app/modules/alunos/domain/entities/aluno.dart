class Aluno {
  late String? id;
  late String nome;
  late String observacao;
  late String telefone;
  late String email;
  late String senha;
  late num valorMensalidade;
  late bool isAtivo;

  Aluno({
    required this.id,
    required this.nome,
    required this.observacao,
    required this.telefone,
    required this.email,
    required this.senha,
    required this.valorMensalidade,
    required this.isAtivo,
  });

  Aluno.init() {
    id = null;
    nome = "";
    observacao = "";
    telefone = "";
    email = "";
    senha = "";
    valorMensalidade = 0;
    isAtivo = true;
  }

  Aluno.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    nome = map["nome"] ?? "";
    observacao = map["observacao"] ?? "";
    telefone = map["telefone"] ?? "";
    email = map["email"] ?? "";
    senha = map["senha"] ?? "";
    valorMensalidade = map["valor_mensalidade"] ?? 0;
    isAtivo = map["is_ativo"] ?? false;
  }

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "observacao": observacao,
      "telefone": telefone,
      "email": email,
      "senha": senha,
      "valor_mensalidade": valorMensalidade,
      "is_ativo": isAtivo,
    };
  }

  void setNome(String value) {
    nome = value;
  }

  void setTelefone(String value) {
    telefone = value;
  }

  void setEmail(String value) {
    email = value;
  }

  void setSenha(String value) {
    senha = value;
  }

  void setMensalidade(num value) {
    valorMensalidade = value;
  }

  void setObservacao(String value) {
    observacao = value;
  }
}
