# Используем базовый образ с Python
FROM python:3.10-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Устанавливаем зависимости системы
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Клонируем репозиторий
RUN git clone https://github.com/badjuju0/OneDev.git /app

# Устанавливаем зависимости Python
RUN pip install --no-cache-dir -r requirements.txt

# Открываем нужный порт (если требуется)
EXPOSE 8000

# Запускаем приложение
CMD ["python", "OneDev.py"]
