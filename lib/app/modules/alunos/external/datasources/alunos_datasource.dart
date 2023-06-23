import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/domain/errors/failure.dart';
import '../../infra/datasources/alunos_datasource.dart';

class AlunosDataSource implements IAlunosDataSource {
  final FirebaseFirestore _firestore;

  AlunosDataSource(this._firestore);

  @override
  Future<void> cadastar(Map<String, dynamic> map) async {
    try {
      await _firestore.collection("aluno").add(map);
    } on FirebaseException catch (exception, stackTrace) {
      if (exception.message == null) {
        throw FailureUnknow(
          stackTrace: stackTrace,
          label: "AlunosDataSource-cadastar",
          exception: exception,
        );
      } else {
        throw Failure(
          exception.message!,
          exception: exception,
          label: "AlunosDataSource-cadastar",
          stackTrace: stackTrace,
        );
      }
    }
  }

  @override
  Future<void> atualizar(String alunoId, Map<String, dynamic> map) async {
    try {
      final colection = _firestore.collection("aluno");
      final response = await colection.doc(alunoId).get();
      if (response.exists) {
        await colection.doc(response.id).update(map);
      } else {
        throw Failure(
          "Aluno não encontrado",
          label: "AlunosDataSource-atualizar",
        );
      }
    } on FirebaseException catch (exception, stackTrace) {
      if (exception.message == null) {
        throw FailureUnknow(
          stackTrace: stackTrace,
          label: "AlunosDataSource-atualizar",
          exception: exception,
        );
      } else {
        throw Failure(
          exception.message!,
          exception: exception,
          label: "AlunosDataSource-atualizar",
          stackTrace: stackTrace,
        );
      }
    }
  }

  @override
  Future<void> atualizarStatus(String alunoId, bool isAtivo) async {
    try {
      final colection = _firestore.collection("aluno");
      final response = await colection.doc(alunoId).get();
      if (response.exists) {
        await colection.doc(response.id).update({
          "is_ativo": isAtivo,
        });
      } else {
        throw Failure(
          "Aluno não encontrado",
          label: "AlunosDataSource-atualizarStatus",
        );
      }
    } on FirebaseException catch (exception, stackTrace) {
      if (exception.message == null) {
        throw FailureUnknow(
          stackTrace: stackTrace,
          label: "AlunosDataSource-atualizarStatus",
          exception: exception,
        );
      } else {
        throw Failure(
          exception.message!,
          exception: exception,
          label: "AlunosDataSource-atualizarStatus",
          stackTrace: stackTrace,
        );
      }
    }
  }

  @override
  Future<List<Map<String, dynamic>>> buscarTodos() async {
    try {
      final colection = _firestore.collection("aluno");
      final snapshot = await colection.orderBy("nome").get();
      return snapshot.docs.map((e) {
        final data = e.data();
        data["id"] = e.id;
        data.remove("senha");
        return data;
      }).toList();
    } on FirebaseException catch (exception, stackTrace) {
      if (exception.message == null) {
        throw FailureUnknow(
          stackTrace: stackTrace,
          label: "AlunosDataSource-buscarTodos",
          exception: exception,
        );
      } else {
        throw Failure(
          exception.message!,
          exception: exception,
          label: "AlunosDataSource-buscarTodos",
          stackTrace: stackTrace,
        );
      }
    }
  }
}
