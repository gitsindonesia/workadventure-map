# Stage 1: Build the Node.js application
FROM node:16 AS builder

# Set a working directory inside the container
WORKDIR /app

# Copy the rest of the application code to the container
COPY . .

# Install dependencies and build the application
RUN npm install
RUN npm run build

# Stage 2: Create the Nginx server image
FROM nginx:latest

# Copy the built files from the previous stage into the Nginx image
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose the port that Nginx will listen on (typically 80)
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]