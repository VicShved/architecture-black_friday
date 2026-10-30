# pymongo-api

Проект с приложением на FastAPI, MongoDB с шардированием и репликацией,
а также Redis для кеширования запросов.

## Состав репозитория

- `mongo-sharding` — папка с решением задания 2;
- `mongo-sharding-repl` — папка с решением задания 3;
- `sharding-repl-cache` — папка с решением заданий 2, 3 и 4; эта директория
  используется для проверки финальной реализации;
- [mongo-sharding.drawio](mongo-sharding.drawio) - схема по заданию 2
- [mongo-sharding-repl.drawio](mongo-sharding-repl.drawio) - схема по залданию 3
- [sharding-repl-cache.drawio](sharding-repl-cache.drawio) - схема по заданию 4 (основная)
- [sharding-repl-cache-gateway.drawio](sharding-repl-cache-gateway.drawio) - схема по заданию 5
- [sharding-repl-cache-gateway-cdn.drawio](sharding-repl-cache-gateway-cdn.drawio) - схема по заданию 6

## Как запустить

Для проверки используется директория `sharding-repl-cache`.

```shell
cd sharding-repl-cache
docker compose up -d
```

После запуска контейнеров выполните инициализацию и наполнение MongoDB:

```shell
./scripts/mongo-init.sh
```

Скрипт настраивает шардирование и репликацию, после чего заполняет
коллекцию `somedb.helloDoc` тестовыми документами (не менее 1000).

## Как проверить

Откройте приложение в браузере:

- http://localhost:8080

Swagger с доступными эндпоинтами:

- http://localhost:8080/docs