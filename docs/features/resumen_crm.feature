# language: es

Característica: Resumen de información del CRM
  Como usuario autenticado
  quiero visualizar un resumen de los contactos autorizados
  para conocer el estado general de la información que gestiono

  # HU-14
  Escenario: Usuario estándar consulta el resumen de su cartera
    Dado que existe un usuario estándar autenticado
    Y tiene contactos asociados a su cuenta
    Cuando consulta el resumen del CRM
    Entonces el sistema debe mostrar las cantidades por tipo de contacto
    Y debe mostrar las cantidades por estado
    Y debe mostrar únicamente registros recientes autorizados para el usuario

  Escenario: Administrador consulta el resumen global
    Dado que existe un administrador autenticado
    Y existen contactos registrados por diferentes usuarios
    Cuando consulta el resumen del CRM
    Entonces el sistema debe mostrar los indicadores globales
    Y debe incluir los contactos autorizados para el rol administrador
    Y los conteos deben coincidir con la información almacenada

  Escenario: Consultar resumen sin autenticación
    Dado que el usuario no posee autenticación válida
    Cuando intenta consultar el resumen del CRM
    Entonces el sistema debe rechazar la operación
    Y no debe mostrar información del CRM
