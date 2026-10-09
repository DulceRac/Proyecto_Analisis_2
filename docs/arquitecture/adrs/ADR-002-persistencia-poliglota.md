# ADR-002 – Adopción de Persistencia Políglota

## Estado

Aceptado.

## Contexto

El módulo CRM maneja diferentes tipos de información y necesidades de acceso. Algunas operaciones requieren integridad transaccional, otras flexibilidad documental, consultas rápidas en memoria y relaciones complejas entre entidades.

Utilizar un único motor de base de datos para todos estos casos podría limitar el rendimiento y la flexibilidad del sistema.

## Decisión

Se adopta una estrategia de **Persistencia Políglota**, utilizando diferentes tecnologías según el tipo de información y operación:

| Tecnología | Uso propuesto |
|---|---|
| **PostgreSQL** | Datos transaccionales principales: usuarios, contactos, clientes y proveedores. |
| **MongoDB** | Información documental o flexible que pueda variar en estructura. |
| **Redis** | Caché de consultas frecuentes, sesiones o información temporal. |
| **Neo4j** | Relaciones complejas entre contactos, clientes, proveedores u otras entidades relacionadas. |

## Consecuencias positivas

- Cada tecnología se utiliza para el problema donde ofrece mejores capacidades.
- Mejora el rendimiento de determinadas consultas.
- Permite manejar distintos modelos de datos.
- Reduce consultas repetitivas mediante caché.
- Facilita análisis de relaciones complejas.

## Consecuencias negativas

- Incrementa la complejidad de infraestructura.
- Requiere administrar diferentes motores de datos.
- Puede existir duplicación de información.
- Se deben controlar problemas de sincronización y consistencia.

## Manejo de consistencia

PostgreSQL se utilizará como fuente principal para la información transaccional crítica.

Los datos almacenados en MongoDB, Redis o Neo4j podrán actualizarse de forma complementaria mediante mecanismos de sincronización y consistencia eventual cuando corresponda.

## Justificación

La persistencia políglota permite seleccionar la tecnología más adecuada para cada necesidad del CRM, manteniendo PostgreSQL como base principal y utilizando MongoDB, Redis y Neo4j como tecnologías especializadas.
