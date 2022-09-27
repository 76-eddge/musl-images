FROM node:alpine

RUN apk update

RUN apk add libcrypto3 chromium

RUN apk -UvX https://dl-cdn.alpinelinux.org/alpine/edge/community add powershell

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

RUN cd /home/node && npm install puppeteer rehype-raw rehype-slug rehype-stringify remark remark-gfm remark-html remark-rehype github-slugger && npm audit

SHELL ["/usr/bin/pwsh", "-Command"]

RUN New-Item -ItemType "file" -Path "$profile" -Force; Add-Content "$profile" '$env:NODE_PATH = "/usr/local/lib/node_modules"'; Add-Content "$profile" '$env:PUPPETEER_EXECUTABLE_PATH = "/usr/bin/chromium-browser"'