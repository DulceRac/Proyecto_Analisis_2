# ADR-003 – Uso del Patrón Cache-Aside con Redis

## Estado

Aceptado.

## Contexto

El módulo CRM realiza consultas frecuentes sobre información de contactos y otros recursos. Ejecutar todas estas consultas directamente sobre la base de datos puede incrementar innecesariamente la carga y el tiempo de respuesta.

En la arquitectura previa ya se contempló el uso de **Redis mediante Cache-Aside** para reducir consultas repetitivas. 

## Decisión

Se utilizará **Redis** como almacenamiento temporal mediante el patrón **Cache-Aside**.

El flujo será:

1. La aplicación consulta primero Redis.
2. Si el dato existe, se devuelve desde caché (**Cache Hit**).
3. Si no existe, se consulta la base de datos (**Cache Miss**).
4. El resultado se almacena temporalmente en Redis.
5. Se devuelve la información al cliente.

## Política de expiración

Las claves almacenadas tendrán un **TTL definido según el tipo de información** para evitar mantener datos obsoletos de forma indefinida.

Cuando una entidad sea creada, modificada o eliminada, las claves relacionadas deberán invalidarse o actualizarse.

## Consecuencias positivas

- Reduce consultas repetitivas a la base de datos.
- Mejora el tiempo de respuesta.
- Disminuye la carga sobre la persistencia principal.
- Redis puede fallar sin comprometer la información permanente.

## Consecuencias negativas

- Puede existir información temporalmente desactualizada.
- Requiere controlar correctamente la invalidación de caché.
- Agrega una dependencia adicional a la aplicación.

## Justificación

Cache-Aside permite mejorar el desempeño del CRM sin convertir Redis en la fuente principal de información. Si Redis no está disponible, el sistema podrá continuar consultando directamente la base de datos.
