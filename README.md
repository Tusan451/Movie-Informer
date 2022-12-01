![Frame 74](https://user-images.githubusercontent.com/54122530/204860295-ea52b0f2-4e1c-46e3-ad58-0563e270b5da.png)
# Movie Informer iOS App
###### iOS App using [Kinopoisk API Unofficial](https://kinopoiskapiunofficial.tech/)

![platform](https://img.shields.io/badge/platform-iOS-%239542FF)
![deployements](https://img.shields.io/badge/minimum%20deployments-iOS%2015.0-%239542FF)
![framework](https://img.shields.io/badge/SwiftUI-100%25-%239542FF)

Приложение, помогающее найти фильм по определенным подборкам или прямому поиску. Так же в приложении есть возможность добавить фильм в закладки или отметить как просмотренный. Просмотренные фильмы суммируются по категориям и у пользователя есть небольшая статистика по кол-ву просмотренных фильмов в разных категориях/жанрах. Используется неофициальное [API кинопоиска](https://kinopoiskapiunofficial.tech/).

## Основные возможности приложения
+ Просмотр подробной информации по фильму
+ Просмотр подробной информации по актеру
+ Поиск фильма/актера по названию/имени
+ Сохранение фильма в закладках
+ Сохранение фильма в просмотренных
+ Настройка темы приложения: светлая, темная, как в системе

## Запуск приложения
Для запуска приложения необходимо зарегистрироваться на сайте [kinopoiskapiunofficial.tech](https://kinopoiskapiunofficial.tech/) и получить токен. Для новых юзеров лимит 500 запросов в сутки. Это подойдет для демонстрации и ознакомления с приложением. Для полноценного использования можно связаться с саппортом и расширить лимит.

После получения токена его нужно вставить в код: папка Models -> файл FilmsCollection

```swift
let apiKey = "Your Api Key" // Enter API KEY here
```

## Стек
+ [SwiftUI](https://developer.apple.com/xcode/swiftui/)
+ [Realm](https://realm.io/)

## Скриншоты
![Frame 77](https://user-images.githubusercontent.com/54122530/205040535-336e9c17-5348-43b2-862e-2827ec52209e.png)
![Frame 79](https://user-images.githubusercontent.com/54122530/205041219-2685be32-bf82-47e2-9f14-51b8d0301a56.png)
![Frame 80](https://user-images.githubusercontent.com/54122530/205042037-22551a42-0d76-4ce5-bdb2-4494317d1c19.png)
![Frame 78](https://user-images.githubusercontent.com/54122530/205042982-a73021d8-2255-48a3-a6df-e62ca6990e63.png)
![Frame 81](https://user-images.githubusercontent.com/54122530/205043505-8b6ddee8-8e5e-44cd-8c7b-3102d5e61ae5.png)

## Дизайн
Приложение сверстано по собственным дизайн макетам: [ссылка на фигму](https://www.figma.com/file/3IsGHzcDlXc9TsgY6L9vSr/Movie-Informer-App?node-id=0%3A1&t=BytGdKtWy1UXQPOM-1)
