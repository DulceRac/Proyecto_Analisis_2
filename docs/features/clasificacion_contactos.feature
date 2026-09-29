# language: es

Característica: Clasificación de contactos del CRM
  Como usuario autenticado
  quiero registrar contactos según su clasificación
  para conservar la información específica de clientes, proveedores y empleados

  # HU-05
  Escenario: Registrar correctamente un contacto como cliente
    Dado que existe un usuario autenticado
    Y proporciona datos generales válidos
    Y proporciona un código de cliente entero, positivo y único
    Cuando registra el contacto como cliente
    Entonces el sistema debe crear el contacto
    Y debe guardar su información de cliente
    Y debe responder con código 201

  Escenario: Registrar cliente con código inválido o repetido
    Dado que existe un usuario autenticado
    Y proporciona un código de cliente inválido o ya registrado
    Cuando intenta registrar el cliente
    Entonces el sistema debe rechazar el registro
    Y no debe guardar información parcial

  Escenario: Registrar cliente sin autenticación
    Dado que el usuario no está autenticado
    Cuando intenta registrar un contacto como cliente
    Entonces el sistema debe rechazar la operación


  # HU-06
  Escenario: Registrar correctamente un contacto como proveedor
    Dado que existe un usuario autenticado
    Y proporciona los datos generales requeridos
    Y proporciona una descripción del proveedor
    Cuando registra el contacto como proveedor
    Entonces el sistema debe crear el contacto
    Y debe guardar la información específica del proveedor
    Y debe responder con código 201

  Escenario: Registrar proveedor sin descripción
    Dado que existe un usuario autenticado
    Y no proporciona una descripción
    Cuando intenta registrar el contacto como proveedor
    Entonces el sistema debe rechazar el registro
    Y no debe guardar información parcial

  Escenario: Registrar proveedor sin autenticación
    Dado que el usuario no está autenticado
    Cuando intenta registrar un proveedor
    Entonces el sistema debe rechazar la operación


  # HU-07
  Escenario: Registrar correctamente un contacto como empleado
    Dado que existe un usuario autenticado
    Y proporciona los datos generales requeridos
    Y proporciona un puesto y departamento
    Cuando registra el contacto como empleado
    Entonces el sistema debe crear el contacto
    Y debe guardar la información específica del empleado
    Y debe responder con código 201

  Escenario: Registrar empleado sin puesto o departamento
    Dado que existe un usuario autenticado
    Y no proporciona el puesto o el departamento
    Cuando intenta registrar el contacto como empleado
    Entonces el sistema debe rechazar el registro
    Y no debe guardar información parcial

  Escenario: Registrar empleado sin autenticación
    Dado que el usuario no está autenticado
    Cuando intenta registrar un empleado
    Entonces el sistema debe rechazar la operación
