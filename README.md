# GitLab CI/CD Demo

Проект для демонстрации работы **GitLab CI/CD** с использованием Docker.  
В рамках проекта поднимаются:  
- **GitLab Server** (локально или в контейнере)  
- **GitLab Runner** для выполнения пайплайнов  
- Примерное приложение (Flask + Dockerfile), которое разворачивается через pipeline.  

---

## 📦 Состав проекта



.
├── .gitlab-ci.yml # Конфигурация GitLab CI/CD pipeline
├── Dockerfile # Docker-образ для приложения
├── api.py # Flask-приложение (пример сервиса)
├── requirements.txt # Python-зависимости
├── static/ # Статика (CSS, JS, картинки)
└── templates/ # HTML-шаблоны


---

## 🚀 Цель

Полный цикл CI/CD:  

1. Развернуть GitLab Server и зарегистрировать GitLab Runner (оба через docker контейнеры).  
2. Настроить пайплайн через `.gitlab-ci.yml`.  
3. Собирать Docker-образ и запускать приложение автоматически.  

---

## ⚙️ Развёртывание

### 1. Запуск GitLab Server (через Docker)
```sh
docker run --detach \
  --hostname gitlab.local \
  --publish 8443:443 --publish 8080:80 --publish 2222:22 \
  --name gitlab \
  --restart always \
  --volume $HOME/gitlab/config:/etc/gitlab \
  --volume $HOME/gitlab/logs:/var/log/gitlab \
  --volume $HOME/gitlab/data:/var/opt/gitlab \
  gitlab/gitlab-ce:latest


После запуска GitLab будет доступен по адресу:
👉 http://localhost:8080

###2. Установка GitLab Runner (через Docker)
docker run -d --name gitlab-runner --restart always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $HOME/gitlab-runner/config:/etc/gitlab-runner \
  gitlab/gitlab-runner:latest


Регистрируем Runner:

docker exec -it gitlab-runner gitlab-runner register


Укажите URL вашего GitLab (http://localhost:8080) и токен из настроек проекта.

3. Настройка CI/CD

В .gitlab-ci.yml описаны этапы:

build: сборка Docker-образа

test: проверка зависимостей / запуск приложения

deploy: запуск контейнера с приложением

Pipeline запускается автоматически при каждом push в репозиторий.

##🐳 Запуск приложения в Docker вручную
docker build -t gitlab-ci-cd-demo .
docker run --rm -p 5000:5000 gitlab-ci-cd-demo


Приложение будет доступно по адресу:
👉 http://localhost:5000/image
