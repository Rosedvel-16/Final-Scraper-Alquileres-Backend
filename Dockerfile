# Usamos una imagen ligera de Python
FROM python:3.11-slim

# 1. Instalar Chromium y el Driver manualmente (Esto es lo que faltaba)
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    libglib2.0-0 \
    libnss3 \
    libgconf-2-4 \
    libfontconfig1 \
    && rm -rf /var/lib/apt/lists/*

# 2. Preparar la carpeta de trabajo
WORKDIR /app

# 3. Copiar tus archivos al servidor
COPY . .

# 4. Instalar tus librerías (Flask, Selenium, etc.)
RUN pip install --no-cache-dir -r requirements.txt

# 5. Comando para encender el servidor (usando el puerto que Railway asigne)
CMD gunicorn app:app --bind 0.0.0.0:$PORT --log-file -