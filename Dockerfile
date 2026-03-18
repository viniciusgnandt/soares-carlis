# =====================================================
# Soares & Carlis — Dockerfile
# Stage 1: Build (copy files)
# Stage 2: Serve with Nginx
# =====================================================

FROM nginx:1.25-alpine AS production

# Remove default nginx page
RUN rm -rf /usr/share/nginx/html/*

# Copy site files
COPY index.html       /usr/share/nginx/html/
COPY sitemap.xml      /usr/share/nginx/html/
COPY robots.txt       /usr/share/nginx/html/
COPY css/             /usr/share/nginx/html/css/
COPY js/              /usr/share/nginx/html/js/
COPY images/          /usr/share/nginx/html/images/

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Permissions
RUN chmod -R 755 /usr/share/nginx/html

# Expose HTTP
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
