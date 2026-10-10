# Product Backlog – Módulo CRM

## Marco de trabajo

El proyecto utiliza Scrum como marco principal de gestión, complementado con prácticas Kanban para visualizar el estado de las actividades.

## Product Owner / Analista

El Product Owner es responsable de priorizar el backlog, definir necesidades funcionales, aclarar requerimientos y validar los criterios de aceptación.

## Historias de Usuario

| ID | Historia de Usuario | Prioridad |
|---|---|---|
| HU-01 | Como usuario, quiero iniciar sesión para acceder de forma segura al sistema. | Alta |
| HU-02 | Como usuario, quiero registrar contactos para almacenar su información en el CRM. | Alta |
| HU-03 | Como usuario, quiero consultar contactos para visualizar la información registrada. | Alta |
| HU-04 | Como usuario, quiero actualizar contactos para mantener sus datos vigentes. | Alta |
| HU-05 | Como usuario autorizado, quiero eliminar contactos para retirar registros innecesarios. | Media |
| HU-06 | Como usuario, quiero clasificar contactos como clientes o proveedores para organizar la información. | Alta |
| HU-07 | Como usuario, quiero buscar y filtrar contactos para localizar información rápidamente. | Media |
| HU-08 | Como administrador, quiero gestionar permisos para controlar las operaciones disponibles. | Media |

## Modelo 3C

| ID | Card | Conversation | Confirmation |
|---|---|---|---|
| **HU-01** | Como usuario, quiero iniciar sesión para acceder de forma segura al CRM. | Se utilizarán correo y contraseña. La cuenta debe estar activa y, si las credenciales son correctas, se generará un JWT. | Credenciales válidas → `200`; inválidas → `401`; datos con formato incorrecto → `422`. |
| **HU-02** | Como usuario, quiero registrar contactos para almacenar su información. | Se requieren tipo, nombre, apellido y teléfono. Se validarán los datos antes de almacenarlos. | Datos válidos → `201`; datos inválidos → `422`; el contacto queda registrado. |
| **HU-03** | Como usuario, quiero consultar contactos para visualizar la información registrada. | La consulta requiere JWT y debe respetar los permisos del usuario. Puede utilizar Redis mediante Cache-Aside. | Token válido → `200`; token inválido → `401`; se devuelve únicamente información autorizada. |
| **HU-04** | Como usuario, quiero actualizar contactos para mantener sus datos vigentes. | Solo podrán modificarse contactos existentes y autorizados. La actualización deberá invalidar la caché correspondiente. | Actualización correcta → `200`; inexistente → `404`; datos inválidos → `422`. |
| **HU-05** | Como usuario autorizado, quiero desactivar contactos que ya no sean necesarios. | Se realizará eliminación lógica para conservar el historial del registro. | Operación válida → `200`; contacto inexistente → `404`; acceso no autorizado → `403`. |
| **HU-06** | Como usuario, quiero clasificar contactos como clientes o proveedores. | Un cliente requiere `codigo_cliente`; un proveedor requiere los datos específicos correspondientes. | La clasificación válida se almacena correctamente; información incompleta → `422`. |
| **HU-07** | Como usuario, quiero buscar y filtrar contactos para localizar información rápidamente. | Se podrá filtrar por datos como nombre, tipo y otros criterios disponibles en la API. | La búsqueda válida → `200`; sin coincidencias → lista vacía sin producir error. |
| **HU-08** | Como administrador, quiero gestionar permisos para controlar las operaciones disponibles. | Los permisos dependen del rol del usuario. Las operaciones restringidas deben comprobar autorización. | Administrador autorizado → operación permitida; usuario sin permisos → `403 Forbidden`. |

## Validación INVEST

Las Historias de Usuario buscan cumplir con:

- Independent.
- Negotiable.
- Valuable.
- Estimable.
- Small.
- Testable.

## Definition of Ready – DoR

Una Historia de Usuario puede iniciar cuando:

- Está claramente definida.
- Tiene prioridad asignada.
- Incluye criterios de aceptación.
- Sus dependencias están identificadas.
- Puede estimarse.
- No posee dudas funcionales críticas.

## Definition of Done – DoD

Una Historia de Usuario se considera terminada cuando:

- La funcionalidad está implementada.
- Cumple los criterios de aceptación.
- Las pruebas fueron ejecutadas correctamente.
- Los endpoints relacionados funcionan.
- La documentación está actualizada.
- No existen defectos críticos abiertos.

## Tablero Ágil

Enlace al tablero del proyecto:

https://miumg-team-jyz2q05z.atlassian.net/jira/software/projects/SCRUM/boards/1/backlog?atlOrigin=eyJpIjoiM2JkZTMxZDIwYzliNDg5NGJmZTcxMzhkMDJhNjZjZDQiLCJwIjoiaiJ9
