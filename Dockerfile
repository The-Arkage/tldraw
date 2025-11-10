FROM node:20-alpine
WORKDIR /app

RUN apk add --no-cache git python3 make g++
RUN corepack enable

COPY . .

RUN git config --global user.email "build@docker.local" && \
    git config --global user.name "Docker Build" && \
    git init && git add . && git commit -m "initial"

# Installa solo le dipendenze necessarie
RUN yarn install --frozen-lockfile

# Build con focus specifico su dotcom, ignorando errori di altri packages
WORKDIR /app
RUN yarn turbo run build --filter=@tldraw/dotcom... --continue || true

WORKDIR /app/apps/dotcom
EXPOSE 3000
CMD ["yarn", "start"]
