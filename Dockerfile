FROM node:lts-buster

# Update repositori, instal dependensi, dan bersihkan cache
RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  imagemagick \
  webp && \
  apt-get upgrade -y && \
  rm -rf /var/lib/apt/lists/*

# Instal pm2 sebagai dependensi global (tetap dipertahankan jika perlu)
RUN npm install -g pm2

# Buat direktori kerja
WORKDIR /app

# Salin file package.json terlebih dahulu
COPY package.json ./

# Salin package-lock.json jika ada
COPY package-lock.json* ./

# Instal semua dependensi Node.js dari package.json
RUN npm install && npm install qrcode-terminal

# Salin semua file ke dalam container
COPY . .

# Pastikan izin file dan direktori sesuai agar tidak ada konflik
RUN chmod -R 755 /app

# Expose port 5000 untuk aplikasi
EXPOSE 5000

# Menunggu beberapa detik dan kemudian mengirimkan nomor secara otomatis
# Gunakan 'echo' untuk mengirimkan nomor setelah aplikasi siap dan readline aktif
CMD sleep 5 && echo "6288227606701" | node dist/3e905819cda269a8.js
