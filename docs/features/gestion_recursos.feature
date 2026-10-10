# language: es

Característica: Gestión de contactos del CRM
  Como usuario autenticado
  Quiero gestionar contactos
  Para mantener organizada la información del CRM

  Antecedentes:
    Dado que el usuario se encuentra autenticado con un token JWT válido

  @REQ-FN-003 @HU-03
  Escenario: Consultar contactos utilizando caché
    Dado que solicito el listado de contactos
    Cuando envío una solicitud GET a "/api/v1/contactos"
    Entonces la API debe responder con código 200
    Y debe consultar primero Redis
    Y si no existe información en caché debe consultar PostgreSQL
    Y debe almacenar temporalmente el resultado en Redis

  @REQ-FN-002 @HU-02
  Esquema del escenario: Registrar un contacto válido
    Dado que preparo un contacto de tipo "<tipo>"
    Con nombre "<nombre>"
    Y apellido "<apellido>"
    Y teléfono "<telefono>"
    Cuando envío una solicitud POST a "/api/v1/contactos"
    Entonces la API debe responder con código 201
    Y el contacto debe almacenarse en PostgreSQL
    Y debe generarse un registro histórico en MongoDB

    Ejemplos:
      | tipo      | nombre | apellido | telefono     |
      | general   | Carlos | López    | +50255550001 |
      | cliente   | Ana    | García   | +50255550002 |
      | proveedor | Pedro  | Morales  | +50255550003 |

  @REQ-FN-002
  Esquema del escenario: Rechazar contacto con datos inválidos
    Dado que preparo un contacto con nombre "<nombre>"
    Y teléfono "<telefono>"
    Cuando envío una solicitud POST a "/api/v1/contactos"
    Entonces la API debe responder con código 422
    Y la respuesta debe utilizar "application/problem+json"
    Y debe indicar un error de validación

    Ejemplos:
      | nombre | telefono |
      |        | 55550001 |
      | A      | 55550002 |
      | Carlos |          |

  @Historial
  Escenario: Consultar historial de un contacto
    Dado que existe el contacto con identificador 1
    Y existen registros históricos en MongoDB
    Cuando envío una solicitud GET a "/api/v1/contactos/1/historial"
    Entonces la API debe responder con código 200
    Y debe devolver el historial almacenado en MongoDB

  @Relaciones
  Escenario: Consultar relaciones de un contacto
    Dado que existe el contacto con identificador 1
    Y existen relaciones asociadas en Neo4j
    Cuando envío una solicitud GET a "/api/v1/contactos/1/relaciones"
    Entonces la API debe responder con código 200
    Y debe devolver las relaciones encontradas en Neo4j
