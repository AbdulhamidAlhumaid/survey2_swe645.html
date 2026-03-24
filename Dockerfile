FROM nginx:alpine
COPY survey2_swe645.html /usr/share/nginx/html/index.html
EXPOSE 80
