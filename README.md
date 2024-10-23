# sprint 2 
## sprint 2 task 1_1
Шардирование в MongoDB для повышения производительности. Двух шардов будет достаточно.
https://github.com/AleksandrMakridin/architecture-sprint-2/blob/sprint2/spint2task1.drawio
## sprint 2 task 1_2
Репликацию MongoDB для повышения отказоустойчивости.
https://github.com/AleksandrMakridin/architecture-sprint-2/blob/sprint2/spint2task2.drawio
## sprint 2 task 1_3
Кэширование для ещё большего повышения производительности.
https://github.com/AleksandrMakridin/architecture-sprint-2/blob/sprint2/spint2task3.drawio

# Разворачивалось все на Ubuntu+Docker+Portainer
## sprint 2 task 2 Шардирование
https://github.com/AleksandrMakridin/architecture-sprint-2/tree/sprint2/mongo-sharding
## sprint 2 task 3 Репликация
https://github.com/AleksandrMakridin/architecture-sprint-2/tree/sprint2/mongo-sharding-repl
## sprint 2 task 4 Кэширование
https://github.com/AleksandrMakridin/architecture-sprint-2/tree/sprint2/sharding-repl-cache

## Как запустить
В bash не очень силен. Но надеюсь верно. Смотрел через Container console

Инициализируем и Заполняем mongodb данными

```shell
./scripts/mongo-init.sh
```

## Как проверить

```shell
./scripts/mongodb-countdoc.sh
```
## sprint 2 task 5 
Service Discovery и балансировка с API Gateway
Добавил в схему еще и nginx + еще один redis. На основе расмотренных примеров, мне кажется так правильнее.
https://github.com/AleksandrMakridin/architecture-sprint-2/blob/sprint2/spint2task5.drawio

## sprint 2 task 6 
CDN
https://github.com/AleksandrMakridin/architecture-sprint-2/blob/sprint2/spint2task6.drawio
