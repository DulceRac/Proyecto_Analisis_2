# ADR-001 – Adopción de Arquitectura Monolítica Modular

## Estado

Aceptado.

## Contexto

El módulo CRM requiere una arquitectura que permita organizar funcionalidades como autenticación, contactos, clientes, proveedores, persistencia y caché, manteniendo una solución sencilla de desarrollar, probar y desplegar.

Se evaluaron alternativas como arquitectura en capas, microservicios y arquitectura orientada a eventos. Debido al tamaño y alcance actual del sistema, adoptar microservicios introduciría una complejidad operativa innecesaria.

## Decisión

Se adopta una **Arquitectura Monolítica Modular**, donde el sistema se despliega como una única aplicación, pero mantiene una separación lógica entre sus diferentes módulos.

Cada módulo tendrá responsabilidades claramente definidas y evitará dependencias innecesarias con otros módulos.

## Consecuencias positivas

- Menor complejidad de despliegue.
- Mayor facilidad para desarrollar y probar el sistema.
- Separación clara de responsabilidades.
- Facilita el mantenimiento del código.
- Permite una futura migración de módulos hacia servicios independientes.

## Consecuencias negativas

- Todos los módulos comparten el mismo despliegue.
- Un fallo crítico puede afectar a toda la aplicación.
- La escalabilidad independiente de módulos es limitada.
- Una mala separación entre módulos puede aumentar el acoplamiento.

## Alternativas consideradas

- Arquitectura en Capas.
- Microservicios.
- Arquitectura Orientada a Eventos.
- Arquitectura basada en Repositorio.

## Justificación

La Arquitectura Monolítica Modular proporciona el equilibrio más adecuado entre simplicidad, mantenibilidad, desempeño y posibilidad de crecimiento para el alcance actual del CRM.
