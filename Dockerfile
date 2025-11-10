FROM node:20-alpine

WORKDIR /app

# Installa dipendenze di sistema
RUN apk add --no-cache git

# Abilita Corepack per Yarn 4
RUN corepack enable

# Copia tutto il codice
COPY . .

# Inizializza git (necessario per alcuni script postinstall)
RUN git init && git add . && git commit -m "initial"

# Installa tutte le dipendenze
RUN yarn install

# Build solo dell'app dotcom
WORKDIR /app/apps/dotcom
RUN yarn build

EXPOSE 3000

CMD ["yarn", "start"]
