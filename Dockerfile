# Builder phase
# Use an existing docker image as a base
FROM node:16-alpine as builder

# Download and install a dependancy
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .

# Tell the image what to do when it starts as a containers
RUN npm run build

# Run phase
# Use an existing docker image as a base
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html