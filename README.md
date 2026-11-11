# Curso de Angular

Infraestructura Docker para trabajar con Node, npm y Angular CLI. La carpeta
`workspace/` queda preparada para crear el proyecto siguiendo el curso.

## Requisitos y versiones

Se necesita Docker Desktop iniciado con contenedores Linux y Docker Compose,
además de Git para versionar los cambios. Las herramientas se ejecutan dentro
del contenedor: Node **26.13.0 LTS**, npm **11.20.0** y Angular CLI **22.2.6**.

## Arrancar el entorno

Desde la raíz del repositorio:

```sh
git config --local core.hooksPath .githooks
docker compose up -d --build
docker compose exec angular sh
```

La terminal del contenedor se abre en `/workspace`, que corresponde a
`workspace/` en el equipo. El contenedor permanece en espera y no inicia ningún
servidor. Las dependencias y la caché de npm se guardan en volúmenes Docker.

Para consultar las versiones o parar el entorno:

```sh
docker compose exec angular node --version
docker compose exec angular npm --version
docker compose exec angular ng version
docker compose down
```

## Crear el proyecto cuando comiences el curso

Estos comandos son una referencia para ejecutarlos cuando quieras iniciar tú el
proyecto. Desde la terminal del contenedor, puedes crearlo en la carpeta de
trabajo y elegir las opciones que correspondan al curso:

```sh
ng new curso-angular --directory . --skip-git
```

`--skip-git` conserva el repositorio de la infraestructura como único repositorio.
Los archivos generados aparecerán en `workspace/`.

Cuando el proyecto esté creado, puedes arrancar su servidor desde esa terminal:

```sh
ng serve --host 0.0.0.0 --port 4200 --poll 1000
```

Entonces estará disponible en [http://localhost:4200](http://localhost:4200). El
puerto se publica solo en la interfaz local y el sondeo permite detectar cambios
en Windows y OneDrive.

## Controles de infraestructura

El precommit y GitHub Actions comprueban la configuración de Compose, construyen
la imagen, ejecutan Hadolint, ShellCheck y Prettier, y verifican que las
herramientas están disponibles. El [perfil de estilo](docs/ESTILO.md) documenta
las reglas y la revisión manual.

El hook revisa una instantánea del contenido preparado para el commit y conserva
los cambios sin preparar. Está instalado en este clon; al clonar de nuevo hay
que ejecutar `git config --local core.hooksPath .githooks`. Docker debe estar
iniciado para hacer commits.

Estos controles se limitan a la infraestructura. Al crear la aplicación habrá
que incorporar sus reglas de estilo, lint, tipado, arquitectura y pruebas según
el código del curso.
