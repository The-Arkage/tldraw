FROM node:20-alpine

WORKDIR /app

# git serve per gli script postinstall
RUN apk add --no-cache git

# usa yarn via corepack
RUN corepack enable

# copia il monorepo
COPY . .

# hack per far felici gli script che si aspettano un repo git
RUN git config --global user.email "build@docker.local" && \
    git config --global user.name "Docker Build" && \
    git init && git add . && git commit -m "initial"

# install dipendenze monorepo
RUN yarn install

# builda il client dotcom
WORKDIR /app/apps/dotcom/client
RUN yarn build

# vite preview gira su 3000
EXPOSE 3000

# usa lo script start del client
CMD ["yarn", "start"]
