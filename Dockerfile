FROM node:20-alpine

WORKDIR /app

# Installa dipendenze di sistema
RUN apk add --no-cache git

# Abilita Corepack per Yarn 4
RUN corepack enable

# Copia tutto il codice
COPY . .

# Configura git e inizializza repository
RUN git config --global user.email "build@docker.local" && \
    git config --global user.name "Docker Build" && \
    git init && \
    git add . && \
    git commit -m "initial"

# Installa tutte le dipendenze
RUN yarn install

# Build solo dell'app dotcom
WORKDIR /app/apps/dotcom
RUN yarn build

EXPOSE 3000

CMD ["yarn", "start"]
