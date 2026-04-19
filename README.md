# News App

Приложение для чтения новостей на Flutter. Позволяет просматривать топ-новости, искать по категориям и сохранять избранные статьи локально.

## 🚀 Возможности

- **Просмотр новостей**: Топ-новости из NewsAPI.org
- **Поиск и фильтры**: Поиск по ключевым словам, фильтр по категориям (бизнес, спорт, технологии и т.д.)
- **Избранное**: Сохранение статей в локальное хранилище (Hive)
- **Оффлайн**: Просмотр сохранённых статей без интернета
- **Адаптивный дизайн**: Поддержка светлой/тёмной темы, Material Design 3

## 🏗 Архитектура

Проект построен на **Clean Architecture** с разделением на слои:

### Структура проекта
```
lib/
├── app/                    # Основное приложение (MyApp, навигация)
├── core/                   # Общие компоненты
│   ├── di/                 # Dependency Injection (GetIt + Injectable)
│   ├── error/              # Обработка ошибок (Failure, Result)
│   ├── l10n/               # Локализация (Strings)
│   ├── network/            # Сеть (DioClient)
│   ├── theme/              # Темы и стили
│   └── widgets/            # Переиспользуемые виджеты
├── features/               # Фичи приложения
│   ├── news/               # Модуль новостей
│   │   ├── data/           # DTO, API, репозитории
│   │   ├── domain/         # Сущности, интерфейсы, use cases
│   │   └── presentation/   # BLoC, виджеты, экраны
│   └── favorites/          # Модуль избранного
└── main.dart               # Точка входа
```

### Почему Clean Architecture?
- **Масштабируемость**: Легко добавлять новые фичи без изменения существующих
- **Тестируемость**: Каждый слой можно тестировать независимо (моки для репозиториев, etc.)
- **Разделение ответственности**: Data слой не знает о Presentation, Domain — бизнес-логика
- **Поддерживаемость**: Код организован по принципам SOLID

### Технологии и библиотеки

#### State Management
- **BLoC (Business Logic Component)**: Для управления состоянием экранов
  - Почему BLoC? Предсказуемый поток данных, легко тестировать, подходит для сложной логики
  - Альтернативы: Riverpod, Provider — но BLoC лучше для больших проектов

#### Networking
- **Dio + Retrofit**: Для HTTP запросов
  - Dio: Мощный HTTP клиент с interceptors
  - Retrofit: Генерация API клиентов из аннотаций (как в Java/Kotlin)
  - Почему не http? Dio имеет больше фич (отмена запросов, логирование)

#### Local Storage
- **Hive**: NoSQL база для Flutter
  - Быстрая, типобезопасная, не требует SQL
  - Почему не SQLite? Hive проще для простых данных, не нужен ORM

#### Dependency Injection
- **GetIt + Injectable**: Для управления зависимостями
  - GetIt: Легковесный DI контейнер
  - Injectable: Генерация кода для регистрации зависимостей (вместо ручной)
  - Почему не Provider? GetIt лучше для больших проектов с множеством зависимостей

#### Code Generation
- **Freezed**: Для immutable моделей и union types
  - Генерирует equals, hashCode, copyWith, fromJson/toJson
  - Почему не Equatable? Freezed мощнее, поддерживает JSON сериализацию
- **Json Serializable**: Для JSON маппинга
- **Hive Generator**: Для адаптеров Hive

#### UI & Utils
- **Flutter Hooks**: Для функциональных виджетов (useEffect, useState)
- **Cached Network Image**: Кеширование изображений
- **Intl**: Для локализации
- **Flutter DotEnv**: Для переменных окружения (.env файлы)

#### Тестирование
- **Bloc Test**: Для тестирования BLoC
- **Mockito**: Для моков зависимостей

## 📋 Настройка и запуск

### 1. Клонирование и зависимости
```bash
git clone <repo-url>
cd news_app
flutter pub get
```

### 2. API ключ
Получите ключ на [NewsAPI.org](https://newsapi.org/) (бесплатный план: 100 запросов/день).

Создайте файл `.env` в корне проекта:
```env
NEWS_API_KEY=ваш_ключ_здесь
```

Или передайте при запуске:
```bash
flutter run --dart-define=NEWS_API_KEY=ваш_ключ
```

### 3. Генерация кода
Проект использует code generation для моделей, API и DI:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Запуск
```bash
flutter run
```

Для iOS/Android/Web — укажите платформу:
```bash
flutter run -d ios  # или android, web
```

## 🧪 Тестирование

Запуск unit-тестов:
```bash
flutter test
```

Интеграционные тесты:
```bash
flutter test integration_test/
```

## 📱 Сборка

### Android APK
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🔧 Скрипты

В папке `scripts/` есть полезные скрипты:
- `build_runner.sh`: Запуск генерации кода
- `watch_runner.sh`: Watch-режим для генерации

## 🧱 Mason (генерация фич)

Mason используется для **стандартизации** и **ускорения разработки**: новые фичи создаются по единым шаблонам, что снижает количество ручной рутины и уменьшает вероятность структурных ошибок, помогает **масштабировать** проект:

- **Скорость delivery**: генерация каркаса фичи одной командой вместо ручного создания структуры и файлов.
- **Единообразие**: одинаковая структура `data/domain/presentation` и согласованные заготовки (BLoC, use cases, repositories).
- **Качество**: меньше расхождений между фичами и меньше ошибок из серии “забыли добавить файл/директиву/part”.

### Установка Mason CLI (один раз)
```bash
dart pub global activate mason_cli
```

Проверь:
```bash
mason --version
```

### Подтянуть bricks
```bash
mason get
```

### Сгенерировать новую фичу (Clean Architecture skeleton)
```bash
mason make feature --name profile
```
