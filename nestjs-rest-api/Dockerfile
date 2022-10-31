# Base image
FROM node:16

# Create app directory
WORKDIR /usr/src/app

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

# Install app dependencies
RUN npm install --force

# Bundle app source
COPY . .

COPY .env.prod .env

# Creates a "dist" folder with the production build
RUN npm run build

RUN rm .env.prod .env .env-example

# Start the server using the production build
CMD [ "node", "dist/main.js" ]