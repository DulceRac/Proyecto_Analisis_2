# language: es

Característica: Gestión de contactos del CRM
  Como usuario autenticado
  quiero gestionar los contactos autorizados
  para mantener organizada la información del CRM

  # HU-02
  Escenario: Usuario estándar consulta sus contactos
    Dado que existe un usuario estándar autenticado
    Y tiene contactos asociados a su cuenta
    Cuando consulta el listado de contactos
    Entonces el sistema debe responder con código 200
    Y debe mostrar únicamente los contactos asociados al usuario
    Y debe mostrar el listado de forma paginada

  Escenario: Consulta de contactos sin autenticación
    Dado que el usuario no posee un token válido
    Cuando intenta consultar el listado de contactos
    Entonces el sistema debe rechazar la solicitud
    Y no debe mostrar información de contactos

  Escenario: Consulta con una paginación inválida
    Dado que existe un usuario estándar autenticado
    Cuando solicita una cantidad de registros superior al máximo permitido
    Entonces el sistema debe rechazar el valor inválido
    Y no debe retornar una paginación fuera de los límites establecidos


  # HU-03
  Escenario: Administrador consulta todos los contactos
    Dado que existe un administrador autenticado
    Y existen contactos registrados por diferentes usuarios
    Cuando consulta el listado de contactos
    Entonces el sistema debe responder con código 200
    Y debe permitir visualizar los contactos de todos los usuarios

  Escenario: Usuario estándar intenta consultar contactos ajenos
    Dado que existe un usuario estándar autenticado
    Y existen contactos pertenecientes a otros usuarios
    Cuando intenta consultar información fuera de su cartera
    Entonces el sistema debe impedir el acceso
    Y no debe mostrar los contactos de otros usuarios

  Escenario: Consulta administrativa sin autenticación
    Dado que no existe una sesión o token válido
    Cuando se intenta consultar todos los contactos
    Entonces el sistema debe rechazar la operación


  # HU-04
  Escenario: Registrar correctamente un contacto general
    Dado que existe un usuario autenticado
    Y proporciona nombre, apellido, teléfono y tipo válidos
    Cuando registra un nuevo contacto general
    Entonces el sistema debe crear el contacto
    Y debe asociarlo a la cuenta autenticada
    Y debe dejarlo en estado activo
    Y debe responder con código 201

  Escenario: Registrar contacto sin datos obligatorios
    Dado que existe un usuario autenticado
    Y no proporciona uno de los datos obligatorios
    Cuando intenta registrar el contacto
    Entonces el sistema debe rechazar el registro
    Y no debe guardar información parcial

  Escenario: Registrar contacto con teléfono duplicado
    Dado que existe un usuario autenticado
    Y ya existe un contacto con el mismo teléfono
    Cuando intenta registrar un nuevo contacto
    Entonces el sistema debe rechazar el registro
    Y debe indicar que el teléfono ya está registrado

  Escenario: Registrar contacto sin autenticación
    Dado que el usuario no está autenticado
    Cuando intenta registrar un nuevo contacto
    Entonces el sistema debe rechazar la operación
    Y no debe crear el contacto


  # HU-08
  Escenario: Buscar y filtrar contactos autorizados
    Dado que existe un usuario autenticado
    Y tiene contactos autorizados registrados
    Cuando realiza una búsqueda utilizando nombre, tipo o estado
    Entonces el sistema debe responder con código 200
    Y debe mostrar únicamente los contactos que coincidan con los filtros
    Y debe respetar el alcance del usuario autenticado

  Escenario: Buscar contactos sin autenticación
    Dado que el usuario no posee autenticación válida
    Cuando intenta utilizar la búsqueda de contactos
    Entonces el sistema debe rechazar la operación

  Escenario: Utilizar un valor de filtro no permitido
    Dado que existe un usuario autenticado
    Cuando utiliza un tipo de contacto no válido como filtro
    Entonces el sistema debe rechazar el valor inválido
    Y no debe producir resultados incorrectos


  # HU-09
  Escenario: Consultar el detalle de un contacto autorizado
    Dado que existe un usuario autenticado
    Y el contacto solicitado está autorizado para ese usuario
    Cuando consulta el detalle del contacto
    Entonces el sistema debe responder con código 200
    Y debe mostrar sus datos generales
    Y debe mostrar sus datos específicos cuando corresponda

  Escenario: Consultar un contacto inexistente
    Dado que existe un usuario autenticado
    Y el identificador del contacto no existe
    Cuando consulta el detalle del contacto
    Entonces el sistema debe responder con código 404

  Escenario: Consultar un contacto sin autorización
    Dado que existe un usuario estándar autenticado
    Y el contacto pertenece a otro usuario
    Cuando intenta consultar su detalle
    Entonces el sistema debe impedir el acceso
    Y no debe mostrar los datos del contacto

  Escenario: Consultar detalle sin autenticación
    Dado que el usuario no posee autenticación válida
    Cuando intenta consultar un contacto
    Entonces el sistema debe rechazar la operación


  # HU-10
  Escenario: Actualizar correctamente un contacto autorizado
    Dado que existe un usuario autenticado
    Y tiene autorización para modificar el contacto
    Cuando actualiza los datos con valores válidos
    Entonces el sistema debe guardar los cambios
    Y debe mantener la información consistente
    Y debe conservar una única clasificación para el contacto

  Escenario: Actualizar un contacto inexistente
    Dado que existe un usuario autenticado
    Y el identificador proporcionado no corresponde a ningún contacto
    Cuando intenta actualizarlo
    Entonces el sistema debe responder con código 404

  Escenario: Actualizar un contacto con correo duplicado
    Dado que existe un usuario autenticado
    Y otro contacto ya utiliza el correo indicado
    Cuando intenta actualizar el contacto
    Entonces el sistema debe rechazar los cambios
    Y no debe alterar la información existente

  Escenario: Usuario intenta actualizar un contacto ajeno
    Dado que existe un usuario estándar autenticado
    Y el contacto pertenece a otro usuario
    Cuando intenta modificar el contacto
    Entonces el sistema debe impedir la operación
    Y no debe guardar ningún cambio


  # HU-11
  Escenario: Administrador desactiva correctamente un contacto
    Dado que existe un administrador autenticado
    Y el contacto se encuentra activo
    Cuando solicita desactivar el contacto
    Entonces el sistema debe cambiar su estado a inactivo
    Y debe conservar los datos del contacto
    Y no debe eliminar físicamente el registro

  Escenario: Usuario estándar intenta desactivar un contacto
    Dado que existe un usuario estándar autenticado
    Cuando intenta desactivar un contacto
    Entonces el sistema debe impedir la operación
    Y el contacto debe conservar su estado actual

  Escenario: Administrador intenta desactivar un contacto inexistente
    Dado que existe un administrador autenticado
    Y el contacto solicitado no existe
    Cuando intenta desactivarlo
    Entonces el sistema debe indicar que el recurso no fue encontrado

  Escenario: Desactivar contacto sin autenticación
    Dado que no existe una autenticación válida
    Cuando se intenta desactivar un contacto
    Entonces el sistema debe rechazar la operación
