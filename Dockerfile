# Usamos la imagen ligera de Python
FROM python:3.11-slim

# 1. Instalar Chromium y dependencias
# (Hemos quitado libgconf-2-4 que causaba el error)
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    libglib2.0-0 \
    libnss3 \
    libfontconfig1 \
    && rm -rf /var/lib/apt/lists/*

# 2. Preparar carpeta
WORKDIR /app

# 3. Copiar archivos
COPY . .

# 4. Instalar librerías de Python
RUN pip install --no-cache-dir -r requirements.txt

# 5. Ejecutar Gunicorn
CMD gunicorn app:app --bind 0.0.0.0:$PORT --timeout 600 --log-file -