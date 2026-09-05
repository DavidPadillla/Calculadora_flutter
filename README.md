# Calculadora Flutter

Calculadora básica hecha paso a paso con Flutter. Permite sumar, restar,
multiplicar, dividir, limpiar la pantalla y mostrar el resultado.

## 1. Estructura de carpetas

```text
lib/
├── main.dart
├── screens/
│   └── calculator_screen.dart
├── widgets/
│   └── calculator_button.dart
├── services/
│   └── calculator_service.dart
└── utils/
    └── app_theme.dart
```

## 2. Qué hace cada carpeta

- `main.dart`: inicia la aplicación y carga el tema.
- `screens/`: contiene las pantallas completas; aquí está la pantalla de la calculadora.
- `widgets/`: contiene componentes reutilizables, como cada botón.
- `services/`: contiene la lógica de negocio y las operaciones matemáticas.
- `utils/`: contiene configuraciones generales, como el tema visual.
- `test/`: contiene las pruebas automáticas.

## 3. Ejecutar el proyecto

Desde esta carpeta ejecuta:

```bash
flutter pub get
flutter run
```

Para comprobar que las operaciones funcionan:

```bash
flutter test
```

## 4. Cómo funciona una suma

1. `calculator_screen.dart` recibe los toques de los botones.
2. Al pulsar `+`, guarda el primer número y la operación.
3. Al pulsar `=`, obtiene el segundo número.
4. `calculator_service.dart` realiza la operación.
5. La pantalla muestra el resultado con `setState`.
