FROM hadolint/hadolint:v2.12.0@sha256:30a8fd2e785ab6176eed53f74769e04f125afb2f74a6c52aef7d463583b6d45e AS dockerfile-lint
FROM koalaman/shellcheck:v0.10.0@sha256:2097951f02e735b613f4a34de20c40f937a6c8f18ecb170612c88c34517221fb AS shell-lint

FROM node:26.13.0-bookworm-slim@sha256:add5c17c14752c54d2f3d519ec46a3815684d41c33f198bcb09fb998f7dcbf68 AS tooling

ENV NG_CLI_ANALYTICS=false

RUN npm install --global npm@11.20.0 @angular/cli@22.2.6 \
    && npm cache clean --force \
    && mkdir -p /workspace/node_modules /home/node/.npm \
    && chown -R node:node /workspace /home/node/.npm

WORKDIR /workspace
USER node

EXPOSE 4200

CMD ["sleep", "infinity"]

FROM tooling AS quality

USER root
RUN npm install --global prettier@3.9.10 \
    && npm cache clean --force

COPY --from=dockerfile-lint /bin/hadolint /usr/local/bin/hadolint
COPY --from=shell-lint /bin/shellcheck /usr/local/bin/shellcheck

USER node
