# pymongo-api

## Как запустить

Запускаем mongodb и приложение

```shell
docker compose up -d
```

Инициализируем и Заполняем mongodb данными

```shell
./scripts/mongo-init.sh
```

## Как проверить

```shell
./scripts/mongodb-countdoc.sh
```
Откройте в браузере http://ip:8080
