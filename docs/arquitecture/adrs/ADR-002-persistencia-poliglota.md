# ADR-002 – Evolución hacia Persistencia Políglota

## Estado

Propuesto.

## Contexto

La arquitectura previamente definida para el módulo CRM utiliza **MySQL como base de datos principal** y **Redis como almacenamiento temporal mediante el patrón Cache-Aside**. MySQL se mantiene actualmente como la fuente oficial de información del sistema. 

Para el presente diseño arquitectónico se requiere evaluar una evolución hacia una estrategia de **Persistencia Políglota**, incorporando tecnologías especializadas según el tipo de información procesada.

## Decisión

Se propone evolucionar progresivamente hacia la siguiente distribución:

- **PostgreSQL:** futura base de datos relacional principal para información transaccional.
- **MongoDB:** almacenamiento de información documental y estructuras flexibles.
- **Redis:** caché temporal mediante el patrón Cache-Aside.
- **Neo4j:** almacenamiento de relaciones complejas entre entidades cuando las consultas basadas en grafos lo justifiquen.

Durante la transición, MySQL podrá continuar funcionando como base de datos principal hasta que se realice una migración controlada hacia PostgreSQL.

## Consecuencias positivas

- Uso de tecnologías especializadas según el tipo de información.
- Mejor capacidad para manejar distintos modelos de datos.
- Redis reduce consultas repetitivas.
- MongoDB permite manejar documentos con estructuras variables.
- Neo4j facilita análisis de relaciones complejas.
- PostgreSQL proporciona integridad para datos transaccionales.

## Consecuencias negativas

- Mayor complejidad de infraestructura.
- Necesidad de administrar múltiples motores.
- Posibles problemas de sincronización.
- Aumento de esfuerzo en pruebas y mantenimiento.

## Riesgos

El principal riesgo es generar inconsistencias entre las distintas fuentes de datos. Para reducirlo, deberá definirse una fuente autoritativa para cada tipo de información y evitar duplicaciones innecesarias.

## Justificación

La Persistencia Políglota no sustituye inmediatamente la arquitectura actual, sino que representa una evolución planificada para cumplir nuevas necesidades de escalabilidad, flexibilidad y procesamiento especializado.
