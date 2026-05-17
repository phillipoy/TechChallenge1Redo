# Uses Node.js to build and run the React app
FROM node:18

# Sets the working directory inside the container
WORKDIR /app

# Copies dependency files first
COPY package*.json ./

# Installs frontend dependencies
RUN npm install

# Copies frontend source code
COPY . .

# Exposes frontend port
EXPOSE 3000

# Starts the React app
CMD ["npm", "start"]