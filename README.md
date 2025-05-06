# README

¡Entendido! Aquí te dejo todo el diseño de la base de datos y la lógica de negocio para tu aplicación de finanzas personales, con los nombres de las tablas y atributos en inglés, pero la descripción en español:

### **Tablas de la Base de Datos**

#### **1. Tabla `Months`**
- **MonthID** (INT): Identificador único para cada mes.
- **MonthName** (VARCHAR): El nombre del mes (febrero, marzo, abril, etc.).
- **Year** (INT): El año correspondiente.

#### **2. Tabla `Categories`**
- **CategoryID** (INT): Identificador único para cada categoría.
- **CategoryName** (VARCHAR): Nombre de la categoría (Esenciales, Ocio, Entretenimientos, Ahorros).
- **HasLimit** (BOOLEAN): Indica si la categoría tiene un límite de gasto asociado.

#### **3. Tabla `Transactions`**
- **TransactionID** (INT): Identificador único para cada transacción.
- **MonthID** (INT): Vinculado a la tabla `Months`.
- **CategoryID** (INT): Vinculado a la tabla `Categories`.
- **Type** (VARCHAR): 'Income' (Ingreso) o 'Expense' (Egreso).
- **Amount** (DECIMAL): Cantidad de la transacción.
- **Description** (TEXT): Descripción opcional de la transacción.
- **Date** (DATE): Fecha exacta de la transacción.

#### **4. Tabla `SpendingLimits`**
- **LimitID** (INT): Identificador único para cada límite de gasto.
- **CategoryID** (INT): Vinculado a la tabla `Categories`.
- **LimitAmount** (DECIMAL): El monto máximo permitido para gastar en la categoría correspondiente.
- **Period** (VARCHAR): Periodo del límite (ej., mensual, anual).

### **5. Tabla `saving_goals` **

- **user_id** clave foránea que hace referencia a la tabla users.
- **goal_name** nombre de la meta de ahorro.
- **target_amount** cantidad objetivo que el usuario quiere ahorrar.
- **saved_amount** cantidad ya ahorrada.
- **deadline** fecha límite para alcanzar la meta de ahorro.

### **Lógica de Negocio**

- **Establecimiento de Límites de Gasto:** Los usuarios pueden definir y modificar los límites de gasto por categoría según el periodo que elijan.
- **Registro de Transacciones:** Cada ingreso o egreso se registra en la tabla `Transactions`, incluyendo detalles como el monto, la categoría, y la fecha.
- **Validación de Gastos:** Al ingresar un nuevo egreso, el sistema verifica si el gasto total en esa categoría durante el periodo especificado excede el límite establecido.
- **Alertas de Gastos:** Si los gastos se acercan al límite, se generan alertas para informar al usuario.
- **Reportes Financieros:** La aplicación ofrece reportes y visualizaciones que comparan los gastos reales con los límites establecidos, ayudando a los usuarios a entender mejor sus hábitos de gasto.


