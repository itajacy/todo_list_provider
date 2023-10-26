import 'package:todo_list_provider/app/core/database/migrations/migration.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration_V2.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration_V3.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration_v1.dart';

class SqliteMigrationFactory {
  // se o usuário instalou pela primeira vez, ele executará as migrations V1, V2 e V3
  List<Migration> getCreateMigration() => [
        MigrationV1(),
        MigrationV2(),
        MigrationV3(),
      ];

  List<Migration> getUpgradeMigration(int version) {
    final migrations = <Migration>[];

// versão atual = 3
// versão do usuário = 1  --> atualiza/executa a MigrationV2 e depois a V3
// se a versão do usuário for = 2 --> atualiza/executa somente a V3, pq a v2
// ele já tinha

    if (version == 1) {
      migrations.add(MigrationV2());
      migrations.add(MigrationV3());
    }
    if (version == 2) {
      migrations.add(MigrationV3());
    }

    return migrations;
  }
}
