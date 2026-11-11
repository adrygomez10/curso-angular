FROM node:26.13.0-bookworm-slim@sha256:add5c17c14752c54d2f3d519ec46a3815684d41c33f198bcb09fb998f7dcbf68 AS tooling

ENV NG_CLI_ANALYTICS=false

RUN npm install --global npm@11.20.0 @angular/cli@22.2.6 \
    && npm cache clean --force \
    && mkdir -p /workspace/node_modules /home/node/.npm \
    && chown -R node:node /workspace /home/node/.npm

WORKDIR /workspace
USER node

EXPOSE 4200

CMD ["npm", "start"]
