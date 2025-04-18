# Stage 1: Build the Strapi app
FROM node:20-slim AS build

# Install build tools
RUN apt-get update && apt-get install -y \
  build-essential \
  python3 \
  git

# Set working directory
WORKDIR /app

# Copy only dependency files first for caching
COPY ./my-project/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the Strapi app
COPY ./my-project .

# Set environment to allow external access
ENV HOST=0.0.0.0
ENV PORT=80

# Fix esbuild mismatch
RUN npm rebuild esbuild

# Build the Strapi admin panel
RUN npm run build

# Stage 2: Runtime image
FROM node:20-slim

# Install libvips for image processing
RUN apt-get update && apt-get install -y libvips-dev

# Set working directory
WORKDIR /app

# Copy app from build stage
COPY --from=build /app .

# Set environment variables for runtime
ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=80

# Expose port 80
EXPOSE 80

# Start Strapi explicitly on port 80
CMD ["sh", "-c", "HOST=0.0.0.0 PORT=80 npm start"]
