# Perfil de estilo y revisión

Este proyecto utiliza TypeScript estricto, componentes standalone de Angular y CSS.
Las reglas mecánicas se comprueban con las versiones de Prettier, ESLint,
typescript-eslint y angular-eslint fijadas en `package.json` y `package-lock.json`.

## Formato y organización

- Indentación de dos espacios, sin tabulaciones; archivos UTF-8 y finales LF.
- Comillas simples en TypeScript, punto y coma y comas finales.
- Anchura objetivo de 100 columnas. Prettier distribuye argumentos, objetos y
  expresiones cuando necesitan varias líneas.
- Imports explícitos; imports de tipos con `import type`. Ordenar los símbolos
  dentro de cada import y separar con una línea en blanco dependencias externas
  e imports del proyecto.
- Clases y tipos en PascalCase; funciones, propiedades y variables en camelCase.
  Usar nombres que describan su responsabilidad y evitar abreviaturas ambiguas.
- Un componente por archivo y los nombres breves de Angular: `app.ts`, `app.html`,
  `app.css` y `app.spec.ts`. Agrupar futuras funcionalidades en carpetas dentro
  de `src/app`; evitar carpetas genéricas con responsabilidades mezcladas.
- Ordenar miembros por accesibilidad y naturaleza con la regla
  `@typescript-eslint/member-ordering`. Declarar propiedades antes de métodos y
  mantener próximos los miembros que colaboran en una misma responsabilidad.
- Usar una línea en blanco entre fases distintas: validación, preparación,
  ejecución y construcción del resultado. Mantener juntas las instrucciones de
  una misma fase. Esta agrupación por intención se revisa manualmente.

## Contratos y dependencias

Mantener contratos tipados y validar los datos externos en el adaptador que los
recibe. Evitar `any`, promesas sin manejar y aserciones de tipo que oculten datos
inválidos. Declarar el tipo de retorno de las funciones de producción; los
callbacks permiten la inferencia del contexto.

ESLint limita la complejidad ciclomática a 10, la profundidad a 3 y las funciones
a 80 líneas de código. También impide que producción importe módulos de pruebas
o herramientas. Las pruebas viven junto al componente y terminan en `.spec.ts`.
Estos límites deben favorecer responsabilidades cohesionadas; no justifican
fragmentar una operación en funciones sin significado.

En las futuras funcionalidades, los componentes coordinan la presentación y los
servicios encapsulan operaciones con recursos externos. Gestionar las
suscripciones según el ciclo de vida de Angular, representar estados de error
explícitos y evitar duplicar reglas de negocio en plantillas y servicios.

## Controles y revisión manual

El precommit ejecuta formato, lint, comprobación de tipos, pruebas sin modo watch
y compilación de producción. CI invoca el mismo hook. Las dependencias se instalan
con `npm ci` a partir del bloqueo versionado.

Antes de entregar, revisar también nombres, responsabilidades, dirección de las
dependencias, agrupación visual, tratamiento de errores y pruebas de los cambios
de comportamiento. El formato, el lint y una suite correcta aportan controles
parciales; no certifican por sí solos todo Clean Code ni preparación para producción.
