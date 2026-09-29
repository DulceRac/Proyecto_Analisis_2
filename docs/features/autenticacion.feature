# language: es

Característica: Autenticación de usuarios del CRM
  Como usuario con una cuenta registrada
  quiero iniciar sesión en el CRM
  para acceder a las operaciones autorizadas según mi rol

  # HU-01
  Escenario: Inicio de sesión correcto con una cuenta activa
    Dado que existe un usuario con una cuenta activa
    Y el usuario proporciona un correo y contraseña válidos
    Cuando solicita iniciar sesión en el CRM
    Entonces el sistema debe permitir el acceso
    Y debe responder con código 200
    Y debe generar un token JWT válido

  Escenario: Inicio de sesión con credenciales incorrectas
    Dado que existe un usuario registrado
    Y proporciona una contraseña incorrecta
    Cuando solicita iniciar sesión en el CRM
    Entonces el sistema debe rechazar el acceso
    Y debe responder con código 401
    Y no debe generar un token JWT

  Escenario: Inicio de sesión con una cuenta inactiva
    Dado que existe un usuario con una cuenta inactiva
    Y proporciona credenciales correctas
    Cuando solicita iniciar sesión en el CRM
    Entonces el sistema debe rechazar el acceso
    Y debe responder con código 401
    Y no debe generar un token JWT
