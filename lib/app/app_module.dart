import 'package:flutter_modular/flutter_modular.dart';
import 'modules/alunos/usuarios_module.dart';
import 'modules/core/core_module.dart';

class AppModule extends Module {
  @override
  final List<Module> imports = [CoreModule()];
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: AlunosModule()),
  ];
}
