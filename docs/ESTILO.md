# Perfil de estilo de la infraestructura

Este repositorio contiene herramientas Docker y una carpeta de trabajo vacía.
Los controles actuales corresponden a esa infraestructura.

- Usar UTF-8, finales LF, dos espacios de indentación y una línea final.
- Prettier **3.9.10** comprueba Markdown, JSON y YAML con una anchura objetivo de
  100 columnas. Mantener juntas las opciones de cada responsabilidad.
- En el Dockerfile, separar con una línea en blanco las fases de instalación,
  configuración del directorio, usuario y comando. Usar cuatro espacios para
  continuar las operaciones de una misma instrucción `RUN`.
- Fijar versiones de herramientas y referencias de imágenes. Ejecutar el
  entorno de trabajo como usuario sin privilegios. Hadolint **2.12.0** revisa
  las instrucciones del Dockerfile.
- Escribir scripts compatibles con POSIX `sh`, entrecomillar las expansiones y
  detenerse ante errores. ShellCheck **0.10.0** comprueba los scripts.
- En los hooks, revisar la instantánea del índice y gestionar los temporales con
  `trap`. Conservar los cambios sin preparar sin usar stash ni reset.
- Separar mediante líneas en blanco preparación, validación y ejecución. Revisar
  manualmente que esas fases agrupan instrucciones con la misma intención y que
  los nombres describen su responsabilidad.

El precommit y CI ejecutan los mismos controles con versiones fijadas. También
se comprueban la construcción y las herramientas del contenedor. Estas
comprobaciones aportan evidencia parcial; la revisión manual sigue siendo
necesaria para valorar responsabilidades, contratos y legibilidad.

Cuando se inicie la aplicación, su perfil y sus controles deberán adaptarse al
lenguaje, las dependencias y el comportamiento que se incorporen.
