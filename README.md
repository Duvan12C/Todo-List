
# to_list_app

Este proyecto es una aplicación creada con Flutter para gestionar ingresos y gastos. Permite a los usuarios agregar nuevas entradas de ingresos y gastos, eliminarlas, y visualizar un gráfico general con un resumen de los mismos.

## Clonación del Proyecto

Para clonar este repositorio y comenzar a trabajar en él, sigue estos pasos:

1. Abre tu terminal o consola.
2. Ejecuta el siguiente comando para clonar el repositorio:

   ```bash
   git clone https://github.com/tu_usuario/to_list_app.git
   ```

3. Navega a la carpeta del proyecto:

   ```bash
   cd to_list_app
   ```

4. Instala las dependencias del proyecto:

   ```bash
   flutter pub get
   ```

5. Asegúrate de que tienes configurado un emulador o un dispositivo físico con Android API 35 o superior, y ejecuta la app:

   ```bash
   flutter run
   ```

## Dependencias Utilizadas

Este proyecto hace uso de las siguientes dependencias:

- **[sqflite](https://pub.dev/packages/sqflite)**: Para gestionar la base de datos SQLite local.
- **[path](https://pub.dev/packages/path)**: Para manejar las rutas del sistema de archivos.
- **[provider](https://pub.dev/packages/provider)**: Para la gestión de estados en la aplicación.
- **[syncfusion_flutter_charts](https://pub.dev/packages/syncfusion_flutter_charts)**: Para crear gráficos interactivos y visualizaciones.
- **[awesome_dialog](https://pub.dev/packages/awesome_dialog)**: Para mostrar diálogos personalizados y atractivos.

### Configuración de Dependencias en `pubspec.yaml`

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.4.0  # O la versión más reciente disponible
  path: ^1.8.0  # Para gestionar rutas
  provider: ^6.0.0  # Gestión de estado
  syncfusion_flutter_charts: ^27.1.53  # Para gráficos y visualización de datos
  awesome_dialog: ^3.2.1  # Para diálogos personalizados
```

## Requisitos

- **Flutter SDK**: Asegúrate de tener instalada la última versión de Flutter. [Instalar Flutter](https://flutter.dev/docs/get-started/install)
- **Android API 35**: Este proyecto está configurado para usar API 35 de Android. Puedes configurar el nivel de API en el archivo `android/app/build.gradle`.

## Funcionalidades

- **Agregar ingresos y gastos**: Permite agregar nuevas entradas de ingresos y gastos a la lista.
- **Eliminar entradas**: Opción para eliminar cualquier entrada existente.
- **Visualización gráfica**: Proporciona un gráfico general que resume los ingresos y gastos.

## Widgets Utilizados

Algunos de los widgets clave utilizados en esta aplicación incluyen:

- **Scaffold**: La estructura principal de la interfaz.
- **ListView**: Para mostrar listas de elementos.
- **TextFormField**: Para recibir entradas de usuario.
- **Charts**: Utilizados para visualizar datos de manera interactiva con `syncfusion_flutter_charts`.
- **Dialogs**: Diálogos personalizados proporcionados por `awesome_dialog`.

## Recursos útiles

Si eres nuevo en Flutter, aquí tienes algunos recursos para comenzar:

- [Lab: Escribe tu primera aplicación Flutter](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Ejemplos útiles de Flutter](https://docs.flutter.dev/cookbook)

Para obtener ayuda con el desarrollo en Flutter, puedes consultar la [documentación en línea](https://docs.flutter.dev/), que ofrece tutoriales, ejemplos, guías sobre desarrollo móvil y una referencia completa de la API.
