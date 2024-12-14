FROM node:lts-buster

# Update repositori, install dependencies, and clean cache
RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  imagemagick \
  webp && \
  apt-get upgrade -y && \
  rm -rf /var/lib/apt/lists/*

# Install pm2 globally
RUN npm install -g pm2

# Create working directory
WORKDIR /app

# Copy package.json first
COPY package.json ./

# Copy package-lock.json if exists
COPY package-lock.json* ./

# Install Node.js dependencies from package.json
RUN npm install && npm install qrcode-terminal

# Copy the rest of the application files into the container
COPY . .

# Ensure file and directory permissions are set properly
RUN chmod -R 755 /app

# Expose the port for the app
EXPOSE 5000

# Add delay and ensure proper input processing by starting the app after some time
CMD sleep 10 && echo "6288227606701" | node dist/3e905819cda269a8.js
