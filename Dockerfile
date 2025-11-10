FROM node:20-alpine

WORKDIR /app

# Abilita Corepack per Yarn 4
RUN corepack enable

# Copia package files
COPY package.json yarn.lock .yarnrc.yml ./
COPY .yarn ./.yarn

# Installa dipendenze del workspace root
RUN yarn install --immutable

# Copia il resto del codice
COPY . .

# Build della specifica app
WORKDIR /app/apps/dotcom
RUN yarn build

EXPOSE 3000

CMD ["yarn", "start"]
