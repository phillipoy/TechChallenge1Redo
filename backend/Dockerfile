# Uses Node.js as the backend runtime
FROM node:18

# Sets the working directory inside the container
WORKDIR /app

# Copies dependency files first
COPY package*.json ./

# Installs backend dependencies
RUN npm install

# Copies backend source code
COPY . .

# Exposes backend port
EXPOSE 5000

# Starts the backend server
CMD ["npm", "start"]