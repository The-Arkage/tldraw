FROM node:20-alpine

WORKDIR /app

# Installa dipendenze di sistema
RUN apk add --no-cache git

# Abilita Corepack per Yarn 4
RUN corepack enable

# Copia package files
COPY package.json yarn.lock .yarnrc.yml ./
COPY .yarn ./.yarn

# Copia tutti i package.json del workspace per il workspace resolution
COPY packages ./packages
COPY apps ./apps
COPY internal ./internal

# Installa tutte le dipendenze normalmente (con build dei pacchetti workspace)
RUN yarn install

# Build solo dell'app dotcom
WORKDIR /app/apps/dotcom
RUN yarn build

EXPOSE 3000

CMD ["yarn", "start"]
