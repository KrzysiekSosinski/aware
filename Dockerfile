FROM node:21.1.0 as builder

WORKDIR /ngfp-awareness

COPY package*.json ./

RUN NODE_ENV=development npm install

COPY . .


RUN npx nx run ngfp-awareness:build:production --baseHref=/mf-awareness/ --deployUrl=/mf-awareness/

#Download NGINX Image
FROM nginx:stable-alpine AS runtime

RUN apk update && apk add --no-cache su-exec openssl busybox libxml2 dav1d libxpm zlib

RUN rm -rf /usr/share/nginx/html/*

#Copy built angular files to NGINX HTML folder
COPY --from=builder /ngfp-awareness/dist/ngfp-awareness/ /usr/share/nginx/html/mf-awareness

COPY nginx-prod.conf /etc/nginx/nginx-prod.conf
COPY nginx-test.conf /etc/nginx/nginx-test.conf

RUN mkdir -p /etc/nginx/logs /var/cache/nginx/client_temp /run/nginx /var/log/nginx \
    && chown -R nginx:nginx /var/cache/nginx /etc/nginx/logs /run/nginx /var/log/nginx /etc/nginx

RUN chmod u+s /sbin/su-exec

COPY nginx-test-config-script.sh /usr/local/bin/nginx-test-config-script.sh
RUN chmod u+x /usr/local/bin/nginx-test-config-script.sh
RUN chown nginx:nginx /usr/local/bin/nginx-test-config-script.sh

USER nginx

EXPOSE 8083

ARG NGINX_CONFIG

ENTRYPOINT ["/usr/local/bin/nginx-test-config-script.sh"]
