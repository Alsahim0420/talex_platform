# TaleX Platform

Plataforma web de TaleX construida en Flutter con Clean Architecture por feature.

## Arquitectura

Cada feature separa `data`, `domain` y `presentation`. El dominio expone entidades,
repositorios abstractos y casos de uso con `Either<Failure, T>`. Data contiene modelos,
mappers, data sources e implementaciones de repositorio. Presentación usa BLoC con
eventos, estados y `copy_with_extension`, sin Freezed. GetIt compone las dependencias.

La autenticación usa por ahora un data source en memoria. Su contrato permite sustituirlo
por Firebase o una API sin modificar dominio ni UI.

```bash
dart run build_runner build --delete-conflicting-outputs
flutter run -d chrome
```
