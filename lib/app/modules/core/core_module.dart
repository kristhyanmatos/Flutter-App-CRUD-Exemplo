import 'package:flutter_modular/flutter_modular.dart';

import 'domain/services/criptografia_service.dart';
import 'external/datasources/criptografia_datasource.dart';
import 'infra/datasources/criptografia_datasource.dart';
import 'infra/services/criptografia_service.dart';

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton<ICriptografiaDataSource>(
      (i) => CriptografiaDataSource(),
      export: true,
    ),
    Bind.singleton<ICriptografiaService>(
      (i) => CriptografiaService(i()),
      export: true,
    ),
  ];
}
