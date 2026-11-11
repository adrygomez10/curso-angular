# Curso de Angular

Proyecto inicial para realizar el curso de Angular con Node, npm y Angular CLI
encapsulados en Docker. El código se edita en esta carpeta; las dependencias y la
caché de npm se guardan en volúmenes Docker.

## Requisitos

- Docker Desktop iniciado, con contenedores Linux y Docker Compose.
- Git para clonar el repositorio y ejecutar los hooks.

Node, npm y Angular CLI se ejecutan dentro del contenedor. Las versiones del
entorno están fijadas: Node **26.13.0 LTS**, npm **11.20.0** y Angular CLI
**22.2.6**. La imagen oficial de Node también se fija por su digest.

## Puesta en marcha

Desde PowerShell o una terminal, en la raíz del repositorio:

```sh
git config --local core.hooksPath .githooks
docker compose build
docker compose run --rm angular npm ci
docker compose up -d
```

Abrir [http://localhost:4200](http://localhost:4200). Los cambios del código se
recargan automáticamente; se utiliza sondeo para detectarlos también en Windows
y OneDrive. El puerto solo se publica en la interfaz local.

El hook está versionado, pero cada clon necesita ejecutar el comando
`git config --local core.hooksPath .githooks`. Docker debe estar iniciado para
hacer commits.

## Comandos habituales

```sh
# Ver los mensajes del servidor
docker compose logs -f angular

# Consultar las versiones
docker compose run --rm angular node --version
docker compose run --rm angular npm --version
docker compose run --rm angular ng version

# Abrir una terminal dentro del contenedor
docker compose exec angular sh

# Generar un componente
docker compose run --rm angular ng generate component features/ejemplo

# Ejecutar las pruebas o la compilación
docker compose run --rm angular npm run test:ci
docker compose run --rm angular npm run build

# Formatear y comprobar todos los controles
docker compose run --rm angular npm run format
docker compose run --rm angular npm run check

# Parar el entorno conservando las dependencias
docker compose down
```

Después de actualizar `package-lock.json` con un pull, ejecutar de nuevo
`docker compose run --rm angular npm ci`. Para añadir dependencias, usar
`docker compose run --rm angular npm install nombre-del-paquete`; `.npmrc`
guarda versiones exactas. Versionar siempre `package.json` y `package-lock.json`
juntos.

## Calidad y commits

El [perfil de estilo](docs/ESTILO.md) describe formato, organización, contratos y
criterios de revisión manual. El precommit bloquea el commit si fallan Prettier,
ESLint, los controles de complejidad y dependencias, TypeScript, las pruebas o la
compilación de producción. GitHub Actions ejecuta exactamente el mismo hook.

El hook obtiene una instantánea del contenido preparado con `git write-tree` y
`git archive`. Construye el entorno desde esa instantánea y la comprueba dentro
de un contenedor aislado, sin montar el directorio de trabajo. Así, las
modificaciones sin preparar no alteran el resultado ni se sobrescriben. La
primera ejecución tarda más porque descarga las dependencias; después reutiliza
la caché de npm y las capas de construcción.

## Estructura

- `src/app`: componentes, configuración y rutas de Angular.
- `public`: recursos estáticos.
- `Dockerfile` y `compose.yaml`: herramientas y entorno de desarrollo.
- `.githooks/pre-commit`: controles sobre el contenido preparado.
- `.github/workflows/ci.yaml`: comprobaciones de integración continua.
- `docs/ESTILO.md`: perfil de estilo y criterios de revisión.

La compatibilidad entre Angular y Node se puede consultar en la
[documentación oficial de Angular](https://angular.dev/reference/versions).
