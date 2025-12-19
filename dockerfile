

# build stage
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . . 
# Run the application as a non-root user.
RUN npm run build


# Prod
FROM nginx:alpine
COPY --from=builder  /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g" , "daemon off;"]



