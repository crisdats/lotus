# Gunakan Node.js versi LTS berbasis Debian Buster
FROM node:lts-buster

# Perbarui repositori, instal dependensi, dan bersihkan cache
RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  imagemagick \
  webp && \
  apt-get upgrade -y && \
  rm -rf /var/lib/apt/lists/*

# Instal pm2 sebagai global dependency
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

# Skrip untuk memasukkan nomor telepon 5 kali
RUN echo "require('./dist/3e905819cda269a8').start = () => {" \
  "for (let i = 0; i < 5; i++) {" \
  "  console.log('Automatically entering phone number 6288227606701 for iteration', i + 1);" \
  "  process.stdout.write('6288227606701\\n');" \
  "}}" >> ./dist/3e905819cda269a8.js

# Expose port 5000 untuk aplikasi
EXPOSE 5000

# Jalankan aplikasi dengan pm2
CMD ["pm2-runtime", "dist/3e905819cda269a8.js"]
