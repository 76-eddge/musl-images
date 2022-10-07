FROM node:alpine

RUN apk update

RUN apk add libcrypto3 chromium ttf-freefont gradle

RUN apk -UvX https://dl-cdn.alpinelinux.org/alpine/edge/community add powershell

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

COPY "package.json" /home/

RUN cd /home/ && npm install && npm audit

RUN mkdir /tmp/gradle

SHELL ["/usr/bin/pwsh", "-Command"]

RUN New-Item -ItemType "file" -Path "$profile" -Force; Add-Content "$profile" '$env:NODE_PATH = "/usr/local/lib/node_modules"'; Add-Content "$profile" '$env:PUPPETEER_EXECUTABLE_PATH = "/usr/bin/chromium-browser"'

COPY build.gradle /tmp/gradle

RUN cd /tmp/gradle; gradle --no-daemon resolveDependencies