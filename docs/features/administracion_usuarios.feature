# language: es

Característica: Administración de usuarios del CRM
  Como administrador
  quiero gestionar las cuentas del sistema
  para controlar el acceso del personal autorizado

  # HU-12
  Escenario: Administrador crea correctamente una cuenta
    Dado que existe un administrador activo
    Y proporciona un correo válido y único
    Y proporciona una contraseña que cumple las reglas de seguridad
    Y selecciona un rol permitido
    Cuando registra la nueva cuenta
    Entonces el sistema debe crear el usuario
    Y debe almacenar la contraseña mediante hash
    Y debe asignar el rol seleccionado

  Escenario: Crear una cuenta con correo duplicado
    Dado que existe un administrador activo
    Y ya existe una cuenta con el correo proporcionado
    Cuando intenta crear un nuevo usuario
    Entonces el sistema debe rechazar el registro
    Y no debe crear una cuenta duplicada

  Escenario: Crear usuario con contraseña insegura
    Dado que existe un administrador activo
    Y proporciona una contraseña que no contiene al menos ocho caracteres, letras y números
    Cuando intenta crear la cuenta
    Entonces el sistema debe rechazar el registro

  Escenario: Usuario estándar intenta crear una cuenta
    Dado que existe un usuario estándar autenticado
    Cuando intenta crear una nueva cuenta
    Entonces el sistema debe impedir la operación


  # HU-13
  Escenario: Administrador actualiza correctamente una cuenta
    Dado que existe un administrador activo
    Y existe una cuenta que puede ser modificada
    Cuando actualiza sus datos, rol o estado con valores válidos
    Entonces el sistema debe guardar los cambios
    Y debe mantener las reglas de seguridad y acceso

  Escenario: Administrador intenta desactivar su propia cuenta
    Dado que existe un administrador autenticado
    Cuando intenta desactivar su propia cuenta
    Entonces el sistema debe rechazar la operación
    Y la cuenta debe permanecer activa

  Escenario: Desactivar al último administrador activo
    Dado que solamente existe un administrador activo en el sistema
    Cuando se intenta desactivar su cuenta
    Entonces el sistema debe rechazar la operación
    Y debe conservar al menos un administrador activo

  Escenario: Actualizar una cuenta con correo duplicado
    Dado que existe un administrador activo
    Y otra cuenta utiliza el correo indicado
    Cuando intenta asignar ese correo a un usuario
    Entonces el sistema debe rechazar los cambios
    Y debe conservar la información anterior

  Escenario: Usuario estándar intenta modificar otra cuenta
    Dado que existe un usuario estándar autenticado
    Cuando intenta modificar los datos o rol de una cuenta
    Entonces el sistema debe impedir la operación
