FROM nginx:1.18
COPY index.html /usr/share/nginx/html
COPY project.css /usr/share/nginx/html
COPY login.html /usr/share/nginx/html
COPY register.html /usr/share/nginx/html