# language: es

Característica: Autenticación de usuarios
  Como usuario del CRM
  Quiero autenticarme mediante mis credenciales
  Para acceder a los recursos protegidos

  @REQ-FN-001 @HU-01
  Escenario: Inicio de sesión correcto
    Dado que existe un usuario activo con correo "admin@crm.com"
    Y la contraseña ingresada es válida
    Cuando envío una solicitud POST a "/api/v1/auth/login"
    Entonces la API debe responder con código 200
    Y debe devolver un token JWT
    Y el tipo del token debe ser "Bearer"

  @REQ-FN-001 @HU-01
  Esquema del escenario: Inicio de sesión rechazado
    Dado que intento iniciar sesión con correo "<correo>"
    Y contraseña "<password>"
    Cuando envío una solicitud POST a "/api/v1/auth/login"
    Entonces la API debe responder con código <codigo>
    Y la respuesta debe utilizar "application/problem+json"

    Ejemplos:
      | correo               | password      | codigo |
      | incorrecto@crm.com   | Clave1234     | 401    |
      | admin@crm.com        | Incorrecta123 | 401    |
      | correo-invalido      | Clave1234     | 422    |
