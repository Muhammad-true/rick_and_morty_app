# Rick and Morty App

Это мобильное приложение на Flutter, созданное для просмотра персонажей из вселенной "Rick and Morty" с возможностью добавления в избранное, офлайн-кэшированием и поддержкой светлой/тёмной темы.

---

## 🚀 Основные возможности

- 🔍 Просмотр персонажей (имя, статус, раса, локация)
- 🌐 Поддержка офлайн-режима (кэш через Hive)
- ⭐ Добавление и удаление избранных персонажей
- 🎨 Переключение между тёмной и светлой темами
- 📦 Загрузка изображений и данных с API
- 📃 Список с бесконечной прокруткой и автоматической подгрузкой

---

## 🧱 Используемые библиотеки

| Пакет | Назначение |
|------|------------|
| [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) | Состояние через BLoC (для персонажей, избранного, темы) |
| [`dio`](https://pub.dev/packages/dio) | HTTP-клиент для работы с REST API |
| [`hive`](https://pub.dev/packages/hive) | Кэширование данных и оффлайн-доступ |
| [`hive_flutter`](https://pub.dev/packages/hive_flutter) | Интеграция Hive с Flutter |
| [`path_provider`](https://pub.dev/packages/path_provider) | Доступ к путям в файловой системе |
| [`equatable`](https://pub.dev/packages/equatable) | Упрощает сравнение объектов BLoC-событий/состояний |
| [`shared_preferences`](https://pub.dev/packages/shared_preferences) | Хранение предпочтений (например, текущая тема) |
| [`cached_network_image`](https://pub.dev/packages/cached_network_image) | (опционально) Кэширование изображений по URL |

---

## ⚙️ Настройки для релизной сборки

**Разрешения (AndroidManifest.xml):**

```xml
<uses-permission android:name="android.permission.INTERNET"/>
