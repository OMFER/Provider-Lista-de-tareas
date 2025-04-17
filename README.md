
# ✅ App de Tareas

Aplicación simple para agregar, editar, completar y eliminar tareas, utilizando un backend local en Node.js y una app Android.

---

## 🚀 ¿Cómo ejecutar la app?

### 1. Requisitos previos

- Tener **Android Studio** instalado.
- Tener un **emulador Android** configurado.
- Tener instalado **Node.js** y **Git Bash**.
- Tener el proyecto descargado o clonado (incluyendo la carpeta del backend y la app Android).

---

### 2. Levantar el servidor (backend)

1. Abrí **Git Bash** en la carpeta donde está el archivo `tareas.js`.
2. Instalá las dependencias (solo la primera vez):
   ```bash
   npm install
   ```
3. Ejecutá el servidor con:
   ```bash
   node tareas.js
   ```
   Esto iniciará el backend en el puerto `3000`.

> 💡 Si estás usando un emulador de Android, este debe conectarse al backend usando la IP `http://10.0.2.2:3000`.

---

### 3. Ejecutar la app Android

1. Abrí la app en **Android Studio**.
2. Verificá que la app esté apuntando a `http://10.0.2.2:3000` para conectarse con el backend.
3. Iniciá un emulador de un dispositivo Android reciente.
4. Hacé clic en **Run** (▶️) para ejecutar la app.

---

### 4. Usar la app

Una vez iniciada, vas a poder:

- ➕ Agregar tareas.
- 📝 Editarlas.
- ✅ Marcar tareas como completadas.
- ❌ Borrarlas.

Todos los cambios se guardan a través del servidor que corre en el puerto 3000.

---

## 📝 Notas

- Si el puerto `3000` está ocupado, podés cambiarlo en el archivo `tareas.js` y también en el código de la app.
- Asegurate de que el servidor esté corriendo **antes** de iniciar la app, para que pueda cargar y guardar datos correctamente.

---

¡Listo! Ya podés usar tu app de tareas 🎉


## 🧪 Pruebas y Cobertura de Código

Para ejecutar las pruebas unitarias y verificar la cobertura del código:

1. **Ejecuta todas las pruebas**:
   ```bash
   flutter test