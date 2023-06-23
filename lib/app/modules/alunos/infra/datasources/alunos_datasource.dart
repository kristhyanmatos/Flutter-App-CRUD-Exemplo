abstract class IAlunosDataSource {
  Future<void> cadastar(Map<String, dynamic> map);
  Future<void> atualizar(String alunoId, Map<String, dynamic> map);
  Future<List<Map<String, dynamic>>> buscarTodos();
  Future<void> atualizarStatus(String alunoId, bool isAtivo);
}
