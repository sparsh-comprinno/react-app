# Stage 1: Build the React App
FROM 203918887881.dkr.ecr.us-east-1.amazonaws.com/customnginxalpine:latest AS build

WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm ci --only=production

# Copy the entire project and build the React app
COPY . .
RUN npm run build

# Stage 2: Serve with Nginx
FROM 203918887881.dkr.ecr.us-east-1.amazonaws.com/customnginxalpine:latest

# Copy built files from the previous stage to Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
