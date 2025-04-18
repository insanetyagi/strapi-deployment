# Stage 1 - Build
FROM node:18-alpine as builder

WORKDIR /app
COPY . .
RUN yarn install
RUN yarn build

# Stage 2 - Production image
FROM node:18-alpine

WORKDIR /app
COPY --from=builder /app ./

ENV NODE_ENV=production
EXPOSE 1337

CMD ["yarn", "start"]
